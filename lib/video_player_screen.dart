import 'dart:typed_data';

import 'package:ffmpeg_assignment/Utils/bytes_to_url.dart';
import 'package:ffmpeg_assignment/constants.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class VideoPlayerScreen extends StatefulWidget {
  final Uint8List bytes;

  const VideoPlayerScreen({super.key, required this.bytes});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  VideoPlayerController? _compressedController;
  int? responseLength;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(bytesToUrl(widget.bytes),
        formatHint: VideoFormat.dash)
      ..initialize().then((_) => setState(() {}));
  }

  Future<void> compressVideo(
    List<int> bytes, {
    required bool isBlackAndWhite,
  }) async {
    final url = Uri.parse(isBlackAndWhite
        ? AppConstants.blackAndWhite
        : AppConstants.compressUrl);
    final request = http.MultipartRequest('POST', url);

    // add video bytes as a file to the request body
    final videoFile = http.MultipartFile.fromBytes(
      'video',
      bytes,
      filename: 'video.mp4',
    );
    request.files.add(videoFile);

    // send the request
    var response = await request.send();
    final responseBytes = await response.stream.toBytes();

    _compressedController = VideoPlayerController.network(
        bytesToUrl(responseBytes),
        formatHint: VideoFormat.dash)
      ..initialize().then(
        (_) => setState(
          () => responseLength = responseBytes.lengthInBytes,
        ),
      );

    if (response.statusCode == 200) {
      print('Video uploaded successfully');
    } else {
      print('Error uploading video: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _controller.value.isInitialized
                  ? SizedBox(
                      width: 500,
                      height: 500,
                      child: VideoPlayer(_controller),
                    )
                  : Container(),
              Text('Size : ${widget.bytes.lengthInBytes} bytes'),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () async => await compressVideo(widget.bytes,
                          isBlackAndWhite: false),
                      child: const Text("Compress")),
                  ElevatedButton(
                      onPressed: () async => await compressVideo(widget.bytes,
                          isBlackAndWhite: true),
                      child: const Text("Black and white"))
                ],
              )
            ],
          ),
          Column(
            children: [
              _compressedController != null
                  ? SizedBox(
                      width: 500,
                      height: 500,
                      child: VideoPlayer(_compressedController!),
                    )
                  : Container(),
              responseLength == null
                  ? const SizedBox()
                  : Text('Size : $responseLength bytes'),
              _compressedController != null
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _compressedController!.value.isPlaying
                              ? _compressedController!.pause()
                              : _compressedController!.play();
                        });
                      },
                      child: Text(_compressedController!.value.isPlaying
                          ? 'Pause'
                          : 'Play'),
                    )
                  : const SizedBox()
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          _controller.value.isPlaying
              ? _controller.pause()
              : _controller.play();
        }),
        child:
            Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}
