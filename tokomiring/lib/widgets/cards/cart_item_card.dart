// lib/widgets/cards/cart_item_card.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_format.dart';

import '../../providers/cart_provider.dart';

class CartItemCard
    extends StatefulWidget {

  final CartItemModel item;

  const CartItemCard({

    super.key,

    required this.item,
  });

  @override
  State<CartItemCard>
      createState() =>
          _CartItemCardState();
}

class _CartItemCardState
    extends State<CartItemCard> {

  bool hovered = false;

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(
    BuildContext context,
  ) {

    final screenWidth =
        MediaQuery.of(context)
            .size
            .width;

    final isMobile =
        screenWidth < 600;

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
          AnimatedScale(

        duration:
            const Duration(
          milliseconds: 220,
        ),

        scale:
            hovered
                ? 1.01
                : 1,

        child:
            AnimatedContainer(

          duration:
              const Duration(
            milliseconds: 220,
          ),

          margin:
              const EdgeInsets.only(
            bottom: 18,
          ),

          decoration:
              BoxDecoration(

            color:
                Colors.white,

            borderRadius:
                BorderRadius.circular(
              28,
            ),

            boxShadow: [

              BoxShadow(

                color:
                    hovered

                        ? Colors.black
                            .withOpacity(
                          0.08,
                        )

                        : Colors.black
                            .withOpacity(
                          0.04,
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

          child: Padding(

            padding:
                const EdgeInsets.all(
              16,
            ),

            child:

                isMobile

                    ? _mobileLayout(
                        context,
                      )

                    : _desktopLayout(
                        context,
                      ),
          ),
        ),
      ),
    );
  }

  // =====================================================
  // DESKTOP
  // =====================================================

  Widget _desktopLayout(
    BuildContext context,
  ) {

    return Row(

      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        // ===============================================
        // IMAGE
        // ===============================================

        buildImage(
          110,
        ),

        const SizedBox(
          width: 18,
        ),

        // ===============================================
        // CONTENT
        // ===============================================

        Expanded(

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [

              // =========================================
              // NAME
              // =========================================

              Text(

                widget.item.product.name,

                maxLines: 2,

                overflow:
                    TextOverflow
                        .ellipsis,

                style:
                    const TextStyle(

                  fontSize: 18,

                  fontWeight:
                      FontWeight.bold,

                  height: 1.35,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              // =========================================
              // PRICE
              // =========================================

              Text(

                AppFormat.currency(

                  widget.item
                      .product.price,
                ),

                style:
                    TextStyle(

                  fontSize: 15,

                  color:
                      Colors.grey
                          .shade700,
                ),
              ),

              const SizedBox(
                height: 14,
              ),

              // =========================================
              // SUBTOTAL
              // =========================================

              AnimatedContainer(

                duration:
                    const Duration(
                  milliseconds:
                      220,
                ),

                padding:
                    const EdgeInsets.symmetric(

                  horizontal:
                      14,

                  vertical:
                      10,
                ),

                decoration:
                    BoxDecoration(

                  color:
                      AppColors
                          .success
                          .withOpacity(
                    0.1,
                  ),

                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
                ),

                child: Row(

                  mainAxisSize:
                      MainAxisSize.min,

                  children: [

                    const Icon(

                      Icons
                          .payments_rounded,

                      size: 18,

                      color:
                          AppColors
                              .success,
                    ),

                    const SizedBox(
                      width: 8,
                    ),

                    Text(

                      AppFormat.currency(
                        widget.item
                            .subtotal,
                      ),

                      style:
                          const TextStyle(

                        color:
                            AppColors
                                .success,

                        fontWeight:
                            FontWeight.bold,

                        fontSize:
                            14,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 18,
              ),

              // =========================================
              // REMOVE
              // =========================================

              GestureDetector(

                onTap: () {

                  Provider.of<
                      CartProvider>(

                    context,

                    listen:
                        false,

                  ).removeFromCart(
                    widget.item
                        .product.id,
                  );
                },

                child: Container(

                  padding:
                      const EdgeInsets.symmetric(

                    horizontal:
                        14,

                    vertical:
                        10,
                  ),

                  decoration:
                      BoxDecoration(

                    color:
                        AppColors
                            .danger
                            .withOpacity(
                      0.08,
                    ),

                    borderRadius:
                        BorderRadius.circular(
                      14,
                    ),
                  ),

                  child: const Row(

                    mainAxisSize:
                        MainAxisSize.min,

                    children: [

                      Icon(

                        Icons
                            .delete_outline,

                        color:
                            AppColors
                                .danger,

                        size: 18,
                      ),

                      SizedBox(
                        width: 8,
                      ),

                      Text(

                        'Remove',

                        style:
                            TextStyle(

                          color:
                              AppColors
                                  .danger,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(
          width: 14,
        ),

        // ===============================================
        // QTY
        // ===============================================

        quantityBox(
          context,
        ),
      ],
    );
  }

  // =====================================================
  // MOBILE
  // =====================================================

  Widget _mobileLayout(
    BuildContext context,
  ) {

    return Column(

      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Row(

          crossAxisAlignment:
              CrossAxisAlignment
                  .start,

          children: [

            buildImage(
              95,
            ),

            const SizedBox(
              width: 16,
            ),

            Expanded(

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  Text(

                    widget.item
                        .product.name,

                    maxLines: 2,

                    overflow:
                        TextOverflow
                            .ellipsis,

                    style:
                        const TextStyle(

                      fontSize: 16,

                      fontWeight:
                          FontWeight.bold,

                      height: 1.3,
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  Text(

                    AppFormat.currency(

                      widget.item
                          .product.price,
                    ),

                    style:
                        TextStyle(

                      color:
                          Colors.grey
                              .shade700,
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  AnimatedContainer(

                    duration:
                        const Duration(
                      milliseconds:
                          220,
                    ),

                    padding:
                        const EdgeInsets.symmetric(

                      horizontal:
                          12,

                      vertical:
                          8,
                    ),

                    decoration:
                        BoxDecoration(

                      color:
                          AppColors
                              .success
                              .withOpacity(
                        0.1,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),
                    ),

                    child: Text(

                      AppFormat.currency(
                        widget.item
                            .subtotal,
                      ),

                      style:
                          const TextStyle(

                        color:
                            AppColors
                                .success,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(
          height: 18,
        ),

        Row(

          mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,

          children: [

            GestureDetector(

              onTap: () {

                Provider.of<
                    CartProvider>(

                  context,

                  listen:
                      false,

                ).removeFromCart(
                  widget.item
                      .product.id,
                );
              },

              child: Container(

                padding:
                    const EdgeInsets.symmetric(

                  horizontal:
                      14,

                  vertical:
                      10,
                ),

                decoration:
                    BoxDecoration(

                  color:
                      AppColors
                          .danger
                          .withOpacity(
                    0.08,
                  ),

                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
                ),

                child: const Row(

                  children: [

                    Icon(

                      Icons
                          .delete_outline,

                      color:
                          AppColors
                              .danger,

                      size: 18,
                    ),

                    SizedBox(
                      width: 6,
                    ),

                    Text(

                      'Remove',

                      style:
                          TextStyle(

                        color:
                            AppColors
                                .danger,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            quantityBox(
              context,
            ),
          ],
        ),
      ],
    );
  }

  // =====================================================
  // IMAGE
  // =====================================================

  Widget buildImage(
    double size,
  ) {

    return ClipRRect(

      borderRadius:
          BorderRadius.circular(
        22,
      ),

      child:
          widget.item.product
                  .imageBase64
                  .isEmpty

              ? Container(

                  width: size,

                  height: size,

                  color:
                      Colors.grey
                          .shade200,

                  child: Icon(

                    Icons
                        .image_outlined,

                    size:
                        size * 0.35,

                    color:
                        Colors.grey
                            .shade500,
                  ),
                )

              : Image.memory(

                  base64Decode(

                    widget.item
                        .product
                        .imageBase64,
                  ),

                  width: size,

                  height: size,

                  fit:
                      BoxFit.cover,

                  filterQuality:
                      FilterQuality
                          .high,

                  errorBuilder: (

                    context,

                    error,

                    stackTrace,

                  ) {

                    return Container(

                      width: size,

                      height: size,

                      color:
                          Colors.grey
                              .shade200,

                      child:
                          Icon(

                        Icons
                            .broken_image_outlined,

                        size:
                            size * 0.35,

                        color:
                            Colors.grey
                                .shade500,
                      ),
                    );
                  },
                ),
    );
  }

  // =====================================================
  // QTY BOX
  // =====================================================

  Widget quantityBox(
    BuildContext context,
  ) {

    return Container(

      padding:
          const EdgeInsets.symmetric(

        horizontal: 10,

        vertical: 12,
      ),

      decoration:
          BoxDecoration(

        color:
            const Color(
          0xffF8FAFC,
        ),

        borderRadius:
            BorderRadius.circular(
          20,
        ),
      ),

      child: Column(

        children: [

          // ===============================================
          // ADD
          // ===============================================

          InkWell(

            borderRadius:
                BorderRadius.circular(
              100,
            ),

            onTap: () {

              Provider.of<
                  CartProvider>(

                context,

                listen:
                    false,

              ).increaseQuantity(
                widget.item
                    .product.id,
              );
            },

            child:
                AnimatedContainer(

              duration:
                  const Duration(
                milliseconds:
                    220,
              ),

              padding:
                  const EdgeInsets.all(
                7,
              ),

              decoration:
                  const BoxDecoration(

                color:
                    AppColors
                        .success,

                shape:
                    BoxShape.circle,
              ),

              child:
                  const Icon(

                Icons.add,

                size: 18,

                color:
                    Colors.white,
              ),
            ),
          ),

          const SizedBox(
            height: 14,
          ),

          // ===============================================
          // QTY
          // ===============================================

          AnimatedSwitcher(

            duration:
                const Duration(
              milliseconds:
                  220,
            ),

            transitionBuilder:
                (
                  child,
                  animation,
                ) {

              return ScaleTransition(

                scale:
                    animation,

                child:
                    child,
              );
            },

            child: Text(

              '${widget.item.quantity}',

              key: ValueKey(
                widget.item
                    .quantity,
              ),

              style:
                  const TextStyle(

                fontSize: 20,

                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(
            height: 14,
          ),

          // ===============================================
          // MINUS
          // ===============================================

          InkWell(

            borderRadius:
                BorderRadius.circular(
              100,
            ),

            onTap: () {

              Provider.of<
                  CartProvider>(

                context,

                listen:
                    false,

              ).decreaseQuantity(
                widget.item
                    .product.id,
              );
            },

            child:
                AnimatedContainer(

              duration:
                  const Duration(
                milliseconds:
                    220,
              ),

              padding:
                  const EdgeInsets.all(
                7,
              ),

              decoration:
                  const BoxDecoration(

                color:
                    AppColors
                        .danger,

                shape:
                    BoxShape.circle,
              ),

              child:
                  const Icon(

                Icons.remove,

                size: 18,

                color:
                    Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}