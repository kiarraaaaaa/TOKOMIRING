// lib/widgets/buttons/primary_button.dart

import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;

  final VoidCallback onPressed;

  final bool isLoading;

  final IconData? icon;

  final double height;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.height = 55,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed:
            isLoading ? null : onPressed,

        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child:
                    CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  if (icon != null)
                    Icon(icon),

                  if (icon != null)
                    const SizedBox(width: 10),

                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
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
