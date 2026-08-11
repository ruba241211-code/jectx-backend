from fastapi import FastAPI

from project_data import project_data
from project_details import router as project_router

from database import create_users_table
from auth import router as auth_router
from idea_generator import router as idea_router

# --------------------------------------------------
# CREATE FASTAPI APP
# --------------------------------------------------

app = FastAPI(
    title="JECTX API",
    version="1.0.0"
)


# --------------------------------------------------
# CREATE DATABASE TABLE
# --------------------------------------------------

create_users_table()


# --------------------------------------------------
# INCLUDE ROUTERS
# --------------------------------------------------

# Project Details API
app.include_router(project_router)

# Idea Generator APIs
app.include_router(idea_router)

# Authentication APIs
app.include_router(auth_router)


# --------------------------------------------------
# ROOT
# --------------------------------------------------

@app.get("/")
def root():
    return {
        "message": "JECTX Backend is running!"
    }


# --------------------------------------------------
# GET DOMAINS
# --------------------------------------------------

@app.get("/domains")
def get_domains():

    return {
        "domains": list(project_data.keys())
    }


# --------------------------------------------------
# GET PROJECTS
# --------------------------------------------------

@app.get("/projects/{domain}/{level}")
def get_projects(
    domain: str,
    level: str
):

    # Check domain
    if domain not in project_data:
        return {
            "error": "Domain not found"
        }

    # Check level
    if level not in project_data[domain]:
        return {
            "error": "Level not found"
        }

    return {
        "domain": domain,
        "level": level,
        "projects": project_data[domain][level]
    }