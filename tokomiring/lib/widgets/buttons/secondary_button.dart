// lib/widgets/buttons/secondary_button.dart

import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String text;

  final VoidCallback onPressed;

  final IconData? icon;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: OutlinedButton(
        onPressed: onPressed,

        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: Color(0xff2563EB),
            width: 1.5,
          ),

          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(18),
          ),
        ),

        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: const Color(
                  0xff2563EB,
                ),
              ),

            if (icon != null)
              const SizedBox(width: 10),

            Text(
              text,
              style: const TextStyle(
                color: Color(0xff2563EB),
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
