import 'package:flutter/material.dart';
// import 'package:nav1/doctor_home_screen.dart';
// import 'package:nav1/homepage.dart';
import 'package:nav1/welcome.dart';
// import 'homepage.dart';

void main() {
  runApp(const ShifaApp());
}

class ShifaApp extends StatelessWidget {
  const ShifaApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
