from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.responses import HTMLResponse
from google.cloud import vision
import os

# Set the path to your Google Cloud service account credentials
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "vigilance.json"

app = FastAPI()

@app.post("/extract-text/")
async def extract_text(file: UploadFile = File(...)):
    # Read the image file
    image_content = await file.read()

    # Create a Vision client
    client = vision.ImageAnnotatorClient()

    # Prepare the image for the Vision API
    image = vision.Image(content=image_content)

    # Call the Google Cloud Vision API to detect text
    try:
        response = client.text_detection(image=image)
        texts = response.text_annotations

        # Check if any text was found
        if texts:
            extracted_text = texts[0].description  # Get the first text block
            return {"extracted_text": extracted_text}
        else:
            return {"extracted_text": "No text found."}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error extracting text: {str(e)}")

@app.get("/")
async def main():
    return HTMLResponse(
        """
        <html>
            <head>
                <title>Image Text Extractor</title>
            </head>
            <body>
                <h1>Image Text Extractor using Google Cloud Vision</h1>
                <form action="/extract-text/" method="post" enctype="multipart/form-data">
                    <input type="file" name="file" accept=".jpg,.jpeg,.png" required>
                    <button type="submit">Upload</button>
                </form>
            </body>
        </html>
        """
    )

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000)


# pip install fastapi uvicorn python-multipart google-cloud-vision
# uvicorn app:app --reload
