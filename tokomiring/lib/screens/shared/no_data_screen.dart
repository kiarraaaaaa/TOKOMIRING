// lib/screens/shared/no_data_screen.dart

import 'package:flutter/material.dart';

class NoDataScreen extends StatelessWidget {
  final String message;

  const NoDataScreen({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.inbox_outlined,
            size: 100,
            color: Colors.grey,
          ),

          const SizedBox(height: 20),

          Text(
            message,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
