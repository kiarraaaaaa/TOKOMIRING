// lib/widgets/dialogs/error_dialog.dart

import 'package:flutter/material.dart';

class ErrorDialog {
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
  }) async {
    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20),
          ),

          title: Column(
            children: const [
              Icon(
                Icons.error,
                color: Colors.red,
                size: 70,
              ),

              SizedBox(height: 12),
            ],
          ),

          content: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                message,
                textAlign:
                    TextAlign.center,
              ),
            ],
          ),

          actions: [
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.red,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Close',
              ),
            ),
          ],
        );
      },
    );
  }
}
