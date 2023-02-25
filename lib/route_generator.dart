import 'dart:convert';
import 'dart:typed_data';

import 'package:ffmpeg_assignment/home.dart';
import 'package:ffmpeg_assignment/routes.dart';
import 'package:ffmpeg_assignment/video_player_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case RoutesName.SECOND_PAGE:
        final data = ((arguments as Map)['data']) as String;

        return _GeneratePageRoute(
          widget: VideoPlayerScreen(bytes: Uint8List.fromList(json.decode(data).cast<int>())),
          routeName: settings.name!,
        );
      default:
        return _GeneratePageRoute(
          widget: Home(cameras: arguments as List<dynamic>),
          routeName: settings.name!,
        );
    }
  }
}

class _GeneratePageRoute extends PageRouteBuilder {
  final Widget widget;
  final String routeName;
  _GeneratePageRoute({required this.widget, required this.routeName})
      : super(
            settings: RouteSettings(name: routeName),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return widget;
            },
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return SlideTransition(
                textDirection: TextDirection.rtl,
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            });
}
