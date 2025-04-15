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

class TattooRequest(BaseModel):
    prompt: str
    style: TattooStyle
    output_location: OutputLocation
