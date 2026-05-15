// =====================================================
// lib/screens/user/cart_screen.dart
// ULTRA CLEAN COMPACT PREMIUM VERSION
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
        milliseconds: 350,
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
  // VALIDATION
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

    final width =
        MediaQuery.of(context)
            .size
            .width;

    final isMobile =
        width < 700;

    final hasInvalidStock =
        _hasInvalidStock(

      cartProvider,

      productProvider,
    );

    return Scaffold(

      backgroundColor:
          const Color(
        0xffF5F7FB,
      ),

      // =====================================
      // APPBAR
      // =====================================

      appBar: AppBar(

        elevation: 0,

        backgroundColor:
            Colors.transparent,

        surfaceTintColor:
            Colors.transparent,

        leading: IconButton(

          onPressed: () {

            Navigator.pop(
              context,
            );
          },

          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
          ),
        ),

        titleSpacing: 0,

        title: Column(

          crossAxisAlignment:
              CrossAxisAlignment
                  .start,

          children: const [

            Text(

              'Shopping Cart',

              style: TextStyle(

                fontSize: 22,

                fontWeight:
                    FontWeight.bold,

                color:
                    Colors.black,
              ),
            ),

            SizedBox(
              height: 2,
            ),

            Text(

              'Premium checkout experience',

              style: TextStyle(

                fontSize: 12,

                color:
                    Colors.grey,
              ),
            ),
          ],
        ),

        actions: [

          if (!cartProvider
              .isEmpty)

            Padding(

              padding:
                  const EdgeInsets.only(
                right: 16,
              ),

              child: TextButton(

                onPressed: () {

                  Navigator.pop(
                    context,
                  );
                },

                style:
                    TextButton.styleFrom(

                  padding:
                      const EdgeInsets.symmetric(

                    horizontal: 18,

                    vertical: 10,
                  ),

                  backgroundColor:
                      Colors.white,
                ),

                child: const Text(

                  'Continue Shopping',

                  style: TextStyle(

                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
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

                    child: Column(

                      mainAxisAlignment:
                          MainAxisAlignment
                              .center,

                      children: [

                        Container(

                          width: 120,

                          height: 120,

                          decoration:
                              BoxDecoration(

                            shape:
                                BoxShape.circle,

                            color:
                                AppColors
                                    .primary
                                    .withOpacity(
                              0.08,
                            ),
                          ),

                          child:
                              const Icon(

                            Icons
                                .shopping_cart_outlined,

                            size: 52,

                            color:
                                AppColors
                                    .primary,
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        const Text(

                          'Your Cart is Empty',

                          style:
                              TextStyle(

                            fontSize: 24,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        Text(

                          'Add products to continue shopping.',

                          style:
                              TextStyle(

                            color:
                                Colors.grey
                                    .shade600,
                          ),
                        ),
                      ],
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
                                  ? 180
                                  : 200,
                        ),

                        child:
                            SingleChildScrollView(

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
                                CrossAxisAlignment
                                    .start,

                            children: [

                              // =========================
                              // WARNING
                              // =========================

                              if (hasInvalidStock)

                                Container(

                                  width:
                                      double.infinity,

                                  margin:
                                      const EdgeInsets.only(
                                    bottom: 16,
                                  ),

                                  padding:
                                      const EdgeInsets.symmetric(

                                    horizontal: 14,

                                    vertical: 12,
                                  ),

                                  decoration:
                                      BoxDecoration(

                                    color:
                                        Colors.red
                                            .withOpacity(
                                      0.08,
                                    ),

                                    borderRadius:
                                        BorderRadius.circular(
                                      16,
                                    ),
                                  ),

                                  child: const Row(

                                    children: [

                                      Icon(

                                        Icons.warning_amber_rounded,

                                        color:
                                            Colors.red,

                                        size: 18,
                                      ),

                                      SizedBox(
                                        width: 10,
                                      ),

                                      Expanded(

                                        child: Text(

                                          'Some products exceed stock.',

                                          style:
                                              TextStyle(

                                            color:
                                                Colors.red,

                                            fontWeight:
                                                FontWeight.w600,

                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              // =========================
                              // ANALYTICS
                              // =========================

                              Wrap(

                                spacing: 12,

                                runSpacing: 12,

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
                                      cartProvider.totalPrice,
                                    ),

                                    icon:
                                        Icons.payments,

                                    color:
                                        Colors.green,
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 24,
                              ),

                              // =========================
                              // TITLE
                              // =========================

                              Row(

                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,

                                children: [

                                  const Text(

                                    'Cart Items',

                                    style:
                                        TextStyle(

                                      fontSize: 24,

                                      fontWeight:
                                          FontWeight.bold,
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

                              // =========================
                              // ITEMS
                              // =========================

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
                                    height: 12,
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

                                  return CartItemCard(
                                    item: item,
                                  );
                                },
                              ),

                              const SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // =====================================
                      // BOTTOM CHECKOUT
                      // =====================================

                      Positioned(

                        left: 14,

                        right: 14,

                        bottom: 14,

                        child: Center(

                          child: Container(

                            constraints:
                                const BoxConstraints(
                              maxWidth: 620,
                            ),

                            padding:
                                EdgeInsets.all(
                              isMobile
                                  ? 18
                                  : 20,
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

                                  blurRadius: 18,

                                  offset:
                                      const Offset(
                                    0,
                                    8,
                                  ),
                                ),
                              ],
                            ),

                            child:
                                isMobile

                                    ? Column(

                                        children: [

                                          buildSummary(
                                            cartProvider,
                                          ),

                                          const SizedBox(
                                            height:
                                                18,
                                          ),

                                          buildCheckoutButton(
                                            hasInvalidStock,
                                          ),
                                        ],
                                      )

                                    : Row(

                                        children: [

                                          Expanded(

                                            child:
                                                buildSummary(
                                              cartProvider,
                                            ),
                                          ),

                                          const SizedBox(
                                            width:
                                                24,
                                          ),

                                          SizedBox(

                                            width:
                                                250,

                                            child:
                                                buildCheckoutButton(
                                              hasInvalidStock,
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
  // SUMMARY
  // =========================================

  Widget buildSummary(
    CartProvider cartProvider,
  ) {

    return Column(

      crossAxisAlignment:
          CrossAxisAlignment
              .start,

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
          height: 10,
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
            vertical: 14,
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

                fontSize: 20,

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

                style:
                    const TextStyle(

                  fontSize: 28,

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
      ],
    );
  }

  // =========================================
  // CHECKOUT BUTTON
  // =========================================

  Widget buildCheckoutButton(
    bool hasInvalidStock,
  ) {

    return SizedBox(

      width: double.infinity,

      height: 54,

      child: ElevatedButton(

        style:
            ElevatedButton.styleFrom(

          elevation: 0,

          backgroundColor:

              hasInvalidStock

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
            hasInvalidStock

                ? null

                : () {

                    Navigator.pushNamed(
                      context,
                      AppRoutes
                          .checkout,
                    );
                  },

        child: Row(

          mainAxisAlignment:
              MainAxisAlignment
                  .center,

          children: [

            const Icon(
              Icons.lock,
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

          style:
              TextStyle(

            color:
                Colors.grey
                    .shade700,

            fontSize: 14,
          ),
        ),

        Text(

          value,

          style:
              const TextStyle(

            fontWeight:
                FontWeight.bold,

            fontSize: 15,
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

      width: 145,

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
          20,
        ),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black
                    .withOpacity(
              0.04,
            ),

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
            CrossAxisAlignment
                .start,

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
    );
  }
}