from fastapi import APIRouter, HTTPException
from app.schemas.request import TattooRequest
from app.schemas.response import TattooResponse
from app.services.tattoo_service import TattooService

router = APIRouter()
tattoo_service = TattooService()

@router.post("/generate", response_model=TattooResponse)
async def generate_tattoo(request: TattooRequest):
    try:
        image_url = await tattoo_service.generate_tattoo(
            prompt=request.prompt,
            style=request.style,
            output_location=request.output_location
        )
        return TattooResponse(image_url=image_url)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
