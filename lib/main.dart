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
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'home_screen.dart';

late List<CameraDescription> _cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
  runApp(MyApp(cameras: _cameras));
}
