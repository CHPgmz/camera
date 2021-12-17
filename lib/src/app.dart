
import 'package:camara/apis/home.dart';
import 'package:camara/src/pages/home_screen.dart';
// import 'package:camara/src/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red,
      ),
    );
  }
}
