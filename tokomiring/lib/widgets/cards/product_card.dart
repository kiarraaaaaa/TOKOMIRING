// =====================================================
// lib/widgets/cards/product_card.dart
// MODERN COMPACT RESPONSIVE VERSION
// =====================================================

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_format.dart';

import '../../models/product_model.dart';

import '../../providers/cart_provider.dart';
import '../../providers/product_provider.dart';

class ProductCard extends StatefulWidget {

  final ProductModel product;

  const ProductCard({

    super.key,

    required this.product,
  });

  @override
  State<ProductCard> createState() =>
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
        milliseconds: 650,
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
            SnackBarBehavior.floating,

        backgroundColor:
            AppColors.primary,

        margin:
            const EdgeInsets.all(14),

        shape:
            RoundedRectangleBorder(

          borderRadius:
              BorderRadius.circular(16),
        ),

        content: Row(

          children: [

            const Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 20,
            ),

            const SizedBox(width: 10),

            Expanded(

              child: Text(

                '${widget.product.name} added to cart',

                overflow:
                    TextOverflow.ellipsis,

                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),

        duration:
            const Duration(seconds: 1),
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
            ? 125.0
            : isTablet
                ? 115.0
                : 100.0;

    final isFavorite =
        productProvider.isFavorite(
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

      child: AnimatedContainer(

        duration:
            const Duration(
          milliseconds: 220,
        ),

        transform:
            Matrix4.identity()
              ..translate(
                0.0,
                hovered ? -3 : 0,
              ),

        decoration:
            BoxDecoration(

          color:
              Colors.white,

          borderRadius:
              BorderRadius.circular(24),

          boxShadow: [

            BoxShadow(

              color:
                  Colors.black.withOpacity(
                hovered ? 0.07 : 0.04,
              ),

              blurRadius:
                  hovered ? 24 : 14,

              offset:
                  Offset(
                0,
                hovered ? 12 : 6,
              ),
            ),
          ],
        ),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // =====================================
            // IMAGE
            // =====================================

            SizedBox(

              height: imageHeight,

              child: Stack(

                children: [

                  Positioned.fill(

                    child: ClipRRect(

                      borderRadius:
                          const BorderRadius.only(

                        topLeft:
                            Radius.circular(24),

                        topRight:
                            Radius.circular(24),
                      ),

                      child:
                          widget.product.imageBase64.isEmpty

                              ? Container(

                                  color:
                                      Colors.grey.shade200,

                                  child: Icon(

                                    Icons.image_outlined,

                                    size:
                                        isTablet ? 50 : 38,

                                    color:
                                        Colors.grey.shade500,
                                  ),
                                )

                              : Hero(

                                  tag:
                                      widget.product.id,

                                  child: Image.memory(

                                    base64Decode(
                                      widget.product.imageBase64,
                                    ),

                                    fit: BoxFit.cover,

                                    filterQuality:
                                        FilterQuality.medium,

                                    errorBuilder:
                                        (
                                      context,
                                      error,
                                      stackTrace,
                                    ) {

                                      return Container(

                                        color:
                                            Colors.grey.shade200,

                                        child:
                                            Icon(

                                          Icons.broken_image_outlined,

                                          size: 40,

                                          color:
                                              Colors.grey.shade500,
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
                              Radius.circular(24),

                          topRight:
                              Radius.circular(24),
                        ),

                        gradient:
                            LinearGradient(

                          begin:
                              Alignment.bottomCenter,

                          end:
                              Alignment.topCenter,

                          colors: [

                            Colors.black.withOpacity(0.18),

                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // =================================
                  // CATEGORY
                  // =================================

                  Positioned(

                    top: 10,

                    left: 10,

                    child: Container(

                      padding:
                          const EdgeInsets.symmetric(

                        horizontal: 10,

                        vertical: 5,
                      ),

                      decoration:
                          BoxDecoration(

                        color:
                            Colors.black.withOpacity(0.58),

                        borderRadius:
                            BorderRadius.circular(20),
                      ),

                      child: Text(

                        widget.product.category,

                        style:
                            const TextStyle(

                          color:
                              Colors.white,

                          fontSize: 9,

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

                    top: 10,

                    right: 10,

                    child: GestureDetector(

                      onTap: () {

                        productProvider.toggleFavorite(
                          widget.product,
                        );
                      },

                      child: Container(

                        width: 32,

                        height: 32,

                        decoration:
                            BoxDecoration(

                          color:
                              Colors.white.withOpacity(0.9),

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
                                  : Colors.black54,

                          size: 16,
                        ),
                      ),
                    ),
                  ),

                  // =================================
                  // STOCK BADGE
                  // =================================

                  Positioned(

                    left: 10,

                    bottom: 10,

                    child: Container(

                      padding:
                          const EdgeInsets.symmetric(

                        horizontal: 10,

                        vertical: 5,
                      ),

                      decoration:
                          BoxDecoration(

                        color:
                            getStockColor(),

                        borderRadius:
                            BorderRadius.circular(20),
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

                          fontSize: 9,

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
                    const EdgeInsets.all(12),

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    // =================================
                    // NAME
                    // =================================

                    Text(

                      widget.product.name,

                      maxLines: 2,

                      overflow:
                          TextOverflow.ellipsis,

                      style: TextStyle(

                        fontSize:
                            isTablet ? 14 : 13,

                        fontWeight:
                            FontWeight.w700,

                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // =================================
                    // PRICE
                    // =================================

                    Text(

                      AppFormat.currency(
                        widget.product.price,
                      ),

                      overflow:
                          TextOverflow.ellipsis,

                      style:
                          const TextStyle(

                        fontSize: 16,

                        fontWeight:
                            FontWeight.bold,

                        color:
                            AppColors.success,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // =================================
                    // STOCK
                    // =================================

                    Container(

                      padding:
                          const EdgeInsets.symmetric(

                        horizontal: 10,

                        vertical: 7,
                      ),

                      decoration:
                          BoxDecoration(

                        color:
                            getStockColor()
                                .withOpacity(0.08),

                        borderRadius:
                            BorderRadius.circular(12),
                      ),

                      child: Row(

                        children: [

                          Icon(

                            Icons.inventory_2_rounded,

                            size: 15,

                            color:
                                getStockColor(),
                          ),

                          const SizedBox(width: 6),

                          Expanded(

                            child: Text(

                              'Stock: ${widget.product.stock}',

                              overflow:
                                  TextOverflow.ellipsis,

                              style: TextStyle(

                                fontSize: 11,

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

                      width: double.infinity,

                      height: 40,

                      child: ElevatedButton.icon(

                        style:
                            ElevatedButton.styleFrom(

                          elevation: 0,

                          backgroundColor:
                              widget.product.stock <= 0
                                  ? Colors.grey
                                  : AppColors.primary,

                          foregroundColor:
                              Colors.white,

                          shape:
                              RoundedRectangleBorder(

                            borderRadius:
                                BorderRadius.circular(
                              14,
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

                                    width: 16,

                                    height: 16,

                                    child:
                                        CircularProgressIndicator(

                                      color:
                                          Colors.white,

                                      strokeWidth: 2,
                                    ),
                                  )

                                : const Icon(

                                    Icons.shopping_cart_rounded,

                                    size: 18,
                                  ),

                        label: Text(

                          widget.product.stock <= 0
                              ? 'Unavailable'
                              : adding
                                  ? 'Adding...'
                                  : 'Add To Cart',

                          overflow:
                              TextOverflow.ellipsis,

                          style:
                              const TextStyle(

                            fontSize: 12,

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