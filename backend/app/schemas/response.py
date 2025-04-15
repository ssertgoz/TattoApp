from pydantic import BaseModel

class TattooResponse(BaseModel):
    image_url: str
