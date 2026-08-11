from fastapi import APIRouter
from pydantic import BaseModel
import bcrypt

from database import get_connection


router = APIRouter()


# --------------------------------------------------
# REQUEST MODELS
# --------------------------------------------------

class SignupRequest(BaseModel):
    name: str
    email: str
    password: str


class LoginRequest(BaseModel):
    email: str
    password: str


# --------------------------------------------------
# SIGN UP
# --------------------------------------------------

@router.post("/signup")
def signup(request: SignupRequest):

    connection = get_connection()

    try:

        email = request.email.strip().lower()

        # Check if email already exists
        existing_user = connection.execute(
            """
            SELECT id
            FROM users
            WHERE email = ?
            """,
            (email,)
        ).fetchone()

        if existing_user:

            return {
                "success": False,
                "message": "An account with this email already exists."
            }

        # Hash password
        password_hash = bcrypt.hashpw(
            request.password.encode("utf-8"),
            bcrypt.gensalt()
        ).decode("utf-8")

        # Save user
        connection.execute(
            """
            INSERT INTO users (name, email, password)
            VALUES (?, ?, ?)
            """,
            (
                request.name.strip(),
                email,
                password_hash
            )
        )

        connection.commit()

        return {
            "success": True,
            "message": "Account created successfully."
        }

    except Exception as e:

        return {
            "success": False,
            "message": str(e)
        }

    finally:

        connection.close()


# --------------------------------------------------
# LOGIN
# --------------------------------------------------

@router.post("/login")
def login(request: LoginRequest):

    connection = get_connection()

    try:

        email = request.email.strip().lower()

        # Find user by email
        user = connection.execute(
            """
            SELECT id, name, email, password
            FROM users
            WHERE email = ?
            """,
            (email,)
        ).fetchone()

        # User doesn't exist
        if user is None:

            return {
                "success": False,
                "message": "Invalid email or password."
            }

        stored_password_hash = user["password"]

        # Check password
        password_correct = bcrypt.checkpw(
            request.password.encode("utf-8"),
            stored_password_hash.encode("utf-8")
        )

        if not password_correct:

            return {
                "success": False,
                "message": "Invalid email or password."
            }

        # Login successful
        return {
            "success": True,
            "message": "Login successful.",
            "user": {
                "id": user["id"],
                "name": user["name"],
                "email": user["email"]
            }
        }

    finally:

        connection.close()