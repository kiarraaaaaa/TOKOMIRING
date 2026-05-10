// lib/screens/shared/not_found_screen.dart

import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 120,
              color: Colors.red,
            ),

            const SizedBox(height: 20),

            const Text(
              'Page Not Found',
              style: TextStyle(
                fontSize: 30,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'The page you are looking for does not exist.',
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Go Back',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
