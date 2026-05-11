// lib/widgets/buttons/cart_button.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';

import '../../providers/cart_provider.dart';

class CartButton
    extends StatelessWidget {

  final VoidCallback onPressed;

  final Color? backgroundColor;

  final Color? iconColor;

  final bool showTotalPrice;

  // =====================================================
  // CONSTRUCTOR
  // =====================================================

  const CartButton({

    super.key,

    required this.onPressed,

    this.backgroundColor,

    this.iconColor,

    this.showTotalPrice =
        false,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    return Consumer<CartProvider>(

      builder: (

        context,

        cartProvider,

        child,

      ) {

        return GestureDetector(

          onTap:
              onPressed,

          child: Container(

            padding:
                const EdgeInsets.symmetric(

              horizontal: 14,

              vertical: 10,
            ),

            decoration:
                BoxDecoration(

              color:
                  backgroundColor ??

                      Colors.white,

              borderRadius:
                  BorderRadius.circular(
                18,
              ),

              boxShadow: [

                BoxShadow(

                  color:
                      Colors.black
                          .withOpacity(
                    0.06,
                  ),

                  blurRadius:
                      14,

                  offset:
                      const Offset(
                    0,
                    6,
                  ),
                ),
              ],
            ),

            child: Row(

              mainAxisSize:
                  MainAxisSize.min,

              children: [

                // =====================================
                // ICON + BADGE
                // =====================================

                Stack(

                  clipBehavior:
                      Clip.none,

                  children: [

                    Icon(

                      Icons.shopping_cart_rounded,

                      color:
                          iconColor ??

                              AppColors
                                  .dark,

                      size: 28,
                    ),

                    // =================================
                    // BADGE
                    // =================================

                    if (cartProvider
                            .totalItems >
                        0)

                      Positioned(

                        right: -8,

                        top: -8,

                        child: Container(

                          constraints:
                              const BoxConstraints(

                            minWidth:
                                22,

                            minHeight:
                                22,
                          ),

                          padding:
                              const EdgeInsets.symmetric(

                            horizontal:
                                6,

                            vertical:
                                2,
                          ),

                          decoration:
                              const BoxDecoration(

                            color:
                                Colors.red,

                            shape:
                                BoxShape.circle,
                          ),

                          alignment:
                              Alignment.center,

                          child: Text(

                            cartProvider
                                .totalItems
                                .toString(),

                            style:
                                const TextStyle(

                              color:
                                  Colors.white,

                              fontSize:
                                  11,

                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),

                // =====================================
                // TOTAL PRICE
                // =====================================

                if (showTotalPrice &&
                    cartProvider
                            .totalItems >
                        0) ...[

                  const SizedBox(
                    width: 12,
                  ),

                  Column(

                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    mainAxisSize:
                        MainAxisSize.min,

                    children: [

                      const Text(

                        'Cart',

                        style: TextStyle(

                          fontSize: 12,

                          color:
                              Colors.grey,
                        ),
                      ),

                      Text(

                        '${cartProvider.totalItems} items',

                        style:
                            const TextStyle(

                          fontSize: 13,

                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}