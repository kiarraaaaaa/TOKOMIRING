// =====================================================
// lib/widgets/cards/cart_item_card.dart
// ULTRA COMPACT CLEAN PREMIUM VERSION
// =====================================================

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
          milliseconds: 220,
        ),

        padding:
            EdgeInsets.all(
          isMobile
              ? 12
              : 14,
        ),

        decoration:
            BoxDecoration(

          color:
              Colors.white,

          borderRadius:
              BorderRadius.circular(
            22,
          ),

          border: Border.all(

            color:
                hovered

                    ? AppColors.primary
                        .withOpacity(
                      0.12,
                    )

                    : Colors.transparent,
          ),

          boxShadow: [

            BoxShadow(

              color:
                  Colors.black
                      .withOpacity(
                hovered
                    ? 0.06
                    : 0.03,
              ),

              blurRadius:
                  hovered
                      ? 16
                      : 10,

              offset:
                  const Offset(
                0,
                6,
              ),
            ),
          ],
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
    );
  }

  // =====================================================
  // DESKTOP
  // =====================================================

  Widget _desktopLayout(
    BuildContext context,
  ) {

    return Row(

      children: [

        buildImage(
          76,
        ),

        const SizedBox(
          width: 14,
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

                maxLines: 1,

                overflow:
                    TextOverflow
                        .ellipsis,

                style:
                    const TextStyle(

                  fontSize: 15,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 6,
              ),

              Text(

                AppFormat.currency(

                  widget.item
                      .product.price,
                ),

                style:
                    TextStyle(

                  fontSize: 13,

                  color:
                      Colors.grey
                          .shade700,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Container(

                padding:
                    const EdgeInsets.symmetric(

                  horizontal: 10,

                  vertical: 6,
                ),

                decoration:
                    BoxDecoration(

                  color:
                      AppColors
                          .success
                          .withOpacity(
                    0.10,
                  ),

                  borderRadius:
                      BorderRadius.circular(
                    10,
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

                    fontSize:
                        12,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(
          width: 12,
        ),

        quantityBox(
          context,
        ),

        const SizedBox(
          width: 10,
        ),

        removeButton(
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

      children: [

        Row(

          children: [

            buildImage(
              70,
            ),

            const SizedBox(
              width: 12,
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

                      fontSize: 14,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 6,
                  ),

                  Text(

                    AppFormat.currency(

                      widget.item
                          .product.price,
                    ),

                    style:
                        TextStyle(

                      fontSize: 12,

                      color:
                          Colors.grey
                              .shade700,
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  Container(

                    padding:
                        const EdgeInsets.symmetric(

                      horizontal: 10,

                      vertical: 6,
                    ),

                    decoration:
                        BoxDecoration(

                      color:
                          AppColors
                              .success
                              .withOpacity(
                        0.10,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        10,
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

                        fontSize:
                            12,

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
          height: 12,
        ),

        Row(

          mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,

          children: [

            quantityBox(
              context,
            ),

            removeButton(
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
        16,
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

                  child:
                      Icon(

                    Icons.image_outlined,

                    size:
                        size * 0.30,

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
                ),
    );
  }

  // =====================================================
  // REMOVE
  // =====================================================

  Widget removeButton(
    BuildContext context,
  ) {

    return InkWell(

      borderRadius:
          BorderRadius.circular(
        12,
      ),

      onTap: () {

        Provider.of<
            CartProvider>(

          context,

          listen: false,

        ).removeFromCart(
          widget.item
              .product.id,
        );
      },

      child: Container(

        padding:
            const EdgeInsets.all(
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
            12,
          ),
        ),

        child:
            const Icon(

          Icons.delete_outline,

          color:
              AppColors
                  .danger,

          size: 18,
        ),
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

        horizontal: 8,

        vertical: 8,
      ),

      decoration:
          BoxDecoration(

        color:
            const Color(
          0xffF8FAFC,
        ),

        borderRadius:
            BorderRadius.circular(
          14,
        ),
      ),

      child: Row(

        children: [

          qtyButton(

            icon:
                Icons.remove,

            color:
                AppColors.danger,

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
          ),

          Padding(

            padding:
                const EdgeInsets.symmetric(
              horizontal: 12,
            ),

            child: Text(

              '${widget.item.quantity}',

              style:
                  const TextStyle(

                fontSize: 14,

                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),

          qtyButton(

            icon:
                Icons.add,

            color:
                AppColors.success,

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
          ),
        ],
      ),
    );
  }

  // =====================================================
  // QTY BUTTON
  // =====================================================

  Widget qtyButton({

    required IconData icon,

    required Color color,

    required VoidCallback onTap,
  }) {

    return InkWell(

      borderRadius:
          BorderRadius.circular(
        100,
      ),

      onTap: onTap,

      child: Container(

        width: 28,

        height: 28,

        decoration:
            BoxDecoration(

          color:
              color.withOpacity(
            0.12,
          ),

          shape:
              BoxShape.circle,
        ),

        child:
            Icon(

          icon,

          size: 16,

          color:
              color,
        ),
      ),
    );
  }
}