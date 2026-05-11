// lib/widgets/cards/cart_item_card.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/app_format.dart';

import '../../providers/cart_provider.dart';

class CartItemCard
    extends StatelessWidget {

  final CartItemModel item;

  const CartItemCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    return Card(
      elevation: 5,

      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(
          22,
        ),
      ),

      child: Padding(
        padding:
            const EdgeInsets.all(
          16,
        ),

        child: Row(
          children: [

            // =====================================
            // IMAGE
            // =====================================

            ClipRRect(
              borderRadius:
                  BorderRadius.circular(
                16,
              ),

              child:
                  item.product
                          .imageBase64
                          .isEmpty
                      ? Container(
                          width: 90,

                          height: 90,

                          color:
                              Colors.grey
                                  .shade300,

                          child:
                              const Icon(
                            Icons.image,
                            size: 40,
                          ),
                        )

                      : Image.memory(
                          base64Decode(
                            item.product
                                .imageBase64,
                          ),

                          width: 90,

                          height: 90,

                          fit:
                              BoxFit.cover,

                          errorBuilder: (
                            context,
                            error,
                            stackTrace,
                          ) {

                            return Container(
                              width: 90,

                              height: 90,

                              color:
                                  Colors.grey
                                      .shade300,

                              child:
                                  const Icon(
                                Icons
                                    .broken_image,
                                size: 40,
                              ),
                            );
                          },
                        ),
            ),

            const SizedBox(
              width: 20,
            ),

            // =====================================
            // PRODUCT INFO
            // =====================================

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  // =================================
                  // NAME
                  // =================================

                  Text(
                    item.product.name,

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
                      item.product.price,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // =================================
                  // SUBTOTAL
                  // =================================

                  Text(
                    'Subtotal: ${AppFormat.currency(item.subtotal)}',

                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // =====================================
            // QUANTITY
            // =====================================

            Column(
              children: [

                // =================================
                // INCREASE
                // =================================

                IconButton(
                  onPressed: () {

                    Provider.of<
                        CartProvider>(
                      context,
                      listen: false,
                    ).increaseQuantity(
                      item.product.id,
                    );
                  },

                  icon: const Icon(
                    Icons.add_circle,
                  ),
                ),

                // =================================
                // QTY
                // =================================

                Text(
                  '${item.quantity}',

                  style:
                      const TextStyle(
                    fontSize: 18,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                // =================================
                // DECREASE
                // =================================

                IconButton(
                  onPressed: () {

                    Provider.of<
                        CartProvider>(
                      context,
                      listen: false,
                    ).decreaseQuantity(
                      item.product.id,
                    );
                  },

                  icon: const Icon(
                    Icons.remove_circle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}