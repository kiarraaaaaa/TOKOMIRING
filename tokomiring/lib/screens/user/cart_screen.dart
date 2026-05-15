// =====================================================
// lib/screens/user/cart_screen.dart
// CLEAN MODERN RESPONSIVE VERSION
// =====================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_format.dart';

import '../../providers/cart_provider.dart';
import '../../providers/product_provider.dart';

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

  @override
  void initState() {

    super.initState();

    _animationController =
        AnimationController(

      vsync: this,

      duration:
          const Duration(
        milliseconds: 450,
      ),
    );

    _fadeAnimation =
        CurvedAnimation(

      parent:
          _animationController,

      curve:
          Curves.easeOut,
    );

    _animationController.forward();
  }

  @override
  void dispose() {

    _animationController.dispose();

    super.dispose();
  }

  // =========================================
  // STOCK VALIDATION
  // =========================================

  bool _hasInvalidStock(

    CartProvider cartProvider,

    ProductProvider productProvider,
  ) {

    for (final item
        in cartProvider.items) {

      final product =
          productProvider
              .getProductById(
        item.productId,
      );

      if (product == null) {
        return true;
      }

      if (product.stock <= 0) {
        return true;
      }

      if (item.quantity >
          product.stock) {
        return true;
      }
    }

    return false;
  }

  // =========================================
  // BUILD
  // =========================================

  @override
  Widget build(
    BuildContext context,
  ) {

    final cartProvider =
        context.watch<CartProvider>();

    final productProvider =
        context.watch<ProductProvider>();

    final screenWidth =
        MediaQuery.of(context)
            .size
            .width;

    final isMobile =
        screenWidth < 700;

    final hasInvalidStock =
        _hasInvalidStock(

      cartProvider,

      productProvider,
    );

    return Scaffold(

      backgroundColor:
          const Color(0xffF4F7FC),

      // =====================================
      // APPBAR
      // =====================================

      appBar: AppBar(

        elevation: 0,

        backgroundColor:
            Colors.transparent,

        surfaceTintColor:
            Colors.transparent,

        centerTitle: false,

        titleSpacing: 18,

        title: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: const [

            Text(

              'Shopping Cart',

              style: TextStyle(

                color:
                    Colors.black,

                fontSize: 20,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            SizedBox(
              height: 2,
            ),

            Text(

              'Premium checkout experience',

              style: TextStyle(

                color:
                    Colors.grey,

                fontSize: 12,
              ),
            ),
          ],
        ),
      ),

      // =====================================
      // EMPTY
      // =====================================

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
                            MainAxisAlignment.center,

                        children: [

                          Container(

                            width:
                                isMobile
                                    ? 140
                                    : 180,

                            height:
                                isMobile
                                    ? 140
                                    : 180,

                            decoration:
                                BoxDecoration(

                              shape:
                                  BoxShape.circle,

                              gradient:
                                  LinearGradient(

                                colors: [

                                  AppColors.primary
                                      .withOpacity(0.12),

                                  AppColors.primary
                                      .withOpacity(0.04),
                                ],
                              ),
                            ),

                            child:
                                const Icon(

                              Icons
                                  .shopping_bag_outlined,

                              size: 72,

                              color:
                                  AppColors.primary,
                            ),
                          ),

                          const SizedBox(
                            height: 24,
                          ),

                          const Text(

                            'Your Cart is Empty',

                            textAlign:
                                TextAlign.center,

                            style: TextStyle(

                              fontSize: 24,

                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          Text(

                            'Add products and enjoy premium shopping experience.',

                            textAlign:
                                TextAlign.center,

                            style: TextStyle(

                              color:
                                  Colors.grey.shade600,

                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )

              // =====================================
              // CONTENT
              // =====================================

              : FadeTransition(

                  opacity:
                      _fadeAnimation,

                  child: Stack(

                    children: [

                      Padding(

                        padding:
                            EdgeInsets.only(

                          bottom:
                              isMobile
                                  ? 220
                                  : 240,
                        ),

                        child: SingleChildScrollView(

                          physics:
                              const BouncingScrollPhysics(),

                          padding:
                              EdgeInsets.all(
                            isMobile
                                ? 14
                                : 20,
                          ),

                          child: Column(

                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [

                              // ===============================
                              // WARNING
                              // ===============================

                              if (hasInvalidStock)

                                Container(

                                  width:
                                      double.infinity,

                                  margin:
                                      const EdgeInsets.only(
                                    bottom: 18,
                                  ),

                                  padding:
                                      const EdgeInsets.all(
                                    14,
                                  ),

                                  decoration:
                                      BoxDecoration(

                                    color:
                                        Colors.red
                                            .withOpacity(0.08),

                                    borderRadius:
                                        BorderRadius.circular(
                                      18,
                                    ),
                                  ),

                                  child: const Row(

                                    children: [

                                      Icon(

                                        Icons
                                            .warning_amber_rounded,

                                        color:
                                            Colors.red,

                                        size: 20,
                                      ),

                                      SizedBox(
                                        width: 10,
                                      ),

                                      Expanded(

                                        child: Text(

                                          'Some products exceed available stock.',

                                          style:
                                              TextStyle(

                                            color:
                                                Colors.red,

                                            fontWeight:
                                                FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              // ===============================
                              // ANALYTICS
                              // ===============================

                              SingleChildScrollView(

                                scrollDirection:
                                    Axis.horizontal,

                                child: Row(

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

                                    const SizedBox(
                                      width: 14,
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

                                    const SizedBox(
                                      width: 14,
                                    ),

                                    _buildAnalyticsCard(

                                      title:
                                          'Subtotal',

                                      value:
                                          AppFormat.currency(
                                        cartProvider.totalPrice,
                                      ),

                                      icon:
                                          Icons.payments,

                                      color:
                                          Colors.green,
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(
                                height: 26,
                              ),

                              // ===============================
                              // TITLE
                              // ===============================

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

                                        fontSize: 20,

                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  Text(

                                    '${cartProvider.totalItems} items',

                                    style:
                                        TextStyle(

                                      color:
                                          Colors.grey
                                              .shade600,

                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 18,
                              ),

                              // ===============================
                              // LIST
                              // ===============================

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
                                    height: 14,
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

                                  final product =
                                      productProvider
                                          .getProductById(
                                    item.productId,
                                  );

                                  final isSoldOut =
                                      product ==
                                              null ||

                                          product.stock <=
                                              0;

                                  final exceedStock =
                                      product !=
                                              null &&
                                          item.quantity >
                                              product.stock;

                                  return Column(

                                    children: [

                                      if (isSoldOut ||
                                          exceedStock)

                                        Container(

                                          width:
                                              double.infinity,

                                          margin:
                                              const EdgeInsets.only(
                                            bottom: 8,
                                          ),

                                          padding:
                                              const EdgeInsets.symmetric(

                                            horizontal: 12,

                                            vertical: 10,
                                          ),

                                          decoration:
                                              BoxDecoration(

                                            color:
                                                Colors.red
                                                    .withOpacity(0.08),

                                            borderRadius:
                                                BorderRadius.circular(
                                              14,
                                            ),
                                          ),

                                          child:
                                              Row(

                                            children: [

                                              const Icon(

                                                Icons.warning_rounded,

                                                color:
                                                    Colors.red,

                                                size: 16,
                                              ),

                                              const SizedBox(
                                                width: 8,
                                              ),

                                              Expanded(

                                                child: Text(

                                                  isSoldOut

                                                      ? '${item.productName} sold out'

                                                      : 'Available stock only ${product.stock}',

                                                  style:
                                                      const TextStyle(

                                                    color:
                                                        Colors.red,

                                                    fontSize: 12,

                                                    fontWeight:
                                                        FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                      CartItemCard(
                                        item: item,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      // =====================================
                      // FLOATING SUMMARY
                      // =====================================

                      Positioned(

                        left: 14,

                        right: 14,

                        bottom: 14,

                        child: Center(

                          child: Container(

                            constraints:
                                const BoxConstraints(
                              maxWidth: 540,
                            ),

                            padding:
                                EdgeInsets.all(
                              isMobile
                                  ? 18
                                  : 22,
                            ),

                            decoration:
                                BoxDecoration(

                              color:
                                  Colors.white,

                              borderRadius:
                                  BorderRadius.circular(
                                26,
                              ),

                              boxShadow: [

                                BoxShadow(

                                  color:
                                      Colors.black
                                          .withOpacity(0.06),

                                  blurRadius: 24,

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

                                _buildPriceRow(

                                  title:
                                      'Subtotal',

                                  value:
                                      AppFormat.currency(
                                    cartProvider.totalPrice,
                                  ),
                                ),

                                const SizedBox(
                                  height: 12,
                                ),

                                _buildPriceRow(

                                  title:
                                      'Shipping',

                                  value:
                                      'Free',
                                ),

                                const Padding(

                                  padding:
                                      EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),

                                  child: Divider(),
                                ),

                                Row(

                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,

                                  children: [

                                    const Text(

                                      'Grand Total',

                                      style:
                                          TextStyle(

                                        fontSize: 18,

                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),

                                    Flexible(

                                      child: Text(

                                        AppFormat.currency(
                                          cartProvider.totalPrice,
                                        ),

                                        overflow:
                                            TextOverflow
                                                .ellipsis,

                                        textAlign:
                                            TextAlign.right,

                                        style:
                                            const TextStyle(

                                          fontSize: 22,

                                          color:
                                              AppColors.primary,

                                          fontWeight:
                                              FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(
                                  height: 20,
                                ),

                                SizedBox(

                                  width:
                                      double.infinity,

                                  height:
                                      isMobile
                                          ? 50
                                          : 56,

                                  child:
                                      ElevatedButton(

                                    style:
                                        ElevatedButton.styleFrom(

                                      elevation: 0,

                                      backgroundColor:
                                          hasInvalidStock

                                              ? Colors.grey

                                              : AppColors.primary,

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
                                        hasInvalidStock

                                            ? null

                                            : () {

                                                Navigator.pushNamed(

                                                  context,

                                                  AppRoutes.checkout,
                                                );
                                              },

                                    child: Row(

                                      mainAxisAlignment:
                                          MainAxisAlignment.center,

                                      children: [

                                        const Icon(
                                          Icons.shopping_bag,
                                          size: 18,
                                        ),

                                        const SizedBox(
                                          width: 8,
                                        ),

                                        Text(

                                          hasInvalidStock

                                              ? 'Stock Not Available'

                                              : 'Proceed Checkout',

                                          style:
                                              const TextStyle(

                                            fontSize: 15,

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
                      ),
                    ],
                  ),
                ),
    );
  }

  // =========================================
  // PRICE ROW
  // =========================================

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

            fontSize: 14,
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

              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }

  // =========================================
  // ANALYTICS CARD
  // =========================================

  Widget _buildAnalyticsCard({

    required String title,

    required String value,

    required IconData icon,

    required Color color,
  }) {

    return Container(

      width: 155,

      padding:
          const EdgeInsets.all(
        16,
      ),

      decoration:
          BoxDecoration(

        color:
            Colors.white,

        borderRadius:
            BorderRadius.circular(
          22,
        ),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black
                    .withOpacity(0.04),

            blurRadius: 14,

            offset:
                const Offset(
              0,
              6,
            ),
          ),
        ],
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Container(

            padding:
                const EdgeInsets.all(
              10,
            ),

            decoration:
                BoxDecoration(

              color:
                  color.withOpacity(
                0.10,
              ),

              borderRadius:
                  BorderRadius.circular(
                14,
              ),
            ),

            child: Icon(

              icon,

              color:
                  color,

              size: 18,
            ),
          ),

          const SizedBox(
            height: 14,
          ),

          Text(

            value,

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
            height: 4,
          ),

          Text(

            title,

            overflow:
                TextOverflow
                    .ellipsis,

            style: TextStyle(

              color:
                  Colors.grey
                      .shade600,

              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}