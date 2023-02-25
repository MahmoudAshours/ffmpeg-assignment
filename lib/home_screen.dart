import 'dart:html';
import 'dart:typed_data';
import 'dart:html' as html;

import 'package:camera/camera.dart';
import 'package:ffmpeg_assignment/home.dart';
import 'package:ffmpeg_assignment/route_generator.dart';
import 'package:ffmpeg_assignment/routes.dart';
import 'package:ffmpeg_assignment/video_player_screen.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:video_player/video_player.dart';

class MyApp extends StatefulWidget {
  final List cameras;
  const MyApp({super.key, required this.cameras});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute,
      title: 'Video',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Home(cameras: widget.cameras),
    );
  }
}
