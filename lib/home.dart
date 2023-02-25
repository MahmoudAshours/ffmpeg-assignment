import 'package:flutter/material.dart';
import 'dart:html';
import 'dart:typed_data';
import 'dart:html' as html;

import 'package:camera/camera.dart';
import 'package:ffmpeg_assignment/route_generator.dart';
import 'package:ffmpeg_assignment/routes.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:video_player/video_player.dart';

class Home extends StatefulWidget {
  final List cameras;

  const Home({super.key, required this.cameras});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late CameraController _controller;
  bool isRecording = false;
  Uint8List? videoData;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.cameras[0], ResolutionPreset.max);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 500,
              height: 500,
              child: CameraPreview(_controller),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => isRecording
                      ? _stopVideoRecording()
                      : _startVideoRecording(),
                  child: Text(isRecording ? 'Stop' : 'Record')),
              const SizedBox(width: 15),
              videoData != null
                  ? ElevatedButton(
                      onPressed: () => Navigator.pushNamed(
                          context, '/video_player',
                          arguments: {"data": "$videoData"}),
                      child: const Text('Preview'),
                    )
                  : const SizedBox()
            ],
          )
        ],
      ),
    );
  }

  Future<void> _startVideoRecording() async {
    try {
      await _controller.startVideoRecording();
      setState(() => isRecording = true);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _stopVideoRecording() async {
    try {
      // Stop recording video.
      final file = await _controller.stopVideoRecording();
      final bytes = await file.readAsBytes();
      setState(() {
        videoData = bytes;
        isRecording = false;
      });
    } catch (e) {
      print(e);
    }
  }
}
