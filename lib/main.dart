import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const JectxApp());
}

class JectxApp extends StatelessWidget {
  const JectxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  LoginScreen(),
    );
  }
}