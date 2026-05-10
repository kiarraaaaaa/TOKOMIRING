// lib/widgets/forms/quantity_selector.dart

import 'package:flutter/material.dart';

class QuantitySelector
    extends StatelessWidget {
  final int quantity;

  final VoidCallback onIncrease;

  final VoidCallback onDecrease;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(16),

        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onDecrease,

            icon: const Icon(
              Icons.remove,
            ),
          ),

          Text(
            quantity.toString(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          IconButton(
            onPressed: onIncrease,

            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
    );
  }
}