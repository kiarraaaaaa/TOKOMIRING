// =====================================================
// lib/widgets/cards/product_card.dart
// ULTRA COMPACT PREMIUM MARKETPLACE VERSION
// =====================================================

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_format.dart';

import '../../models/product_model.dart';

import '../../providers/cart_provider.dart';
import '../../providers/product_provider.dart';

class ProductCard
    extends StatefulWidget {

  final ProductModel product;

  const ProductCard({

    super.key,

    required this.product,
  });

  @override
  State<ProductCard>
      createState() =>
          _ProductCardState();
}

class _ProductCardState
    extends State<ProductCard> {

  bool hovered = false;

  bool adding = false;

  // =========================================
  // STOCK COLOR
  // =========================================

  Color getStockColor() {

    if (widget.product.stock <= 0) {

      return AppColors.danger;
    }

    if (widget.product.stock <= 5) {

      return AppColors.warning;
    }

    return AppColors.success;
  }

  // =========================================
  // ADD TO CART
  // =========================================

  Future<void> addToCart(
    BuildContext context,
  ) async {

    if (adding) return;

    setState(() {

      adding = true;
    });

    final cartProvider =
        context.read<CartProvider>();

    cartProvider.addToCart(
      widget.product,
    );

    await Future.delayed(

      const Duration(
        milliseconds: 550,
      ),
    );

    if (!mounted) return;

    setState(() {

      adding = false;
    });

    ScaffoldMessenger.of(
      context,
    ).hideCurrentSnackBar();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(

      SnackBar(

        behavior:
            SnackBarBehavior
                .floating,

        backgroundColor:
            AppColors.primary,

        margin:
            const EdgeInsets.all(
          14,
        ),

        shape:
            RoundedRectangleBorder(

          borderRadius:
              BorderRadius.circular(
            14,
          ),
        ),

        content: Row(

          children: [

            const Icon(

              Icons.check_circle,

              color:
                  Colors.white,

              size: 18,
            ),

            const SizedBox(
              width: 10,
            ),

            Expanded(

              child: Text(

                '${widget.product.name} added to cart',

                overflow:
                    TextOverflow
                        .ellipsis,

                style:
                    const TextStyle(

                  color:
                      Colors.white,

                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),

        duration:
            const Duration(
          seconds: 1,
        ),
      ),
    );
  }

  // =========================================
  // BUILD
  // =========================================

  @override
  Widget build(
    BuildContext context,
  ) {

    final productProvider =
        context.watch<ProductProvider>();

    final screenWidth =
        MediaQuery.of(context)
            .size
            .width;

    final isDesktop =
        screenWidth >= 1200;

    final isTablet =
        screenWidth >= 700;

    final imageHeight =

        isDesktop
            ? 108.0
            : isTablet
                ? 100.0
                : 92.0;

    final isFavorite =
        productProvider
            .isFavorite(
      widget.product,
    );

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

        transform:
            Matrix4.identity()
              ..translate(
                0.0,
                hovered ? -2 : 0,
              ),

        decoration:
            BoxDecoration(

          color:
              Colors.white,

          borderRadius:
              BorderRadius.circular(
            20,
          ),

          border: Border.all(

            color:

                hovered

                    ? AppColors
                        .primary
                        .withOpacity(
                      0.10,
                    )

                    : Colors
                        .transparent,
          ),

          boxShadow: [

            BoxShadow(

              color:
                  Colors.black
                      .withOpacity(
                hovered
                    ? 0.06
                    : 0.035,
              ),

              blurRadius:
                  hovered
                      ? 18
                      : 10,

              offset:
                  Offset(
                0,
                hovered
                    ? 10
                    : 5,
              ),
            ),
          ],
        ),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment
                  .start,

          children: [

            // =====================================
            // IMAGE
            // =====================================

            SizedBox(

              height:
                  imageHeight,

              child: Stack(

                children: [

                  Positioned.fill(

                    child:
                        ClipRRect(

                      borderRadius:
                          const BorderRadius.only(

                        topLeft:
                            Radius.circular(
                          20,
                        ),

                        topRight:
                            Radius.circular(
                          20,
                        ),
                      ),

                      child:
                          widget
                                  .product
                                  .imageBase64
                                  .isEmpty

                              ? Container(

                                  color:
                                      Colors.grey
                                          .shade200,

                                  child:
                                      Icon(

                                    Icons
                                        .image_outlined,

                                    size:
                                        32,

                                    color:
                                        Colors.grey
                                            .shade500,
                                  ),
                                )

                              : Hero(

                                  tag:
                                      widget
                                          .product
                                          .id,

                                  child:
                                      Image.memory(

                                    base64Decode(
                                      widget
                                          .product
                                          .imageBase64,
                                    ),

                                    fit:
                                        BoxFit.cover,

                                    filterQuality:
                                        FilterQuality
                                            .medium,

                                    errorBuilder:
                                        (

                                      context,

                                      error,

                                      stackTrace,

                                    ) {

                                      return Container(

                                        color:
                                            Colors.grey
                                                .shade200,

                                        child:
                                            Icon(

                                          Icons
                                              .broken_image_outlined,

                                          size:
                                              30,

                                          color:
                                              Colors.grey
                                                  .shade500,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                    ),
                  ),

                  // =================================
                  // OVERLAY
                  // =================================

                  Positioned.fill(

                    child: Container(

                      decoration:
                          BoxDecoration(

                        borderRadius:
                            const BorderRadius.only(

                          topLeft:
                              Radius.circular(
                            20,
                          ),

                          topRight:
                              Radius.circular(
                            20,
                          ),
                        ),

                        gradient:
                            LinearGradient(

                          begin:
                              Alignment.bottomCenter,

                          end:
                              Alignment.topCenter,

                          colors: [

                            Colors.black
                                .withOpacity(
                              0.14,
                            ),

                            Colors
                                .transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // =================================
                  // CATEGORY
                  // =================================

                  Positioned(

                    top: 8,

                    left: 8,

                    child: Container(

                      padding:
                          const EdgeInsets.symmetric(

                        horizontal: 8,

                        vertical: 4,
                      ),

                      decoration:
                          BoxDecoration(

                        color:
                            Colors.black
                                .withOpacity(
                          0.55,
                        ),

                        borderRadius:
                            BorderRadius.circular(
                          18,
                        ),
                      ),

                      child: Text(

                        widget
                            .product
                            .category,

                        style:
                            const TextStyle(

                          color:
                              Colors.white,

                          fontSize: 8,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // =================================
                  // FAVORITE
                  // =================================

                  Positioned(

                    top: 8,

                    right: 8,

                    child:
                        GestureDetector(

                      onTap: () {

                        productProvider
                            .toggleFavorite(
                          widget
                              .product,
                        );
                      },

                      child: Container(

                        width: 28,

                        height: 28,

                        decoration:
                            BoxDecoration(

                          color:
                              Colors.white
                                  .withOpacity(
                            0.92,
                          ),

                          shape:
                              BoxShape.circle,
                        ),

                        child: Icon(

                          isFavorite

                              ? Icons.favorite

                              : Icons.favorite_border,

                          color:

                              isFavorite

                                  ? Colors.red

                                  : Colors
                                      .black54,

                          size: 14,
                        ),
                      ),
                    ),
                  ),

                  // =================================
                  // STOCK BADGE
                  // =================================

                  Positioned(

                    left: 8,

                    bottom: 8,

                    child: Container(

                      padding:
                          const EdgeInsets.symmetric(

                        horizontal: 8,

                        vertical: 4,
                      ),

                      decoration:
                          BoxDecoration(

                        color:
                            getStockColor(),

                        borderRadius:
                            BorderRadius.circular(
                          18,
                        ),
                      ),

                      child: Text(

                        widget.product.stock <= 0

                            ? 'Sold Out'

                            : widget.product.stock <= 5

                                ? 'Low'

                                : 'Ready',

                        style:
                            const TextStyle(

                          color:
                              Colors.white,

                          fontSize: 8,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // =====================================
            // CONTENT
            // =====================================

            Expanded(

              child: Padding(

                padding:
                    const EdgeInsets.all(
                  10,
                ),

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    // =================================
                    // NAME
                    // =================================

                    Text(

                      widget.product.name,

                      maxLines: 2,

                      overflow:
                          TextOverflow
                              .ellipsis,

                      style:
                          TextStyle(

                        fontSize:

                            isTablet
                                ? 13
                                : 12,

                        fontWeight:
                            FontWeight.w700,

                        height: 1.25,
                      ),
                    ),

                    const SizedBox(
                      height: 6,
                    ),

                    // =================================
                    // PRICE
                    // =================================

                    Text(

                      AppFormat.currency(
                        widget.product.price,
                      ),

                      overflow:
                          TextOverflow
                              .ellipsis,

                      style:
                          const TextStyle(

                        fontSize: 15,

                        fontWeight:
                            FontWeight.bold,

                        color:
                            AppColors
                                .success,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    // =================================
                    // STOCK
                    // =================================

                    Container(

                      padding:
                          const EdgeInsets.symmetric(

                        horizontal: 8,

                        vertical: 6,
                      ),

                      decoration:
                          BoxDecoration(

                        color:
                            getStockColor()
                                .withOpacity(
                          0.08,
                        ),

                        borderRadius:
                            BorderRadius.circular(
                          10,
                        ),
                      ),

                      child: Row(

                        children: [

                          Icon(

                            Icons
                                .inventory_2_rounded,

                            size: 13,

                            color:
                                getStockColor(),
                          ),

                          const SizedBox(
                            width: 5,
                          ),

                          Expanded(

                            child: Text(

                              'Stock ${widget.product.stock}',

                              overflow:
                                  TextOverflow
                                      .ellipsis,

                              style:
                                  TextStyle(

                                fontSize: 10,

                                color:
                                    getStockColor(),

                                fontWeight:
                                    FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // =================================
                    // BUTTON
                    // =================================

                    SizedBox(

                      width:
                          double.infinity,

                      height: 36,

                      child:
                          ElevatedButton.icon(

                        style:
                            ElevatedButton.styleFrom(

                          elevation: 0,

                          backgroundColor:

                              widget.product.stock <= 0

                                  ? Colors.grey

                                  : AppColors
                                      .primary,

                          foregroundColor:
                              Colors.white,

                          padding:
                              const EdgeInsets.symmetric(

                            horizontal: 10,
                          ),

                          shape:
                              RoundedRectangleBorder(

                            borderRadius:
                                BorderRadius.circular(
                              12,
                            ),
                          ),
                        ),

                        onPressed:

                            widget.product.stock <= 0

                                ? null

                                : () {

                                    addToCart(
                                      context,
                                    );
                                  },

                        icon:

                            adding

                                ? const SizedBox(

                                    width:
                                        14,

                                    height:
                                        14,

                                    child:
                                        CircularProgressIndicator(

                                      color:
                                          Colors
                                              .white,

                                      strokeWidth:
                                          2,
                                    ),
                                  )

                                : const Icon(

                                    Icons
                                        .shopping_cart_rounded,

                                    size:
                                        15,
                                  ),

                        label: Text(

                          widget.product.stock <= 0

                              ? 'Unavailable'

                              : adding

                                  ? 'Adding'

                                  : 'Add',

                          overflow:
                              TextOverflow
                                  .ellipsis,

                          style:
                              const TextStyle(

                            fontSize: 11,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}