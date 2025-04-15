# Tattoo App

A full-stack application for generating AI-powered tattoo designs. The app consists of a Flutter mobile application and a FastAPI backend service.

## Demo Video

https://github.com/user-attachments/assets/6f24265c-218c-4879-a7fc-eda9fc2cd5af



## Features

- Generate AI-powered tattoo designs based on user prompts
- Choose from different tattoo styles (Blackwork, Geometric, Minimalist)
- Select output location (Back, Leg, Whitepaper)
- Customize image aspect ratio (Square, Portrait, Landscape)
- Save generated designs to device gallery
- High-quality image generation using Stable Diffusion XL

## Project Structure

```
TattoApp/
├── backend/                 # FastAPI backend service
│   ├── app/
│   │   ├── api/            # API endpoints
│   │   ├── schemas/        # Pydantic models
│   │   ├── services/       # Business logic
│   │   └── main.py         # FastAPI application entry point
│   └── requirements.txt    # Python dependencies
│
└── tatto_app_mobile/       # Flutter mobile application
    ├── lib/
    │   ├── core/          # Core functionality
    │   ├── features/      # Feature modules
    │   └── main.dart      # App entry point
    └── pubspec.yaml       # Flutter dependencies
```

## Backend (FastAPI)

The backend service is built with FastAPI and uses Replicate's Stable Diffusion XL model for image generation.

### Setup

1. Navigate to the backend directory:
   ```bash
   cd backend
   ```

2. Create a virtual environment and activate it:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Create a `.env` file with your Replicate API token:
   ```
   REPLICATE_API_TOKEN=your_api_token_here
   ```

5. Run the server:
   ```bash
   uvicorn app.main:app --reload
   ```

### API Endpoints

- `POST /api/v1/generate`
  - Generates a tattoo design based on user input
  - Request body:
    ```json
    {
      "prompt": "your tattoo description",
      "style": "blackwork|geometric|minimalist",
      "output_location": "back|leg|whitepaper",
      "aspect_ratio": "square|portrait|landscape"
    }
    ```
  - Returns the URL of the generated image

## Mobile App (Flutter)

The mobile app is built with Flutter and provides a user-friendly interface for generating and saving tattoo designs.

### Setup

1. Navigate to the mobile app directory:
   ```bash
   cd tatto_app_mobile
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Update the API configuration in `lib/core/config/api_config.dart` with your backend URL

4. Run the app:
   ```bash
   flutter run
   ```

### Features

- **Tattoo Generation**
  - Enter a prompt describing your desired tattoo
  - Select from predefined styles
  - Choose the output location
  - Customize the aspect ratio
  - Generate high-quality designs

- **Gallery Integration**
  - Save generated designs to device gallery
  - View saved designs in device gallery

## Technologies Used

### Backend
- FastAPI
- Replicate API (Stable Diffusion XL)
- Python 3.8+
- Pydantic
- Uvicorn

### Mobile App
- Flutter
- Dio (HTTP client)
- Image Gallery Saver
- Provider (State management)

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
