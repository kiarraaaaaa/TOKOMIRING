// lib/screens/user/cart_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_format.dart';

import '../../providers/cart_provider.dart';

import '../../routes/app_routes.dart';

import '../../widgets/cards/cart_item_card.dart';

class CartScreen
    extends StatefulWidget {

  const CartScreen({
    super.key,
  });

  @override
  State<CartScreen>
      createState() =>
          _CartScreenState();
}

class _CartScreenState
    extends State<CartScreen>
    with
        SingleTickerProviderStateMixin {

  late AnimationController
      _animationController;

  late Animation<double>
      _fadeAnimation;

  // =====================================================
  // INIT
  // =====================================================

  @override
  void initState() {

    super.initState();

    _animationController =
        AnimationController(

      vsync: this,

      duration:
          const Duration(
        milliseconds: 500,
      ),
    );

    _fadeAnimation =
        CurvedAnimation(

      parent:
          _animationController,

      curve:
          Curves.easeOut,
    );

    _animationController
        .forward();
  }

  // =====================================================
  // DISPOSE
  // =====================================================

  @override
  void dispose() {

    _animationController
        .dispose();

    super.dispose();
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(
    BuildContext context,
  ) {

    final cartProvider =
        context.watch<
            CartProvider>();

    final screenWidth =
        MediaQuery.of(context)
            .size
            .width;

    final isTablet =
        screenWidth >= 700;

    return Scaffold(

      backgroundColor:
          const Color(
        0xffF5F7FB,
      ),

      // ===================================================
      // APPBAR
      // ===================================================

      appBar: AppBar(

        elevation: 0,

        backgroundColor:
            Colors.transparent,

        surfaceTintColor:
            Colors.transparent,

        centerTitle: false,

        titleSpacing: 20,

        title: const Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(

              'Shopping Cart',

              style: TextStyle(

                color:
                    Colors.black,

                fontSize: 24,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            SizedBox(
              height: 2,
            ),

            Text(

              'Premium marketplace checkout',

              style: TextStyle(

                color: Colors.grey,

                fontSize: 13,
              ),
            ),
          ],
        ),
      ),

      // ===================================================
      // EMPTY
      // ===================================================

      body:
          cartProvider.isEmpty

              ? FadeTransition(

                  opacity:
                      _fadeAnimation,

                  child: Center(

                    child: Padding(

                      padding:
                          const EdgeInsets.all(
                        24,
                      ),

                      child: Column(

                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,

                        children: [

                          Container(

                            width: 180,

                            height: 180,

                            decoration:
                                BoxDecoration(

                              shape:
                                  BoxShape.circle,

                              gradient:
                                  LinearGradient(

                                colors: [

                                  AppColors
                                      .primary
                                      .withOpacity(
                                    0.15,
                                  ),

                                  AppColors
                                      .primary
                                      .withOpacity(
                                    0.05,
                                  ),
                                ],
                              ),
                            ),

                            child:
                                const Icon(

                              Icons
                                  .shopping_bag_outlined,

                              size: 90,

                              color:
                                  AppColors
                                      .primary,
                            ),
                          ),

                          const SizedBox(
                            height: 30,
                          ),

                          const Text(

                            'Your Cart is Empty',

                            textAlign:
                                TextAlign.center,

                            style: TextStyle(

                              fontSize: 28,

                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(
                            height: 14,
                          ),

                          Text(

                            'Add products and enjoy premium shopping experience.',

                            textAlign:
                                TextAlign.center,

                            style: TextStyle(

                              color:
                                  Colors
                                      .grey
                                      .shade600,

                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )

              // =================================================
              // CART CONTENT
              // =================================================

              : FadeTransition(

                  opacity:
                      _fadeAnimation,

                  child: Stack(

                    children: [

                      // =========================================
                      // CONTENT
                      // =========================================

                      Padding(

                        padding:
                            const EdgeInsets.only(
                          bottom: 240,
                        ),

                        child: SingleChildScrollView(

                          physics:
                              const BouncingScrollPhysics(),

                          padding:
                              const EdgeInsets.all(
                            20,
                          ),

                          child: Column(

                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [

                              // =================================
                              // ANALYTICS
                              // =================================

                              Wrap(

                                spacing: 16,

                                runSpacing: 16,

                                children: [

                                  _buildAnalyticsCard(

                                    title:
                                        'Items',

                                    value:
                                        '${cartProvider.totalItems}',

                                    icon:
                                        Icons.shopping_cart,

                                    color:
                                        Colors.blue,
                                  ),

                                  _buildAnalyticsCard(

                                    title:
                                        'Products',

                                    value:
                                        '${cartProvider.totalUniqueProducts}',

                                    icon:
                                        Icons.inventory_2,

                                    color:
                                        Colors.orange,
                                  ),

                                  _buildAnalyticsCard(

                                    title:
                                        'Subtotal',

                                    value:
                                        AppFormat.currency(
                                      cartProvider
                                          .totalPrice,
                                    ),

                                    icon:
                                        Icons.payments,

                                    color:
                                        Colors.green,
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 30,
                              ),

                              // =================================
                              // TITLE
                              // =================================

                              Row(

                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,

                                children: [

                                  const Expanded(

                                    child: Text(

                                      'Cart Products',

                                      overflow:
                                          TextOverflow
                                              .ellipsis,

                                      style:
                                          TextStyle(

                                        fontSize:
                                            24,

                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  Text(

                                    '${cartProvider.totalItems} Items',

                                    style:
                                        TextStyle(

                                      color:
                                          Colors
                                              .grey
                                              .shade600,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 20,
                              ),

                              // =================================
                              // LIST
                              // =================================

                              ListView.separated(

                                shrinkWrap:
                                    true,

                                physics:
                                    const NeverScrollableScrollPhysics(),

                                itemCount:
                                    cartProvider
                                        .items
                                        .length,

                                separatorBuilder:
                                    (
                                      context,
                                      index,
                                    ) {

                                  return const SizedBox(
                                    height:
                                        18,
                                  );
                                },

                                itemBuilder:
                                    (
                                      context,
                                      index,
                                    ) {

                                  final item =
                                      cartProvider
                                              .items[
                                          index];

                                  return AnimatedContainer(

                                    duration:
                                        const Duration(
                                      milliseconds:
                                          250,
                                    ),

                                    child:
                                        CartItemCard(
                                      item:
                                          item,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      // =========================================
                      // FLOATING SUMMARY
                      // =========================================

                      Positioned(

                        left: 20,

                        right: 20,

                        bottom: 20,

                        child:
                            AnimatedContainer(

                          duration:
                              const Duration(
                            milliseconds:
                                250,
                          ),

                          constraints:
                              BoxConstraints(

                            maxWidth:
                                isTablet
                                    ? 600
                                    : double
                                        .infinity,
                          ),

                          padding:
                              const EdgeInsets.all(
                            24,
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
                                    Colors
                                        .black
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
                              // SUBTOTAL
                              // =============================

                              _buildPriceRow(

                                title:
                                    'Subtotal',

                                value:
                                    AppFormat.currency(
                                  cartProvider
                                      .totalPrice,
                                ),
                              ),

                              const SizedBox(
                                height: 14,
                              ),

                              // =============================
                              // SHIPPING
                              // =============================

                              _buildPriceRow(

                                title:
                                    'Shipping',

                                value:
                                    'Free',
                              ),

                              const Padding(

                                padding:
                                    EdgeInsets.symmetric(
                                  vertical:
                                      18,
                                ),

                                child: Divider(),
                              ),

                              // =============================
                              // TOTAL
                              // =============================

                              Row(

                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,

                                children: [

                                  const Text(

                                    'Grand Total',

                                    style:
                                        TextStyle(

                                      fontSize:
                                          20,

                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),

                                  Flexible(

                                    child: Text(

                                      AppFormat.currency(
                                        cartProvider
                                            .totalPrice,
                                      ),

                                      overflow:
                                          TextOverflow
                                              .ellipsis,

                                      textAlign:
                                          TextAlign
                                              .right,

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

                                height: 60,

                                child:
                                    ElevatedButton(

                                  style:
                                      ElevatedButton.styleFrom(

                                    backgroundColor:
                                        AppColors
                                            .primary,

                                    foregroundColor:
                                        Colors
                                            .white,

                                    elevation:
                                        0,

                                    shape:
                                        RoundedRectangleBorder(

                                      borderRadius:
                                          BorderRadius.circular(
                                        20,
                                      ),
                                    ),
                                  ),

                                  onPressed: () {

                                    Navigator
                                        .pushNamed(

                                      context,

                                      AppRoutes
                                          .checkout,
                                    );
                                  },

                                  child:
                                      const Row(

                                    mainAxisAlignment:
                                        MainAxisAlignment
                                            .center,

                                    children: [

                                      Icon(
                                        Icons
                                            .shopping_bag,
                                      ),

                                      SizedBox(
                                        width:
                                            10,
                                      ),

                                      Text(

                                        'Proceed Checkout',

                                        style:
                                            TextStyle(

                                          fontSize:
                                              18,

                                          fontWeight:
                                              FontWeight.bold,
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
                    ],
                  ),
                ),
    );
  }

  // =====================================================
  // PRICE ROW
  // =====================================================

  Widget _buildPriceRow({

    required String title,

    required String value,

  }) {

    return Row(

      mainAxisAlignment:
          MainAxisAlignment
              .spaceBetween,

      children: [

        Text(

          title,

          style: TextStyle(

            color:
                Colors.grey
                    .shade700,

            fontSize: 15,
          ),
        ),

        Flexible(

          child: Text(

            value,

            overflow:
                TextOverflow
                    .ellipsis,

            textAlign:
                TextAlign.right,

            style:
                const TextStyle(

              fontWeight:
                  FontWeight.bold,

              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  // =====================================================
  // ANALYTICS CARD
  // =====================================================

  Widget _buildAnalyticsCard({

    required String title,

    required String value,

    required IconData icon,

    required Color color,

  }) {

    return Container(

      width: 170,

      padding:
          const EdgeInsets.all(
        18,
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
              0.04,
            ),

            blurRadius:
                15,

            offset:
                const Offset(
              0,
              8,
            ),
          ),
        ],
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment
                .start,

        children: [

          Container(

            padding:
                const EdgeInsets.all(
              12,
            ),

            decoration:
                BoxDecoration(

              color:
                  color.withOpacity(
                0.12,
              ),

              borderRadius:
                  BorderRadius.circular(
                18,
              ),
            ),

            child: Icon(

              icon,

              color:
                  color,
            ),
          ),

          const SizedBox(
            height: 18,
          ),

          Text(

            value,

            overflow:
                TextOverflow
                    .ellipsis,

            style:
                const TextStyle(

              fontSize: 22,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 4,
          ),

          Text(

            title,

            overflow:
                TextOverflow
                    .ellipsis,

            style: TextStyle(

              color:
                  Colors
                      .grey
                      .shade600,
            ),
          ),
        ],
      ),
    );
  }
}