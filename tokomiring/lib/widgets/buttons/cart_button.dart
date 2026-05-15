// =====================================================
// lib/widgets/buttons/cart_button.dart
// ULTRA PREMIUM FLOATING CART BUTTON
// COMPACT + AESTHETIC + MODERN VERSION
// =====================================================

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_format.dart';

import '../../providers/cart_provider.dart';

class CartButton
    extends StatefulWidget {

  final VoidCallback onPressed;

  final Color? backgroundColor;

  final Color? iconColor;

  final bool showTotalPrice;

  const CartButton({

    super.key,

    required this.onPressed,

    this.backgroundColor,

    this.iconColor,

    this.showTotalPrice =
        false,
  });

  @override
  State<CartButton>
      createState() =>
          _CartButtonState();
}

class _CartButtonState
    extends State<CartButton> {

  bool hovered = false;

  @override
  Widget build(
    BuildContext context,
  ) {

    final width =
        MediaQuery.of(context)
            .size
            .width;

    final isMobile =
        width < 700;

    return Consumer<CartProvider>(

      builder: (

        context,

        cartProvider,

        child,

      ) {

        if (cartProvider
            .isEmpty) {

          return const SizedBox
              .shrink();
        }

        return MouseRegion(

          onEnter: (_) {

            setState(() {

              hovered = true;
            });
          },

          onExit: (_) {

            setState(() {

              hovered = false;
            });
          },

          child:
              AnimatedContainer(

            duration:
                const Duration(
              milliseconds:
                  220,
            ),

            transform:
                Matrix4.identity()
                  ..translate(
                    0.0,
                    hovered
                        ? -2
                        : 0,
                  ),

            width:

                widget.showTotalPrice

                    ? (isMobile
                        ? width * 0.90
                        : 300)

                    : null,

            child: Material(

              color:
                  Colors.transparent,

              child: InkWell(

                borderRadius:
                    BorderRadius.circular(
                  24,
                ),

                onTap:
                    widget.onPressed,

                child:
                    ClipRRect(

                  borderRadius:
                      BorderRadius.circular(
                    24,
                  ),

                  child:
                      BackdropFilter(

                    filter:
                        ImageFilter.blur(

                      sigmaX: 8,

                      sigmaY: 8,
                    ),

                    child:
                        AnimatedContainer(

                      duration:
                          const Duration(
                        milliseconds:
                            220,
                      ),

                      padding:
                          EdgeInsets.symmetric(

                        horizontal:

                            isMobile
                                ? 14
                                : 16,

                        vertical:

                            isMobile
                                ? 12
                                : 13,
                      ),

                      decoration:
                          BoxDecoration(

                        gradient:
                            LinearGradient(

                          begin:
                              Alignment.topLeft,

                          end:
                              Alignment.bottomRight,

                          colors: [

                            widget.backgroundColor ??

                                const Color(
                                  0xff2563EB,
                                ),

                            const Color(
                              0xff1D4ED8,
                            ),

                            const Color(
                              0xff1E40AF,
                            ),
                          ],
                        ),

                        borderRadius:
                            BorderRadius.circular(
                          24,
                        ),

                        border: Border.all(

                          color:
                              Colors.white
                                  .withOpacity(
                            0.10,
                          ),
                        ),

                        boxShadow: [

                          BoxShadow(

                            color:
                                Colors.blue
                                    .withOpacity(

                              hovered
                                  ? 0.28
                                  : 0.18,
                            ),

                            blurRadius:

                                hovered
                                    ? 24
                                    : 16,

                            offset:
                                Offset(
                              0,
                              hovered
                                  ? 12
                                  : 8,
                            ),
                          ),
                        ],
                      ),

                      child: Row(

                        mainAxisSize:

                            widget.showTotalPrice

                                ? MainAxisSize
                                    .max

                                : MainAxisSize
                                    .min,

                        children: [

                          // =================================
                          // ICON
                          // =================================

                          Stack(

                            clipBehavior:
                                Clip.none,

                            children: [

                              AnimatedContainer(

                                duration:
                                    const Duration(
                                  milliseconds:
                                      220,
                                ),

                                width:
                                    hovered
                                        ? 46
                                        : 42,

                                height:
                                    hovered
                                        ? 46
                                        : 42,

                                decoration:
                                    BoxDecoration(

                                  color:
                                      Colors.white
                                          .withOpacity(
                                    0.14,
                                  ),

                                  borderRadius:
                                      BorderRadius.circular(
                                    16,
                                  ),
                                ),

                                child: Icon(

                                  Icons
                                      .shopping_bag_rounded,

                                  color:
                                      widget.iconColor ??

                                          Colors
                                              .white,

                                  size:
                                      20,
                                ),
                              ),

                              Positioned(

                                right: -4,

                                top: -4,

                                child:
                                    AnimatedContainer(

                                  duration:
                                      const Duration(
                                    milliseconds:
                                        220,
                                  ),

                                  padding:
                                      const EdgeInsets.symmetric(

                                    horizontal:
                                        6,

                                    vertical:
                                        3,
                                  ),

                                  decoration:
                                      BoxDecoration(

                                    color:
                                        Colors.red,

                                    borderRadius:
                                        BorderRadius.circular(
                                      30,
                                    ),

                                    border:
                                        Border.all(

                                      color:
                                          Colors
                                              .white,

                                      width:
                                          1.5,
                                    ),
                                  ),

                                  child: Text(

                                    cartProvider
                                        .totalItems
                                        .toString(),

                                    style:
                                        const TextStyle(

                                      color:
                                          Colors
                                              .white,

                                      fontSize:
                                          9,

                                      fontWeight:
                                          FontWeight
                                              .bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // =================================
                          // CONTENT
                          // =================================

                          if (widget
                              .showTotalPrice)
                            ...[

                              const SizedBox(
                                width: 14,
                              ),

                              Expanded(

                                child: Column(

                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,

                                  mainAxisSize:
                                      MainAxisSize
                                          .min,

                                  children: [

                                    const Text(

                                      'View Cart',

                                      overflow:
                                          TextOverflow
                                              .ellipsis,

                                      style:
                                          TextStyle(

                                        color:
                                            Colors
                                                .white,

                                        fontWeight:
                                            FontWeight
                                                .bold,

                                        fontSize:
                                            13,
                                      ),
                                    ),

                                    const SizedBox(
                                      height:
                                          2,
                                    ),

                                    Text(

                                      '${cartProvider.totalItems} products added',

                                      overflow:
                                          TextOverflow
                                              .ellipsis,

                                      style:
                                          TextStyle(

                                        color:
                                            Colors
                                                .white
                                                .withOpacity(
                                          0.82,
                                        ),

                                        fontSize:
                                            10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(
                                width: 10,
                              ),

                              Column(

                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .end,

                                children: [

                                  Text(

                                    AppFormat.currency(
                                      cartProvider
                                          .totalPrice,
                                    ),

                                    overflow:
                                        TextOverflow
                                            .ellipsis,

                                    style:
                                        const TextStyle(

                                      color:
                                          Colors
                                              .white,

                                      fontWeight:
                                          FontWeight
                                              .bold,

                                      fontSize:
                                          15,
                                    ),
                                  ),

                                  const SizedBox(
                                    height:
                                        2,
                                  ),

                                  Text(

                                    'Checkout now',

                                    style:
                                        TextStyle(

                                      color:
                                          Colors
                                              .white
                                              .withOpacity(
                                        0.74,
                                      ),

                                      fontSize:
                                          9,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                width: 10,
                              ),

                              AnimatedContainer(

                                duration:
                                    const Duration(
                                  milliseconds:
                                      220,
                                ),

                                width:
                                    hovered
                                        ? 36
                                        : 32,

                                height:
                                    hovered
                                        ? 36
                                        : 32,

                                decoration:
                                    BoxDecoration(

                                  color:
                                      Colors.white
                                          .withOpacity(
                                    0.14,
                                  ),

                                  shape:
                                      BoxShape.circle,
                                ),

                                child:
                                    const Icon(

                                  Icons
                                      .arrow_forward_rounded,

                                  size:
                                      16,

                                  color:
                                      Colors
                                          .white,
                                ),
                              ),
                            ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}