// lib/widgets/forms/payment_method_selector.dart

import 'package:flutter/material.dart';

class PaymentMethodSelector
    extends StatelessWidget {
  final String selectedMethod;

  final Function(String) onChanged;

  const PaymentMethodSelector({
    super.key,
    required this.selectedMethod,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        paymentTile(
          title: 'Cash',

          icon: Icons.money,

          value: 'Cash',
        ),

        const SizedBox(height: 12),

        paymentTile(
          title: 'QRIS',

          icon: Icons.qr_code,

          value: 'QRIS',
        ),
      ],
    );
  }

  Widget paymentTile({
    required String title,
    required IconData icon,
    required String value,
  }) {
    return RadioListTile(
      value: value,

      groupValue: selectedMethod,

      onChanged: (value) {
        onChanged(value.toString());
      },

      title: Text(title),

      secondary: Icon(icon),
    );
  }
}