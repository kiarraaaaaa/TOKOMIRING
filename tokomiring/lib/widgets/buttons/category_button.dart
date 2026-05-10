// lib/widgets/buttons/category_button.dart

import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String title;

  final bool isSelected;

  final VoidCallback onTap;

  const CategoryButton({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration:
            const Duration(milliseconds: 250),

        padding:
            const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),

        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xff2563EB)
              : Colors.white,

          borderRadius:
              BorderRadius.circular(16),

          border: Border.all(
            color: isSelected
                ? const Color(0xff2563EB)
                : Colors.grey.shade300,
          ),
        ),

        child: Text(
          title,

          style: TextStyle(
            color: isSelected
                ? Colors.white
                : Colors.black,

            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),
    );
  }
}