// =====================================================
// lib/widgets/buttons/cart_button.dart
// FINAL PREMIUM COMPACT VERSION
// =====================================================

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                  180,
            ),

            curve:
                Curves.easeOut,

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
                        ? width * 0.88
                        : 290)

                    : null,

            child:
                Material(

              color:
                  Colors.transparent,

              child:
                  InkWell(

                borderRadius:
                    BorderRadius.circular(
                  20,
                ),

                onTap:
                    widget.onPressed,

                child:
                    ClipRRect(

                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),

                  child:
                      BackdropFilter(

                    filter:
                        ImageFilter.blur(

                      sigmaX: 5,

                      sigmaY: 5,
                    ),

                    child:
                        AnimatedContainer(

                      duration:
                          const Duration(
                        milliseconds:
                            180,
                      ),

                      padding:
                          EdgeInsets.symmetric(

                        horizontal:

                            isMobile
                                ? 12
                                : 14,

                        vertical:

                            isMobile
                                ? 10
                                : 11,
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
                          ],
                        ),

                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),

                        boxShadow: [

                          BoxShadow(

                            color:
                                Colors.blue
                                    .withOpacity(

                              hovered
                                  ? 0.20
                                  : 0.13,
                            ),

                            blurRadius:

                                hovered
                                    ? 18
                                    : 12,

                            offset:
                                Offset(
                              0,
                              hovered
                                  ? 8
                                  : 5,
                            ),
                          ),
                        ],
                      ),

                      child:
                          Row(

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
                                      180,
                                ),

                                width:
                                    hovered
                                        ? 38
                                        : 35,

                                height:
                                    hovered
                                        ? 38
                                        : 35,

                                decoration:
                                    BoxDecoration(

                                  color:
                                      Colors.white
                                          .withOpacity(
                                    0.15,
                                  ),

                                  borderRadius:
                                      BorderRadius.circular(
                                    12,
                                  ),
                                ),

                                child:
                                    Icon(

                                  Icons
                                      .shopping_bag_rounded,

                                  color:
                                      widget.iconColor ??

                                          Colors
                                              .white,

                                  size:
                                      16,
                                ),
                              ),

                              Positioned(

                                right: -3,

                                top: -3,

                                child:
                                    Container(

                                  padding:
                                      const EdgeInsets.symmetric(

                                    horizontal:
                                        5,

                                    vertical:
                                        2,
                                  ),

                                  decoration:
                                      BoxDecoration(

                                    color:
                                        Colors.red,

                                    borderRadius:
                                        BorderRadius.circular(
                                      20,
                                    ),

                                    border:
                                        Border.all(

                                      color:
                                          Colors
                                              .white,

                                      width:
                                          1.3,
                                    ),
                                  ),

                                  child:
                                      Text(

                                    cartProvider
                                        .totalItems
                                        .toString(),

                                    style:
                                        const TextStyle(

                                      color:
                                          Colors
                                              .white,

                                      fontSize:
                                          8,

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
                                width: 11,
                              ),

                              Expanded(

                                child:
                                    Column(

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
                                            12,
                                      ),
                                    ),

                                    const SizedBox(
                                      height:
                                          1,
                                    ),

                                    Text(

                                      '${cartProvider.totalItems} products',

                                      overflow:
                                          TextOverflow
                                              .ellipsis,

                                      style:
                                          TextStyle(

                                        color:
                                            Colors
                                                .white
                                                .withOpacity(
                                          0.80,
                                        ),

                                        fontSize:
                                            9,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(
                                width: 8,
                              ),

                              // =================================
                              // PRICE
                              // =================================

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
                                          13,
                                    ),
                                  ),

                                  Text(

                                    'Checkout',

                                    style:
                                        TextStyle(

                                      color:
                                          Colors
                                              .white
                                              .withOpacity(
                                        0.72,
                                      ),

                                      fontSize:
                                          8,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                width: 8,
                              ),

                              AnimatedContainer(

                                duration:
                                    const Duration(
                                  milliseconds:
                                      180,
                                ),

                                width:
                                    hovered
                                        ? 30
                                        : 27,

                                height:
                                    hovered
                                        ? 30
                                        : 27,

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
                                      14,

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