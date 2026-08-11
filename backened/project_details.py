from fastapi import APIRouter
from pydantic import BaseModel
from gemini_service import generate_project_details as ai_generate_project_details

router = APIRouter()


class ProjectRequest(BaseModel):
    title: str
    project_type: str


@router.post("/generate-project-details")
def generate_project_details(request: ProjectRequest):
    try:
        print("========== REQUEST RECEIVED ==========")
        print(request.title)
        print(request.project_type)

        project = ai_generate_project_details(
            request.title,
            request.project_type,
        )

        print("========== GEMINI FINISHED ==========")

        return project

    except Exception as e:
        print("========== ERROR ==========")
        print(e)

        return {
            "error": str(e)
        }