// lib/widgets/forms/search_field.dart

import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final Function(String) onChanged;

  const SearchField({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,

      decoration: InputDecoration(
        hintText: 'Search products...',

        prefixIcon: const Icon(
          Icons.search,
        ),

        suffixIcon: const Icon(
          Icons.tune,
        ),

        filled: true,

        fillColor: Colors.white,

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(18),

          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}