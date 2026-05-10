// lib/widgets/dialogs/image_preview_dialog.dart

import 'package:flutter/material.dart';

class ImagePreviewDialog {
  static Future<void> show(
    BuildContext context, {
    required String imageUrl,
  }) async {
    await showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          backgroundColor:
              Colors.transparent,

          child: Stack(
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(
                  20,
                ),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                ),
              ),

              Positioned(
                top: 10,
                right: 10,
                child: CircleAvatar(
                  backgroundColor:
                      Colors.black54,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                      );
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}