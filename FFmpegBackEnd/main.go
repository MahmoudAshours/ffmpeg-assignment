package main

import (
	"bytes"
	"io"
	"log"
	"net/http"
	"os"
	"os/exec"
)

func compressHandler(w http.ResponseWriter, r *http.Request) {
	// Read the input data from the request body
	var inputData bytes.Buffer

	reader, _ := r.MultipartReader()
	f, _, _ := r.FormFile("video")
	print(f)

	for {
		part, err := reader.NextPart()
		if err == io.EOF {
			break
		}
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		// check if this part is a file
		if part.FileName() != "" {
			// read the contents of the file into a byte slice
			buf := new(bytes.Buffer)
			if _, err := io.Copy(buf, part); err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}
			inputData = *buf

		}
	}
	print(inputData.String())

	// Compress the input data using ffmpeg
	cmd := exec.Command("ffmpeg", "-y", "-i", "pipe:0", "-vcodec", "libx264", "-crf", "25", "-acodec", "aac", "-f", "mp4", "-movflags", "empty_moov", "pipe:")
	cmd.Stdin = &inputData
	var compressedData bytes.Buffer
	stdout, err := cmd.StdoutPipe()

	cmd.Stderr = os.Stderr

	err = cmd.Start()

	if err != nil {
		http.Error(w, "Error compressing data", http.StatusInternalServerError)
		return
	}

	// // Write the compressed data to the response
	w.Header().Set("Content-Type", "application/octet-stream")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	// // w.Header().Set("Content-Disposition", "attachment; filename=output.mp4")
	print(len(compressedData.Bytes()))
	io.Copy(w, stdout)
}

func grayScaleHandler(w http.ResponseWriter, r *http.Request) {
	// Read the input data from the request body
	var inputData bytes.Buffer

	reader, _ := r.MultipartReader()
	f, _, _ := r.FormFile("video")
	print(f)

	for {
		part, err := reader.NextPart()
		if err == io.EOF {
			break
		}
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		// check if this part is a file
		if part.FileName() != "" {
			// read the contents of the file into a byte slice
			buf := new(bytes.Buffer)
			if _, err := io.Copy(buf, part); err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}
			inputData = *buf

		}
	}
	print(inputData.String())

	// Compress the input data using ffmpeg
	cmd := exec.Command("ffmpeg", "-y", "-i", "pipe:0", "-vf", "format=gray", "-f", "mp4", "-movflags", "empty_moov", "pipe:")
	cmd.Stdin = &inputData
	var compressedData bytes.Buffer
	stdout, err := cmd.StdoutPipe()

	cmd.Stderr = os.Stderr

	err = cmd.Start()

	if err != nil {
		http.Error(w, "Error compressing data", http.StatusInternalServerError)
		return
	}

	// // Write the compressed data to the response
	w.Header().Set("Content-Type", "application/octet-stream")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	// // w.Header().Set("Content-Disposition", "attachment; filename=output.mp4")
	print(len(compressedData.Bytes()))
	io.Copy(w, stdout)
}
func main() {
	http.HandleFunc("/compress", compressHandler)
	http.HandleFunc("/black_and_white", grayScaleHandler)
	log.Fatal(http.ListenAndServe(":8000", nil))
}
