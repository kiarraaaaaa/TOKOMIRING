// lib/widgets/buttons/icon_text_button.dart

import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  final String text;

  final IconData icon;

  final VoidCallback onPressed;

  final Color color;

  const IconTextButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.color = const Color(0xff2563EB),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,

      icon: Icon(icon),

      label: Text(
        text,
      ),

      style: ElevatedButton.styleFrom(
        backgroundColor: color,

        foregroundColor: Colors.white,

        padding:
            const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),

        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(16),
        ),
      ),
    );
  }
}