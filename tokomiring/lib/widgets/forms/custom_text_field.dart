// lib/widgets/forms/custom_text_field.dart

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;

  final String hintText;

  final String? labelText;

  final IconData? prefixIcon;

  final bool obscureText;

  final TextInputType keyboardType;

  final String? Function(String?)? validator;

  final int maxLines;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.labelText,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,

      obscureText: obscureText,

      keyboardType: keyboardType,

      validator: validator,

      maxLines: maxLines,

      decoration: InputDecoration(
        hintText: hintText,

        labelText: labelText,

        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon)
            : null,
      ),
    );
  }
}