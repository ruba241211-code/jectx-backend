import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    checkLoginStatus();
  }

  // ==================================================
  // CHECK LOGIN STATUS
  // ==================================================

  Future<void> checkLoginStatus() async {

    // Show splash for 2 seconds
    await Future.delayed(
      const Duration(seconds: 2),
    );

    final loggedIn = await AuthService.isLoggedIn();

    if (!mounted) return;

    // ==================================================
    // USER ALREADY LOGGED IN
    // ==================================================

    if (loggedIn) {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );

    }

    // ==================================================
    // USER NOT LOGGED IN
    // ==================================================

    else {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blue,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            // LOGO
            const Icon(
              Icons.school,
              size: 80,
              color: Colors.white,
            ),

            const SizedBox(height: 20),

            // APP NAME
            const Text(
              "JECTX",
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 3,
              ),
            ),

            const SizedBox(height: 10),

            // TAGLINE
            const Text(
              "All-in-One Student Platform",
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 30),

            // LOADING
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}