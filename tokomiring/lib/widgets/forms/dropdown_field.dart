// lib/widgets/forms/dropdown_field.dart

import 'package:flutter/material.dart';

class DropdownField extends StatelessWidget {
  final String value;

  final List<String> items;

  final Function(String?) onChanged;

  final String hint;

  const DropdownField({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,

      decoration: InputDecoration(
        hintText: hint,
      ),

      items: items
          .map(
            (item) =>
                DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),

      onChanged: onChanged,
    );
  }
}