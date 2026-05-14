// =====================================================
// lib/widgets/cards/product_card.dart
// PREMIUM ECOMMERCE VERSION
// =====================================================

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_format.dart';

import '../../models/product_model.dart';

import '../../providers/cart_provider.dart';

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

  // =====================================================
  // STOCK COLOR
  // =====================================================

  Color getStockColor() {

    if (widget.product.stock <= 0) {

      return AppColors.danger;
    }

    if (widget.product.stock <= 5) {

      return AppColors.warning;
    }

    return AppColors.success;
  }

  // =====================================================
  // ADD TO CART
  // =====================================================

  Future<void> addToCart(
    BuildContext context,
  ) async {

    if (adding) {
      return;
    }

    setState(() {

      adding = true;
    });

    final cartProvider =
        context.read<
            CartProvider>();

    cartProvider.addToCart(
      widget.product,
    );

    await Future.delayed(
      const Duration(
        milliseconds: 700,
      ),
    );

    if (!mounted) {
      return;
    }

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

        margin:
            const EdgeInsets.all(
          16,
        ),

        backgroundColor:
            AppColors.primary,

        shape:
            RoundedRectangleBorder(

          borderRadius:
              BorderRadius.circular(
            18,
          ),
        ),

        content: Row(

          children: [

            const Icon(

              Icons.check_circle,

              color:
                  Colors.white,
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

    final isTablet =
        screenWidth >= 700;

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
                ? 1.02
                : 1,

        child:
            AnimatedContainer(

          duration:
              const Duration(
            milliseconds: 220,
          ),

          decoration:
              BoxDecoration(

            color:
                Colors.white,

            borderRadius:
                BorderRadius.circular(
              30,
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
                        ? 28
                        : 18,

                offset:
                    Offset(
                  0,
                  hovered
                      ? 14
                      : 8,
                ),
              ),
            ],
          ),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [

              // =============================================
              // IMAGE
              // =============================================

              Expanded(

                flex: 5,

                child: Stack(

                  children: [

                    // =========================================
                    // IMAGE
                    // =========================================

                    Positioned.fill(

                      child: ClipRRect(

                        borderRadius:
                            const BorderRadius.only(

                          topLeft:
                              Radius.circular(
                            30,
                          ),

                          topRight:
                              Radius.circular(
                            30,
                          ),
                        ),

                        child:
                            widget.product.imageBase64
                                    .isEmpty

                                ? Container(

                                    color:
                                        Colors
                                            .grey
                                            .shade200,

                                    child:
                                        Icon(

                                      Icons
                                          .image_outlined,

                                      size:
                                          isTablet
                                              ? 70
                                              : 50,

                                      color:
                                          Colors
                                              .grey
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
                                              .high,

                                      errorBuilder: (

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
                                                50,

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

                    // =========================================
                    // PREMIUM OVERLAY
                    // =========================================

                    Positioned.fill(

                      child: Container(

                        decoration:
                            BoxDecoration(

                          borderRadius:
                              const BorderRadius.only(

                            topLeft:
                                Radius.circular(
                              30,
                            ),

                            topRight:
                                Radius.circular(
                              30,
                            ),
                          ),

                          gradient:
                              LinearGradient(

                            begin:
                                Alignment
                                    .bottomCenter,

                            end:
                                Alignment
                                    .topCenter,

                            colors: [

                              Colors.black
                                  .withOpacity(
                                0.28,
                              ),

                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),

                    // =========================================
                    // CATEGORY
                    // =========================================

                    Positioned(

                      top: 14,

                      left: 14,

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
                              12,

                          vertical:
                              7,
                        ),

                        decoration:
                            BoxDecoration(

                          color:
                              Colors.black
                                  .withOpacity(
                            0.6,
                          ),

                          borderRadius:
                              BorderRadius.circular(
                            30,
                          ),
                        ),

                        child: Text(

                          widget.product
                              .category,

                          style:
                              const TextStyle(

                            color:
                                Colors.white,

                            fontSize:
                                10,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // =========================================
                    // STOCK BADGE
                    // =========================================

                    Positioned(

                      top: 14,

                      right: 14,

                      child: Container(

                        padding:
                            const EdgeInsets.symmetric(

                          horizontal:
                              12,

                          vertical:
                              7,
                        ),

                        decoration:
                            BoxDecoration(

                          color:
                              getStockColor(),

                          borderRadius:
                              BorderRadius.circular(
                            30,
                          ),

                          boxShadow: [

                            BoxShadow(

                              color:
                                  getStockColor()
                                      .withOpacity(
                                0.35,
                              ),

                              blurRadius:
                                  10,
                            ),
                          ],
                        ),

                        child: Text(

                          widget.product
                                      .stock <=
                                  0

                              ? 'Sold Out'

                              : widget.product
                                          .stock <=
                                      5

                                  ? 'Low Stock'

                                  : 'Ready',

                          style:
                              const TextStyle(

                            color:
                                Colors.white,

                            fontSize:
                                10,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // =============================================
              // CONTENT
              // =============================================

              Expanded(

                flex: 4,

                child: Padding(

                  padding:
                      const EdgeInsets.all(
                    16,
                  ),

                  child: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [

                      // =======================================
                      // NAME
                      // =======================================

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
                                  ? 18
                                  : 16,

                          fontWeight:
                              FontWeight.bold,

                          height: 1.3,
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      // =======================================
                      // PRICE
                      // =======================================

                      Text(

                        AppFormat.currency(
                          widget.product.price,
                        ),

                        overflow:
                            TextOverflow
                                .ellipsis,

                        style:
                            const TextStyle(

                          fontSize: 22,

                          fontWeight:
                              FontWeight.bold,

                          color:
                              AppColors
                                  .success,
                        ),
                      ),

                      const SizedBox(
                        height: 14,
                      ),

                      // =======================================
                      // STOCK INFO
                      // =======================================

                      Container(

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
                              getStockColor()
                                  .withOpacity(
                            0.1,
                          ),

                          borderRadius:
                              BorderRadius.circular(
                            16,
                          ),
                        ),

                        child: Row(

                          children: [

                            Icon(

                              Icons
                                  .inventory_2_rounded,

                              size: 18,

                              color:
                                  getStockColor(),
                            ),

                            const SizedBox(
                              width: 8,
                            ),

                            Expanded(

                              child: Text(

                                'Stock: ${widget.product.stock}',

                                overflow:
                                    TextOverflow
                                        .ellipsis,

                                style:
                                    TextStyle(

                                  color:
                                      getStockColor(),

                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      // =======================================
                      // BUTTON
                      // =======================================

                      SizedBox(

                        width:
                            double.infinity,

                        height: 50,

                        child:
                            AnimatedSwitcher(

                          duration:
                              const Duration(
                            milliseconds:
                                220,
                          ),

                          child:
                              ElevatedButton.icon(

                            key: ValueKey(
                              adding,
                            ),

                            style:
                                ElevatedButton.styleFrom(

                              elevation: 0,

                              backgroundColor:

                                  widget.product
                                              .stock <=
                                          0

                                      ? Colors.grey

                                      : AppColors
                                          .primary,

                              foregroundColor:
                                  Colors.white,

                              shape:
                                  RoundedRectangleBorder(

                                borderRadius:
                                    BorderRadius.circular(
                                  18,
                                ),
                              ),
                            ),

                            onPressed:

                                widget.product
                                            .stock <=
                                        0

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
                                            18,

                                        height:
                                            18,

                                        child:
                                            CircularProgressIndicator(

                                          color:
                                              Colors
                                                  .white,

                                          strokeWidth:
                                              2,
                                        ),
                                      )

                                    : Icon(

                                        widget.product
                                                    .stock <=
                                                0

                                            ? Icons
                                                .block_rounded

                                            : Icons
                                                .shopping_cart_rounded,
                                      ),

                            label: Text(

                              widget.product
                                          .stock <=
                                      0

                                  ? 'Out Of Stock'

                                  : adding

                                      ? 'Adding...'

                                      : 'Add To Cart',

                              style:
                                  const TextStyle(

                                fontWeight:
                                    FontWeight.bold,
                              ),
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
      ),
    );
  }
}