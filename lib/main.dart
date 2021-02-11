import 'package:flutter/material.dart';
import 'package:flutter_video_player_demo/home_screen.dart';
import 'package:flutter_video_player_demo/splash_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Splash(),
    );
  }
}

