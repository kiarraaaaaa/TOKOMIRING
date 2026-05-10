// lib/widgets/buttons/cart_button.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';

class CartButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CartButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (
        context,
        cartProvider,
        child,
      ) {
        return Stack(
          children: [
            IconButton(
              onPressed: onPressed,

              icon: const Icon(
                Icons.shopping_cart,
              ),
            ),

            if (cartProvider.totalItems >
                0)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding:
                      const EdgeInsets.all(6),

                  decoration:
                      const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),

                  child: Text(
                    cartProvider.totalItems
                        .toString(),

                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}