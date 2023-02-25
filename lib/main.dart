import 'package:camera/camera.dart';
import 'package:ffmpeg_assignment/Screens/app.dart';
import 'package:flutter/material.dart';
 
late List<CameraDescription> _cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
  runApp(MyApp(cameras: _cameras));
}
