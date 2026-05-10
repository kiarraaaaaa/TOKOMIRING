// lib/screens/auth/welcome_screen.dart

import 'package:flutter/material.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff0F172A),
              Color(0xff1E293B),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Center(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/tokomiring.png',
                height: 220,
              ),

              const SizedBox(height: 30),

              const Text(
                'TOKO MIRING',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Realtime Ecommerce Management',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 50),

              SizedBox(
                width: 250,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Get Started',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
