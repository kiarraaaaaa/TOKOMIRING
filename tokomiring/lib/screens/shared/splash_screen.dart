// lib/screens/shared/splash_screen.dart

import 'package:flutter/material.dart';

import '../auth/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const WelcomeScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff2563EB),
              Color(0xff7C3AED),
            ],
          ),
        ),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/tokomiring.png',
              height: 220,
            ),

            const SizedBox(height: 30),

            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
