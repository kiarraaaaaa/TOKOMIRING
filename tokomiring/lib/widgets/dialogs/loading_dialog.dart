// lib/widgets/dialogs/loading_dialog.dart

import 'package:flutter/material.dart';

class LoadingDialog {
  static void show(
    BuildContext context, {
    String message = 'Loading...',
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20),
          ),
          child: Padding(
            padding:
                const EdgeInsets.all(24),
            child: Row(
              mainAxisSize:
                  MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),

                const SizedBox(width: 20),

                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void hide(
    BuildContext context,
  ) {
    Navigator.pop(context);
  }
}