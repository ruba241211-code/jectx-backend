from fastapi import APIRouter
from pydantic import BaseModel

from gemini_service import generate_project_ideas


router = APIRouter()


class IdeaRequest(BaseModel):
    field: str
    level: str


@router.post("/generate-project-ideas")
def generate_ideas(request: IdeaRequest):

    try:

        result = generate_project_ideas(
            request.field,
            request.level,
        )

        return result

    except Exception as e:

        return {
            "error": str(e)
        }