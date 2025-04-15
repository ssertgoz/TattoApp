import os
import replicate
from dotenv import load_dotenv

load_dotenv()

class TattooService:
    def __init__(self):
        self.api_token = os.getenv("REPLICATE_API_TOKEN")
        if not self.api_token:
            raise ValueError("REPLICATE_API_TOKEN not found in environment variables")
        
        # Initialize Replicate client with API token
        self.client = replicate.Client(api_token=self.api_token)
        
        # Using Stable Diffusion XL model for high-quality tattoo generation
        self.model = "stability-ai/sdxl:39ed52f2a78e934b3ba6e2a89f5b1c712de7dfea535525255b1aa35c5565e08b"

    async def generate_tattoo(self, prompt: str, style: str, output_location: str) -> str:
        # Enhance prompt based on style and location
        enhanced_prompt = self._enhance_prompt(prompt, style, output_location)
        
        try:
            # Generate image using Replicate client
            output = self.client.run(
                self.model,
                input={
                    "prompt": enhanced_prompt,
                    "negative_prompt": "blurry, low quality, distorted, deformed",
                    "num_inference_steps": 50,
                    "guidance_scale": 7.5,
                }
            )
            
            # Replicate returns a list of image URLs, we take the first one
            if output and isinstance(output, list) and len(output) > 0:
                return output[0]
            raise Exception("No image was generated")
            
        except Exception as e:
            raise Exception(f"Error generating tattoo: {str(e)}")

    def _enhance_prompt(self, prompt: str, style: str, output_location: str) -> str:
        """Enhance the user prompt with style and location context"""
        style_prompts = {
            "blackwork": "black ink tattoo design, bold lines, high contrast",
            "geometric": "geometric tattoo design, clean lines, symmetrical patterns",
            "minimalist": "minimalist tattoo design, simple lines, elegant"
        }
        
        location_prompts = {
            "back": "photorealistic tattoo on a person's back, centered on bare skin, professional photography, studio lighting",
            "leg": "photorealistic tattoo on a person's leg, visible on skin, professional photography, studio lighting",
            "whitepaper": "tattoo design on white paper, clean background, professional photography"
        }

        style_context = style_prompts[style]
        location_context = location_prompts[output_location]

        return f"{prompt}, {style_context}, {location_context}, highly detailed, realistic tattoo placement, 8k quality"
