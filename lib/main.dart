
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

late List<CameraDescription> _cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
  runApp(MyApp(cameras: _cameras));
}
