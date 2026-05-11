// lib/widgets/cards/cart_item_card.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
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

    return Container(

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
          24,
        ),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black
                    .withOpacity(
              0.05,
            ),

            blurRadius:
                18,

            offset:
                const Offset(
              0,
              8,
            ),
          ),
        ],
      ),

      child: Padding(

        padding:
            const EdgeInsets.all(
          16,
        ),

        child: Row(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // =====================================
            // IMAGE
            // =====================================

            ClipRRect(

              borderRadius:
                  BorderRadius.circular(
                18,
              ),

              child:
                  item.product
                          .imageBase64
                          .isEmpty

                      ? Container(

                          width: 95,

                          height: 95,

                          color:
                              Colors.grey
                                  .shade200,

                          child:
                              Icon(

                            Icons.image_outlined,

                            size: 42,

                            color:
                                Colors.grey
                                    .shade500,
                          ),
                        )

                      : Image.memory(

                          base64Decode(

                            item.product
                                .imageBase64,
                          ),

                          width: 95,

                          height: 95,

                          fit:
                              BoxFit.cover,

                          errorBuilder: (

                            context,

                            error,

                            stackTrace,

                          ) {

                            return Container(

                              width: 95,

                              height: 95,

                              color:
                                  Colors.grey
                                      .shade200,

                              child:
                                  Icon(

                                Icons
                                    .broken_image_outlined,

                                size: 42,

                                color:
                                    Colors.grey
                                        .shade500,
                              ),
                            );
                          },
                        ),
            ),

            const SizedBox(
              width: 18,
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

                    maxLines: 2,

                    overflow:
                        TextOverflow
                            .ellipsis,

                    style:
                        const TextStyle(

                      fontSize: 17,

                      fontWeight:
                          FontWeight.bold,

                      height: 1.3,
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  // =================================
                  // PRICE
                  // =================================

                  Text(

                    AppFormat.currency(

                      item.product.price,
                    ),

                    style:
                        TextStyle(

                      fontSize: 14,

                      color:
                          Colors.grey
                              .shade700,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // =================================
                  // SUBTOTAL
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
                          AppColors.success
                              .withOpacity(
                        0.1,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),
                    ),

                    child: Text(

                      'Subtotal: ${AppFormat.currency(item.subtotal)}',

                      style:
                          const TextStyle(

                        color:
                            AppColors.success,

                        fontWeight:
                            FontWeight.bold,

                        fontSize: 13,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 14,
                  ),

                  // =================================
                  // REMOVE
                  // =================================

                  GestureDetector(

                    onTap: () {

                      Provider.of<
                          CartProvider>(

                        context,

                        listen: false,

                      ).removeFromCart(
                        item.product.id,
                      );
                    },

                    child: Row(

                      mainAxisSize:
                          MainAxisSize.min,

                      children: [

                        const Icon(

                          Icons.delete_outline,

                          color:
                              AppColors.danger,

                          size: 18,
                        ),

                        const SizedBox(
                          width: 6,
                        ),

                        const Text(

                          'Remove',

                          style: TextStyle(

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
                ],
              ),
            ),

            const SizedBox(
              width: 12,
            ),

            // =====================================
            // QUANTITY BOX
            // =====================================

            Container(

              padding:
                  const EdgeInsets.symmetric(

                horizontal: 10,

                vertical: 10,
              ),

              decoration:
                  BoxDecoration(

                color:
                    Colors.grey
                        .shade100,

                borderRadius:
                    BorderRadius.circular(
                  18,
                ),
              ),

              child: Column(

                children: [

                  // =================================
                  // ADD
                  // =================================

                  InkWell(

                    borderRadius:
                        BorderRadius.circular(
                      100,
                    ),

                    onTap: () {

                      Provider.of<
                          CartProvider>(

                        context,

                        listen: false,

                      ).increaseQuantity(
                        item.product.id,
                      );
                    },

                    child: Container(

                      padding:
                          const EdgeInsets.all(
                        4,
                      ),

                      decoration:
                          const BoxDecoration(

                        color:
                            AppColors.success,

                        shape:
                            BoxShape.circle,
                      ),

                      child: const Icon(

                        Icons.add,

                        size: 18,

                        color:
                            Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 12,
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

                  const SizedBox(
                    height: 12,
                  ),

                  // =================================
                  // MINUS
                  // =================================

                  InkWell(

                    borderRadius:
                        BorderRadius.circular(
                      100,
                    ),

                    onTap: () {

                      Provider.of<
                          CartProvider>(

                        context,

                        listen: false,

                      ).decreaseQuantity(
                        item.product.id,
                      );
                    },

                    child: Container(

                      padding:
                          const EdgeInsets.all(
                        4,
                      ),

                      decoration:
                          const BoxDecoration(

                        color:
                            AppColors.danger,

                        shape:
                            BoxShape.circle,
                      ),

                      child: const Icon(

                        Icons.remove,

                        size: 18,

                        color:
                            Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}