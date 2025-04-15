from enum import Enum
from pydantic import BaseModel

class TattooStyle(str, Enum):
    BLACKWORK = "blackwork"
    GEOMETRIC = "geometric"
    MINIMALIST = "minimalist"

class OutputLocation(str, Enum):
    LEG = "leg"
    BACK = "back"
    WHITEPAPER = "whitepaper"

class ImageAspectRatio(str, Enum):
    SQUARE = "square"
    PORTRAIT = "portrait"
    LANDSCAPE = "landscape"

class TattooRequest(BaseModel):
    prompt: str
    style: TattooStyle
    output_location: OutputLocation
    aspect_ratio: ImageAspectRatio
