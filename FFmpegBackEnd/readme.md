## FFMPEGBackEnd

 
## Installation
Make sure you have [ffmpeg](https://ffmpeg.org/download.html) installed on your system.

## Clone the repository to your local machine.
 
Run the following command to start the server:

> go run main.go

## Usage

Compressing Video
You can use the /compress endpoint to compress a video file. The endpoint expects a multipart/form-data POST request with the video file as the form data.

Example usage:

```bash

curl -X POST -F "file=@video.mp4" http://localhost:8000/compress > compressed.mp4

```

Grayscaling Video
You can use the /black_and_white endpoint to grayscale a video file. The endpoint expects a multipart/form-data POST request with the video file as the form data.
