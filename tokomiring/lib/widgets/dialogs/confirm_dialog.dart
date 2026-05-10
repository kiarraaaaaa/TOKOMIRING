// lib/widgets/dialogs/confirm_dialog.dart

import 'package:flutter/material.dart';

class ConfirmDialog {
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
  }) async {
    bool result = false;

    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20),
          ),

          title: Text(
            title,
            style: const TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          content: Text(message),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);

                result = false;
              },
              child: const Text(
                'Cancel',
              ),
            ),

            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.red,
              ),
              onPressed: () {
                Navigator.pop(context);

                result = true;
              },
              child: const Text(
                'Confirm',
              ),
            ),
          ],
        );
      },
    );

    return result;
  }
}