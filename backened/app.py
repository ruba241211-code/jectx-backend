from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from project_data import project_data
from paper_database import paper_database

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
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

    papers = paper_database.get(project, [])

    return {
        "project": project,
        "papers": papers
    }
import uvicorn

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)