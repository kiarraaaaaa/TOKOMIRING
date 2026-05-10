// lib/screens/shared/maintenance_screen.dart

import 'package:flutter/material.dart';

class MaintenanceScreen
    extends StatelessWidget {
  const MaintenanceScreen({
    super.key,
  });

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
          ),
        ),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.build_circle,
              size: 130,
              color: Colors.white,
            ),

            const SizedBox(height: 30),

            const Text(
              'System Maintenance',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'We are improving the system.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Refresh',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
