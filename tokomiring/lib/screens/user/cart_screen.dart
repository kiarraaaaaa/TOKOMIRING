// lib/screens/user/cart_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_format.dart';

import '../../providers/cart_provider.dart';

import '../../routes/app_routes.dart';

import '../../widgets/cards/cart_item_card.dart';

class CartScreen
    extends StatelessWidget {

  const CartScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    final cartProvider =
        Provider.of<CartProvider>(
      context,
    );

    return Scaffold(

      backgroundColor:
          AppColors.background,

      // ===================================================
      // APP BAR
      // ===================================================

      appBar: AppBar(

        elevation: 0,

        backgroundColor:
            Colors.white,

        foregroundColor:
            Colors.black,

        centerTitle: true,

        title: const Text(

          'My Cart',

          style: TextStyle(

            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      // ===================================================
      // EMPTY
      // ===================================================

      body:
          cartProvider.isEmpty

              ? Center(

                  child: Padding(

                    padding:
                        const EdgeInsets.all(
                      24,
                    ),

                    child: Column(

                      mainAxisAlignment:
                          MainAxisAlignment.center,

                      children: [

                        Container(

                          width: 180,

                          height: 180,

                          decoration:
                              BoxDecoration(

                            shape:
                                BoxShape.circle,

                            color:
                                AppColors.primary
                                    .withOpacity(
                              0.08,
                            ),
                          ),

                          child:
                              Icon(

                            Icons.shopping_cart_outlined,

                            size: 100,

                            color:
                                AppColors.primary,
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        const Text(

                          'Cart is Empty',

                          style: TextStyle(

                            fontSize: 28,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 12,
                        ),

                        Text(

                          'Add your favorite products first',

                          textAlign:
                              TextAlign.center,

                          style: TextStyle(

                            color:
                                Colors.grey
                                    .shade600,

                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                )

              // =================================================
              // CART CONTENT
              // =================================================

              : Stack(

                  children: [

                    // =============================================
                    // LIST
                    // =============================================

                    Padding(

                      padding:
                          const EdgeInsets.only(
                        bottom: 140,
                      ),

                      child: ListView.builder(

                        padding:
                            const EdgeInsets.all(
                          20,
                        ),

                        itemCount:
                            cartProvider
                                .items
                                .length,

                        itemBuilder:
                            (
                              context,
                              index,
                            ) {

                          final item =
                              cartProvider
                                      .items[
                                  index];

                          return Padding(

                            padding:
                                const EdgeInsets.only(
                              bottom: 18,
                            ),

                            child:
                                CartItemCard(
                              item:
                                  item,
                            ),
                          );
                        },
                      ),
                    ),

                    // =============================================
                    // FLOATING CHECKOUT
                    // =============================================

                    Positioned(

                      left: 20,

                      right: 20,

                      bottom: 20,

                      child: Container(

                        padding:
                            const EdgeInsets.all(
                          22,
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
                                  Colors.black
                                      .withOpacity(
                                0.08,
                              ),

                              blurRadius:
                                  30,

                              offset:
                                  const Offset(
                                0,
                                10,
                              ),
                            ),
                          ],
                        ),

                        child: Column(

                          mainAxisSize:
                              MainAxisSize.min,

                          children: [

                            // =============================
                            // TOTAL PRODUCT
                            // =============================

                            Row(

                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,

                              children: [

                                Text(

                                  'Total Product',

                                  style: TextStyle(

                                    color:
                                        Colors
                                            .grey
                                            .shade700,

                                    fontSize:
                                        15,
                                  ),
                                ),

                                Text(

                                  '${cartProvider.totalItems} Items',

                                  style:
                                      const TextStyle(

                                    fontSize:
                                        16,

                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 14,
                            ),

                            // =============================
                            // TOTAL PRICE
                            // =============================

                            Row(

                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,

                              children: [

                                const Text(

                                  'Total Price',

                                  style: TextStyle(

                                    fontSize:
                                        18,

                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),

                                Text(

                                  AppFormat.currency(
                                    cartProvider
                                        .totalPrice,
                                  ),

                                  style:
                                      const TextStyle(

                                    fontSize:
                                        24,

                                    color:
                                        AppColors
                                            .primary,

                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 24,
                            ),

                            // =============================
                            // BUTTON
                            // =============================

                            SizedBox(

                              width:
                                  double.infinity,

                              height: 58,

                              child:
                                  ElevatedButton(

                                style:
                                    ElevatedButton.styleFrom(

                                  backgroundColor:
                                      AppColors
                                          .primary,

                                  foregroundColor:
                                      Colors.white,

                                  elevation:
                                      0,

                                  shape:
                                      RoundedRectangleBorder(

                                    borderRadius:
                                        BorderRadius.circular(
                                      18,
                                    ),
                                  ),
                                ),

                                onPressed: () {

                                  Navigator.pushNamed(

                                    context,

                                    AppRoutes
                                        .checkout,
                                  );
                                },

                                child:
                                    const Text(

                                  'Checkout',

                                  style: TextStyle(

                                    fontSize:
                                        18,

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
    );
  }
}