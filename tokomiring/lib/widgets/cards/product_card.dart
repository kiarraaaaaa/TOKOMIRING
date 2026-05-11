// =====================================================
// lib/widgets/cards/product_card.dart
// FULL REVISI PREMIUM UI
// =====================================================

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_format.dart';

import '../../models/product_model.dart';

import '../../providers/cart_provider.dart';

class ProductCard
    extends StatelessWidget {

  final ProductModel product;

  const ProductCard({

    super.key,

    required this.product,
  });

  // =====================================================
  // STOCK COLOR
  // =====================================================

  Color getStockColor() {

    if (product.stock <= 0) {

      return AppColors.danger;
    }

    if (product.stock <= 5) {

      return AppColors.warning;
    }

    return AppColors.success;
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(
    BuildContext context,
  ) {

    final cartProvider =
        Provider.of<CartProvider>(

      context,

      listen: false,
    );

    return Container(

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
                Colors.black
                    .withOpacity(
              0.05,
            ),

            blurRadius:
                20,

            offset:
                const Offset(
              0,
              10,
            ),
          ),
        ],
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment
                .start,

        children: [

          // =================================================
          // IMAGE
          // =================================================

          Expanded(

            child: Stack(

              children: [

                // =============================================
                // IMAGE
                // =============================================

                Positioned.fill(

                  child: ClipRRect(

                    borderRadius:
                        const BorderRadius.only(

                      topLeft:
                          Radius.circular(
                        28,
                      ),

                      topRight:
                          Radius.circular(
                        28,
                      ),
                    ),

                    child:
                        product.imageBase64
                                .isEmpty

                            ? Container(

                                color:
                                    Colors.grey
                                        .shade200,

                                child:
                                    Icon(

                                  Icons
                                      .image_outlined,

                                  size: 60,

                                  color:
                                      Colors.grey
                                          .shade500,
                                ),
                              )

                            : Image.memory(

                                base64Decode(

                                  product
                                      .imageBase64,
                                ),

                                fit:
                                    BoxFit.cover,

                                errorBuilder: (

                                  context,

                                  error,

                                  stackTrace,

                                ) {

                                  return Container(

                                    color:
                                        Colors
                                            .grey
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

                // =============================================
                // DARK OVERLAY
                // =============================================

                Positioned.fill(

                  child: Container(

                    decoration:
                        BoxDecoration(

                      borderRadius:
                          const BorderRadius.only(

                        topLeft:
                            Radius.circular(
                          28,
                        ),

                        topRight:
                            Radius.circular(
                          28,
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
                            0.2,
                          ),

                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // =============================================
                // CATEGORY
                // =============================================

                Positioned(

                  top: 14,

                  left: 14,

                  child: Container(

                    padding:
                        const EdgeInsets.symmetric(

                      horizontal: 12,

                      vertical: 7,
                    ),

                    decoration:
                        BoxDecoration(

                      color:
                          Colors.black
                              .withOpacity(
                        0.65,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        30,
                      ),
                    ),

                    child: Text(

                      product.category,

                      style:
                          const TextStyle(

                        color:
                            Colors.white,

                        fontSize: 11,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // =============================================
                // STOCK BADGE
                // =============================================

                Positioned(

                  top: 14,

                  right: 14,

                  child: Container(

                    padding:
                        const EdgeInsets.symmetric(

                      horizontal: 10,

                      vertical: 7,
                    ),

                    decoration:
                        BoxDecoration(

                      color:
                          getStockColor(),

                      borderRadius:
                          BorderRadius.circular(
                        30,
                      ),
                    ),

                    child: Text(

                      product.stock <= 0

                          ? 'Sold Out'

                          : product.stock <= 5

                              ? 'Low Stock'

                              : 'Ready',

                      style:
                          const TextStyle(

                        color:
                            Colors.white,

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

          // =================================================
          // CONTENT
          // =================================================

          Padding(

            padding:
                const EdgeInsets.all(
              16,
            ),

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                // =============================================
                // NAME
                // =============================================

                Text(

                  product.name,

                  maxLines: 2,

                  overflow:
                      TextOverflow
                          .ellipsis,

                  style:
                      const TextStyle(

                    fontSize: 18,

                    fontWeight:
                        FontWeight.bold,

                    height: 1.3,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                // =============================================
                // PRICE
                // =============================================

                Text(

                  AppFormat.currency(
                    product.price,
                  ),

                  style:
                      const TextStyle(

                    fontSize: 22,

                    fontWeight:
                        FontWeight.bold,

                    color:
                        AppColors.success,
                  ),
                ),

                const SizedBox(
                  height: 14,
                ),

                // =============================================
                // STOCK INFO
                // =============================================

                Container(

                  padding:
                      const EdgeInsets.symmetric(

                    horizontal: 14,

                    vertical: 10,
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
                      14,
                    ),
                  ),

                  child: Row(

                    children: [

                      Icon(

                        Icons.inventory_2_rounded,

                        size: 18,

                        color:
                            getStockColor(),
                      ),

                      const SizedBox(
                        width: 8,
                      ),

                      Expanded(

                        child: Text(

                          'Stock: ${product.stock}',

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

                const SizedBox(
                  height: 16,
                ),

                // =============================================
                // BUTTON
                // =============================================

                SizedBox(

                  width:
                      double.infinity,

                  height: 48,

                  child:
                      ElevatedButton.icon(

                    style:
                        ElevatedButton.styleFrom(

                      elevation: 0,

                      backgroundColor:

                          product.stock <= 0

                              ? Colors.grey

                              : AppColors.primary,

                      foregroundColor:
                          Colors.white,

                      shape:
                          RoundedRectangleBorder(

                        borderRadius:
                            BorderRadius.circular(
                          16,
                        ),
                      ),
                    ),

                    onPressed:

                        product.stock <= 0

                            ? null

                            : () {

                                // =============================
                                // ADD TO CART
                                // =============================

                                cartProvider
                                    .addToCart(
                                  product,
                                );

                                // =============================
                                // SNACKBAR
                                // =============================

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

                                    shape:
                                        RoundedRectangleBorder(

                                      borderRadius:
                                          BorderRadius.circular(
                                        16,
                                      ),
                                    ),

                                    content:
                                        Text(

                                      '${product.name} added to cart',
                                    ),

                                    duration:
                                        const Duration(
                                      seconds: 1,
                                    ),
                                  ),
                                );
                              },

                    icon: Icon(

                      product.stock <= 0

                          ? Icons.block_rounded

                          : Icons
                              .shopping_cart_rounded,
                    ),

                    label: Text(

                      product.stock <= 0

                          ? 'Out Of Stock'

                          : 'Add To Cart',

                      style:
                          const TextStyle(

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}