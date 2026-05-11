// =====================================================
// lib/widgets/cards/product_card.dart
// FULL REVISI FIX
// =====================================================

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(
    BuildContext context,
  ) {

    return Card(
      elevation: 6,

      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(
          24,
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          // =====================================
          // IMAGE
          // =====================================

          Expanded(
            child: Stack(
              children: [

                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(
                    top:
                        Radius.circular(
                      24,
                    ),
                  ),

                  child:
                      product.imageBase64
                              .isEmpty

                          ? Container(
                              width:
                                  double.infinity,

                              color:
                                  Colors.grey
                                      .shade300,

                              child:
                                  const Center(
                                child: Icon(
                                  Icons.image,

                                  size: 60,
                                ),
                              ),
                            )

                          : Image.memory(
                              base64Decode(
                                product
                                    .imageBase64,
                              ),

                              width:
                                  double.infinity,

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
                                          .shade300,

                                  child:
                                      const Center(
                                    child: Icon(
                                      Icons
                                          .broken_image,

                                      size: 50,
                                    ),
                                  ),
                                );
                              },
                            ),
                ),

                // =================================
                // CATEGORY BADGE
                // =================================

                Positioned(
                  top: 12,
                  left: 12,

                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),

                    decoration:
                        BoxDecoration(
                      color:
                          Colors.black
                              .withOpacity(
                        0.7,
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

                // =================================
                // LOW STOCK BADGE
                // =================================

                if (product.stock <= 5)

                  Positioned(
                    top: 12,
                    right: 12,

                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),

                      decoration:
                          BoxDecoration(
                        color:
                            Colors.red,

                        borderRadius:
                            BorderRadius.circular(
                          30,
                        ),
                      ),

                      child: const Text(
                        'Low Stock',

                        style:
                            TextStyle(
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

          // =====================================
          // CONTENT
          // =====================================

          Padding(
            padding:
                const EdgeInsets.all(
              14,
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                // =================================
                // PRODUCT NAME
                // =================================

                Text(
                  product.name,

                  maxLines: 1,

                  overflow:
                      TextOverflow
                          .ellipsis,

                  style:
                      const TextStyle(
                    fontSize: 18,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                // =================================
                // PRICE
                // =================================

                Text(
                  AppFormat.currency(
                    product.price,
                  ),

                  style:
                      const TextStyle(
                    fontSize: 18,

                    fontWeight:
                        FontWeight.bold,

                    color:
                        Colors.green,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                // =================================
                // STOCK INFO
                // =================================

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),

                  decoration:
                      BoxDecoration(
                    color:
                        product.stock <=
                                5
                            ? Colors.red
                                .shade50
                            : Colors.green
                                .shade50,

                    borderRadius:
                        BorderRadius.circular(
                      12,
                    ),
                  ),

                  child: Row(
                    children: [

                      Icon(
                        Icons.inventory_2,

                        size: 18,

                        color:
                            product.stock <=
                                    5
                                ? Colors.red
                                : Colors.green,
                      ),

                      const SizedBox(
                        width: 8,
                      ),

                      Text(
                        'Stock: ${product.stock}',

                        style: TextStyle(
                          fontWeight:
                              FontWeight.bold,

                          color:
                              product.stock <=
                                      5
                                  ? Colors.red
                                  : Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 14,
                ),

                // =================================
                // BUTTON
                // =================================

                SizedBox(
                  width:
                      double.infinity,

                  height: 45,

                  child:
                      ElevatedButton.icon(
                    onPressed:
                        product.stock <=
                                0

                            ? null

                            : () {

                                Provider.of<
                                    CartProvider>(
                                  context,
                                  listen:
                                      false,
                                ).addToCart(
                                  product,
                                );

                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text(
                                      '${product.name} added to cart',
                                    ),
                                  ),
                                );
                              },

                    icon: const Icon(
                      Icons.shopping_cart,
                    ),

                    label:
                        const Text(
                      'Add To Cart',
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