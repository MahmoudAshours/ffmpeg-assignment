# FFMPEG_Assignment

FFMPEG Assignment is a flutter web task that : 

- Opens the camera on web and records a video.
- Navigate to a new page that displays the recorded video with play/pause controls.
- Compresses the video using FFmpeg via backend.
- Displays the size of the original video and the compressed video.
- Displays the video in grayscale view.


In order to run the application :

## Setting up the front-end (flutter side) :

## On Mac

### For running flutter built files : 

### Run the following terminal command to start up an apache server:

> sudo apachectl start

Then, move the contents of [compressed zip file](https://github.com/MahmoudAshours/ffmpeg-assignment/releases/download/release/release.zip) to /Library/WebServer/Documents/


- Now, navigate web browser to localhost.

- Once done, kill the apache server with the following command:

> sudo apachectl graceful-stop


### On Windows

Download [XAMPP](https://www.apachefriends.org/), install, allow it to run on local networks if prompted, then launch the XAMPP app (it will likely have launched on its own).

- In the XAMPP app, find the row for "Apache" and click the "Start" button to start up the web server

- Move the contents of [compressed zip file](https://github.com/MahmoudAshours/ffmpeg-assignment/releases/download/release/release.zip) to C:/xampp/htdocs/

(Note: Index.html base href should be "/" if you had previously modified it)

Now navigate web browser to 127.0.0.1/index.html

Once done, open the XAMPP app and click "stop" on the Apache row.



# Setup the backend server 

- Navigate to the [FFMPEGbackEnd](https://github.com/MahmoudAshours/ffmpeg-assignment/releases/download/release/FFmpegBackEnd.zip) directory 
- Run `go run main.go`


## Setup ffmpeg 

Make sure you have [ffmpeg](https://ffmpeg.org/download.html) installed on your system.

Then you should be good to go.


Screenshots : 
<img width="1440" alt="Screenshot 2023-02-26 at 2 06 20 AM" src="https://user-images.githubusercontent.com/50237142/221385221-16effafd-cf08-4338-92da-fa3fe3898745.png">
<img width="1440" alt="Screenshot 2023-02-26 at 2 06 13 AM" src="https://user-images.githubusercontent.com/50237142/221385223-fde8ba5d-5fa2-4d05-a0df-e0f794e66a90.png">
<img width="1440" alt="Screenshot 2023-02-26 at 2 06 02 AM" src="https://user-images.githubusercontent.com/50237142/221385224-8e451198-c7b9-4765-93fe-e557bf6160a2.png">

