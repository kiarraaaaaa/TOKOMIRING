// =====================================================
// lib/widgets/cards/product_card.dart
// COMPACT PREMIUM VERSION
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

  Color getStockColor() {

    if (widget.product.stock <= 0) {
      return AppColors.danger;
    }

    if (widget.product.stock <= 5) {
      return AppColors.warning;
    }

    return AppColors.success;
  }

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
        milliseconds: 500,
      ),
    );

    if (!mounted) return;

    setState(() {

      adding = false;
    });
  }

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
            ? 90.0
            : isTablet
                ? 84.0
                : 78.0;

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
          milliseconds: 180,
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
            18,
          ),

          border: Border.all(

            color:

                hovered

                    ? AppColors.primary
                        .withOpacity(
                      0.08,
                    )

                    : Colors.transparent,
          ),

          boxShadow: [

            BoxShadow(

              color:
                  Colors.black
                      .withOpacity(
                hovered
                    ? 0.05
                    : 0.03,
              ),

              blurRadius:
                  hovered
                      ? 14
                      : 8,

              offset:
                  Offset(
                0,
                hovered
                    ? 8
                    : 4,
              ),
            ),
          ],
        ),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment
                  .start,

          children: [

            // IMAGE

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
                          18,
                        ),

                        topRight:
                            Radius.circular(
                          18,
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
                                        26,

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
                                  ),
                                ),
                    ),
                  ),

                  // FAVORITE

                  Positioned(

                    top: 6,

                    right: 6,

                    child:
                        GestureDetector(

                      onTap: () {

                        productProvider
                            .toggleFavorite(
                          widget.product,
                        );
                      },

                      child: Container(

                        width: 24,

                        height: 24,

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

                                  : Colors.black54,

                          size: 12,
                        ),
                      ),
                    ),
                  ),

                  // CATEGORY

                  Positioned(

                    top: 6,

                    left: 6,

                    child: Container(

                      padding:
                          const EdgeInsets.symmetric(

                        horizontal: 7,

                        vertical: 3,
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
                          14,
                        ),
                      ),

                      child: Text(

                        widget.product.category,

                        style:
                            const TextStyle(

                          color:
                              Colors.white,

                          fontSize: 7,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // CONTENT

            Expanded(

              child: Padding(

                padding:
                    const EdgeInsets.all(
                  9,
                ),

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

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
                                ? 12
                                : 11,

                        fontWeight:
                            FontWeight.w700,

                        height: 1.2,
                      ),
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    Text(

                      AppFormat.currency(
                        widget.product.price,
                      ),

                      overflow:
                          TextOverflow
                              .ellipsis,

                      style:
                          const TextStyle(

                        fontSize: 14,

                        fontWeight:
                            FontWeight.bold,

                        color:
                            AppColors.success,
                      ),
                    ),

                    const SizedBox(
                      height: 6,
                    ),

                    Container(

                      padding:
                          const EdgeInsets.symmetric(

                        horizontal: 7,

                        vertical: 5,
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
                          9,
                        ),
                      ),

                      child: Row(

                        children: [

                          Icon(

                            Icons
                                .inventory_2_rounded,

                            size: 11,

                            color:
                                getStockColor(),
                          ),

                          const SizedBox(
                            width: 4,
                          ),

                          Expanded(

                            child: Text(

                              'Stock ${widget.product.stock}',

                              overflow:
                                  TextOverflow
                                      .ellipsis,

                              style:
                                  TextStyle(

                                fontSize: 9,

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

                    SizedBox(

                      width:
                          double.infinity,

                      height: 32,

                      child:
                          ElevatedButton.icon(

                        style:
                            ElevatedButton.styleFrom(

                          elevation: 0,

                          backgroundColor:

                              widget.product.stock <= 0

                                  ? Colors.grey

                                  : AppColors.primary,

                          foregroundColor:
                              Colors.white,

                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),

                          shape:
                              RoundedRectangleBorder(

                            borderRadius:
                                BorderRadius.circular(
                              10,
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
                                        12,

                                    height:
                                        12,

                                    child:
                                        CircularProgressIndicator(

                                      color:
                                          Colors.white,

                                      strokeWidth:
                                          2,
                                    ),
                                  )

                                : const Icon(

                                    Icons
                                        .shopping_cart_rounded,

                                    size:
                                        13,
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

                            fontSize: 10,

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