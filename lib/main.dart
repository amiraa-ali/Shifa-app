import 'package:flutter/material.dart';
import 'package:shifa/welcome.dart';
// import 'homepage.dart';

const String UserName = "Amira Ali ";

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
      // home: HomeScreen(),
    );
  }
}
