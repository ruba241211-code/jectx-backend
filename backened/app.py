from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import requests

from project_data import project_data

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
def home():
    return {
        "message": "Welcome to JECTX API!"
    }


@app.get("/project-ideas")
def project_ideas(
    field: str = "AI",
    level: str = "Beginner"
):

    projects = project_data.get(field, {}).get(level, [])

    return {
        "field": field,
        "difficulty": level,
        "projects": projects
    }


@app.get("/search-papers")
def search_papers(project: str):

    url = "https://api.crossref.org/works"

    params = {
    "query": project,
    "rows": 5,
    "filter": "type:journal-article",
    "sort": "relevance"
    }
    try:
        response = requests.get(url, params=params, timeout=15)
        response.raise_for_status()

        data = response.json()

        papers = []

        for item in data.get("message", {}).get("items", []):

            title = ""
            if item.get("title"):
                title = item["title"][0]

            year = ""

            if item.get("published-print"):
                year = item["published-print"]["date-parts"][0][0]
            elif item.get("published-online"):
                year = item["published-online"]["date-parts"][0][0]
            elif item.get("created"):
                year = item["created"]["date-parts"][0][0]

            authors = []

            for author in item.get("author", []):
                given = author.get("given", "")
                family = author.get("family", "")
                full_name = f"{given} {family}".strip()
                if full_name:
                    authors.append(full_name)

            papers.append({
                "title": title,
                "authors": authors,
                "year": year,
                "url": item.get("URL", "")
            })

        return {
            "project": project,
            "papers": papers
        }

    except requests.exceptions.RequestException as e:
        return {
            "project": project,
            "papers": [],
            "error": str(e)
        }


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(
        app,
        host="0.0.0.0",
        port=8000
    )