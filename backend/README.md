# Tattoo Generator Backend

This is the backend service for the AI Tattoo Generator application. It uses FastAPI and Replicate API to generate tattoo designs based on user prompts and preferences.

## Setup

1. Install dependencies:
```bash
pip install -r requirements.txt
```

2. Set up environment variables:
Create a `.env` file with:
```
REPLICATE_API_TOKEN=your_token_here
```

3. Run the server:
```bash
uvicorn app.main:app --reload
```

## API Endpoints

### Generate Tattoo
- **Endpoint**: `/api/v1/generate`
- **Method**: POST
- **Request Body**:
```json
{
    "prompt": "string",
    "style": "blackwork|geometric|minimalist",
    "output_location": "leg|back|whitepaper"
}
```
- **Response**:
```json
{
    "image_url": "string"
}
```

## Architecture
The project follows clean architecture principles:
- `app/main.py`: Application entry point and FastAPI configuration
- `app/routers/`: API route handlers
- `app/schemas/`: Pydantic models for request/response validation
- `app/services/`: Business logic and external service integration
