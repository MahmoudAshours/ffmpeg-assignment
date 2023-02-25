import 'package:ffmpeg_assignment/Screens/home.dart';
import 'package:ffmpeg_assignment/route_generator.dart';
import 'package:flutter/material.dart';

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
