import uuid
import bcrypt
from fastapi import Depends, HTTPException
from database import get_db
from models.user import User
from pydantic_schemas.user_create import UserCreate
from fastapi import APIRouter
from sqlalchemy.orm import session

from pydantic_schemas.user_login import UserLogin

router = APIRouter()

@router.post('/signup', status_code= 201)
def signup_user(user : UserCreate, db: session = Depends(get_db)):
    user_db = db.query(User).filter(User.email==user.email).first()
    if user_db:
        raise HTTPException(400, 'User with same email already exist')
        return 

    h_pass = bcrypt.hashpw(user.password.encode(), bcrypt.gensalt())
    user_db = User(id=str(uuid.uuid4()),email=user.email, password= h_pass, name=user.name)
    db.add(user_db)
    db.commit()
    db.refresh(user_db)

    return user_db

@router.post('/login')
def login_user(user: UserLogin , db: session = Depends(get_db)):
    user_db = db.query(User).filter(User.email==user.email).first()
    if not user_db:
        raise HTTPException(400, "user does not exist")
    
    is_matching = bcrypt.checkpw(user.password.encode(),user_db.password)

    if not is_matching:
        raise HTTPException(400, "Incorrect password")
        
    return user_db