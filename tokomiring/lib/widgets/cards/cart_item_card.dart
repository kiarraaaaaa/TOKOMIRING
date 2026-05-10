import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const CartItemCard({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
