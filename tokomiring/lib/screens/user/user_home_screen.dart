// lib/screens/user/user_home_screen.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_format.dart';

import '../../providers/cart_provider.dart';
import '../../providers/product_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/order_provider.dart';

import '../../widgets/cards/product_card.dart';
import '../../widgets/user/user_sidebar.dart';
import '../../routes/app_routes.dart';

import 'cart_screen.dart';

class UserHomeScreen
    extends StatefulWidget {

  const UserHomeScreen({
    super.key,
  });

  @override
  State<UserHomeScreen>
      createState() =>
          _UserHomeScreenState();
}

class _UserHomeScreenState
    extends State<UserHomeScreen>
    with
        TickerProviderStateMixin {

  late AnimationController
      _fadeController;

  int _selectedIndex = 0;

  late Animation<double>
      _fadeAnimation;

  // =====================================================
  // INIT
  // =====================================================

  @override
  void initState() {

    super.initState();

    _fadeController =
        AnimationController(

      vsync: this,

      duration:
          const Duration(
        milliseconds: 700,
      ),
    );

    _fadeAnimation =
        CurvedAnimation(

      parent:
          _fadeController,

      curve:
          Curves.easeOut,
    );

    _fadeController.forward();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {

      context
          .read<ProductProvider>()
          .initializeProducts();

      context
          .read<OrderProvider>()
          .initializeOrders();
    });
  }

  // =====================================================
  // DISPOSE
  // =====================================================

  @override
  void dispose() {

    _fadeController.dispose();

    super.dispose();
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(
    BuildContext context,
  ) {

    final productProvider =
        context.watch<
            ProductProvider>();

    final cartProvider =
        context.watch<
            CartProvider>();

    final authProvider =
        context.watch<
            AuthProvider>();

    final orderProvider =
        context.watch<
            OrderProvider>();

    final screenWidth =
        MediaQuery.of(context)
            .size
            .width;

    // ===================================================
    // RESPONSIVE GRID
    // ===================================================

    int crossAxisCount = 2;

    double childAspectRatio =
        0.72;

    if (screenWidth >= 1400) {

      crossAxisCount = 5;

      childAspectRatio =
          0.78;
    }

    else if (screenWidth >= 1100) {

      crossAxisCount = 4;

      childAspectRatio =
          0.75;
    }

    else if (screenWidth >= 800) {

      crossAxisCount = 3;

      childAspectRatio =
          0.73;
    }

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

        automaticallyImplyLeading:
            false,

        titleSpacing: 20,

        title: Row(

          children: [

            // =============================================
            // AVATAR
            // =============================================

            Container(

              width: 52,

              height: 52,

              decoration:
                  BoxDecoration(

                borderRadius:
                    BorderRadius.circular(
                  18,
                ),

                gradient:
                    const LinearGradient(

                  colors: [

                    Color(
                      0xff2563EB,
                    ),

                    Color(
                      0xff1D4ED8,
                    ),
                  ],
                ),
              ),

              child:
                  authProvider
                          .photoUrl
                          .isNotEmpty

                      ? ClipRRect(

                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),

                          child:
                              Image.memory(

                            base64Decode(
                              authProvider
                                  .photoUrl,
                            ),

                            fit: BoxFit.cover,
                          ),
                        )

                      : const Icon(

                          Icons.person,

                          color:
                              Colors.white,

                          size: 28,
                        ),
            ),

            const SizedBox(
              width: 14,
            ),

            // =============================================
            // USER INFO
            // =============================================

            Expanded(

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  Text(

                    'Welcome Back 👋',

                    overflow:
                        TextOverflow
                            .ellipsis,

                    style: TextStyle(

                      color:
                          Colors
                              .grey
                              .shade600,

                      fontSize:
                          13,
                    ),
                  ),

                  const SizedBox(
                    height: 2,
                  ),

                  Text(

                    authProvider
                            .user
                            ?.displayName ??

                        'Member',

                    overflow:
                        TextOverflow
                            .ellipsis,

                    style:
                        const TextStyle(

                      color:
                          Colors.black,

                      fontSize:
                          20,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        actions: [

          // =============================================
          // NOTIFICATION
          // =============================================

          Container(

            margin:
                const EdgeInsets.only(
              right: 20,
            ),

            decoration:
                BoxDecoration(

              color:
                  Colors.white,

              borderRadius:
                  BorderRadius.circular(
                18,
              ),
            ),

            child: IconButton(

              onPressed: () {},

              icon: const Icon(
                Icons.notifications_none,
              ),
            ),
          ),
        ],
      ),

      // ===================================================
      // FLOATING CART
      // ===================================================

      floatingActionButtonLocation:
          FloatingActionButtonLocation
              .centerFloat,

      floatingActionButton:

          cartProvider.isEmpty

              ? null

              : GestureDetector(

                  onTap: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (_) =>
                            const CartScreen(),
                      ),
                    );
                  },

                  child:
                      AnimatedContainer(

                    duration:
                        const Duration(
                      milliseconds:
                          250,
                    ),

                    width:
                        screenWidth <
                                600

                            ? screenWidth -
                                40

                            : 430,

                    padding:
                        const EdgeInsets.symmetric(

                      horizontal:
                          22,

                      vertical:
                          18,
                    ),

                    decoration:
                        BoxDecoration(

                      borderRadius:
                          BorderRadius.circular(
                        28,
                      ),

                      gradient:
                          const LinearGradient(

                        colors: [

                          Color(
                            0xff2563EB,
                          ),

                          Color(
                            0xff1D4ED8,
                          ),
                        ],
                      ),

                      boxShadow: [

                        BoxShadow(

                          color:
                              Colors.blue
                                  .withOpacity(
                            0.25,
                          ),

                          blurRadius:
                              25,

                          offset:
                              const Offset(
                            0,
                            12,
                          ),
                        ),
                      ],
                    ),

                    child: Row(

                      children: [

                        Container(

                          padding:
                              const EdgeInsets.all(
                            12,
                          ),

                          decoration:
                              BoxDecoration(

                            color:
                                Colors.white
                                    .withOpacity(
                              0.15,
                            ),

                            shape:
                                BoxShape.circle,
                          ),

                          child: Stack(

                            clipBehavior:
                                Clip.none,

                            children: [

                              const Icon(

                                Icons
                                    .shopping_cart,

                                color:
                                    Colors
                                        .white,
                              ),

                              Positioned(

                                right: -5,

                                top: -5,

                                child:
                                    Container(

                                  padding:
                                      const EdgeInsets.all(
                                    5,
                                  ),

                                  decoration:
                                      const BoxDecoration(

                                    color:
                                        Colors.red,

                                    shape:
                                        BoxShape.circle,
                                  ),

                                  child: Text(

                                    '${cartProvider.totalItems}',

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

                        const SizedBox(
                          width: 14,
                        ),

                        Expanded(

                          child: Column(

                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [

                              const Text(

                                'View Cart',

                                overflow:
                                    TextOverflow
                                        .ellipsis,

                                style:
                                    TextStyle(

                                  color:
                                      Colors
                                          .white,

                                  fontWeight:
                                      FontWeight.bold,

                                  fontSize:
                                      16,
                                ),
                              ),

                              const SizedBox(
                                height: 3,
                              ),

                              Text(

                                '${cartProvider.totalItems} items added',

                                overflow:
                                    TextOverflow
                                        .ellipsis,

                                style:
                                    TextStyle(

                                  color:
                                      Colors
                                          .white
                                          .withOpacity(
                                    0.9,
                                  ),

                                  fontSize:
                                      13,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Text(

                          AppFormat.currency(
                            cartProvider
                                .totalPrice,
                          ),

                          overflow:
                              TextOverflow
                                  .ellipsis,

                          style:
                              const TextStyle(

                            color:
                                Colors.white,

                            fontWeight:
                                FontWeight.bold,

                            fontSize:
                                18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

      // ===================================================
      // BODY
      // ===================================================

      body: Row(
        children: [
          UserSidebar(
            selectedIndex: _selectedIndex,
            onSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });

              if (index == 0) {
                // Dashboard
              } else if (index == 1) {
                // Marketplace - stay on dashboard
              } else if (index == 2) {
                Navigator.pushNamed(
                  context,
                  AppRoutes.cart,
                );
              } else if (index == 3) {
                Navigator.pushNamed(
                  context,
                  AppRoutes.userOrders,
                );
              } else if (index == 6) {
                Navigator.pushNamed(
                  context,
                  AppRoutes.userProfile,
                );
              }
            },
          ),
          Expanded(
            child: FadeTransition(

              opacity:
                  _fadeAnimation,

              child: SafeArea(

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

                // =========================================
                // PROMO BANNER
                // =========================================

                Container(

                  width:
                      double.infinity,

                  padding:
                      const EdgeInsets.all(
                    24,
                  ),

                  decoration:
                      BoxDecoration(

                    borderRadius:
                        BorderRadius.circular(
                      30,
                    ),

                    gradient:
                        const LinearGradient(

                      begin:
                          Alignment
                              .topLeft,

                      end:
                          Alignment
                              .bottomRight,

                      colors: [

                        Color(
                          0xff2563EB,
                        ),

                        Color(
                          0xff1E40AF,
                        ),
                      ],
                    ),
                  ),

                  child: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [

                      Container(

                        padding:
                            const EdgeInsets.symmetric(

                          horizontal:
                              14,

                          vertical: 8,
                        ),

                        decoration:
                            BoxDecoration(

                          color:
                              Colors.white
                                  .withOpacity(
                            0.15,
                          ),

                          borderRadius:
                              BorderRadius.circular(
                            30,
                          ),
                        ),

                        child: const Text(

                          'PREMIUM MEMBER',

                          style: TextStyle(

                            color:
                                Colors.white,

                            fontWeight:
                                FontWeight.bold,

                            fontSize: 12,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      const Text(

                        'Discover Amazing Products',

                        style: TextStyle(

                          color:
                              Colors.white,

                          fontSize: 28,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Text(

                        'Realtime ecommerce dashboard with premium shopping experience.',

                        style: TextStyle(

                          color:
                              Colors.white
                                  .withOpacity(
                            0.9,
                          ),

                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 24,
                ),


                // =========================================
                // SEARCH
                // =========================================

                Container(

                  decoration:
                      BoxDecoration(

                    color:
                        Colors.white,

                    borderRadius:
                        BorderRadius.circular(
                      22,
                    ),
                  ),

                  child: TextField(

                    onChanged:
                        productProvider
                            .searchProducts,

                    decoration:
                        InputDecoration(

                      hintText:
                          'Search products...',

                      prefixIcon:
                          const Icon(
                        Icons.search,
                      ),

                      border:
                          InputBorder.none,

                      contentPadding:
                          const EdgeInsets.symmetric(
                        horizontal:
                            18,

                        vertical:
                            18,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                // =========================================
                // CATEGORY
                // =========================================

                SizedBox(

                  height: 50,

                  child: ListView.builder(

                    scrollDirection:
                        Axis.horizontal,

                    itemCount:
                        productProvider
                            .categories
                            .length,

                    itemBuilder:
                        (
                          context,
                          index,
                        ) {

                      final category =
                          productProvider
                                  .categories[
                              index];

                      final selected =
                          productProvider
                                  .selectedCategory ==

                              category;

                      return Padding(

                        padding:
                            const EdgeInsets.only(
                          right: 12,
                        ),

                        child: ChoiceChip(

                          label:
                              Text(
                            category,
                          ),

                          selected:
                              selected,

                          showCheckmark:
                              false,

                          selectedColor:
                              AppColors.primary,

                          backgroundColor:
                              Colors.white,

                          labelStyle:
                              TextStyle(

                            color:
                                selected

                                    ? Colors.white

                                    : Colors.black,

                            fontWeight:
                                FontWeight.w600,
                          ),

                          shape:
                              RoundedRectangleBorder(

                            borderRadius:
                                BorderRadius.circular(
                              18,
                            ),
                          ),

                          onSelected: (_) {

                            productProvider
                                .selectCategory(
                              category,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(
                  height: 28,
                ),

                // =========================================
                // TITLE
                // =========================================

                Row(

                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,

                  children: [

                    const Expanded(

                      child: Text(

                        'Latest Products',

                        overflow:
                            TextOverflow
                                .ellipsis,

                        style: TextStyle(

                          fontSize: 24,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),

                    Text(

                      '${productProvider.products.length} Items',

                      style: TextStyle(

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

                // =========================================
                // PRODUCTS
                // =========================================

                productProvider
                        .isLoading

                    ? const Padding(

                        padding:
                            EdgeInsets.all(
                          50,
                        ),

                        child: Center(

                          child:
                              CircularProgressIndicator(),
                        ),
                      )

                    : productProvider
                            .products
                            .isEmpty

                        ? Padding(

                            padding:
                                const EdgeInsets.symmetric(
                              vertical:
                                  80,
                            ),

                            child: Center(

                              child: Column(

                                children: [

                                  Icon(

                                    Icons
                                        .inventory_2_outlined,

                                    size:
                                        90,

                                    color:
                                        Colors
                                            .grey
                                            .shade400,
                                  ),

                                  const SizedBox(
                                    height:
                                        18,
                                  ),

                                  const Text(

                                    'No Products Found',

                                    style:
                                        TextStyle(

                                      fontSize:
                                          24,

                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )

                        : GridView.builder(

                            shrinkWrap:
                                true,

                            physics:
                                const NeverScrollableScrollPhysics(),

                            itemCount:
                                productProvider
                                    .products
                                    .length,

                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(

                              crossAxisCount:
                                  crossAxisCount,

                              crossAxisSpacing:
                                  18,

                              mainAxisSpacing:
                                  18,

                              childAspectRatio:
                                  childAspectRatio,
                            ),

                            itemBuilder:
                                (
                                  context,
                                  index,
                                ) {

                              final product =
                                  productProvider
                                          .products[
                                      index];

                              return ProductCard(
                                product:
                                    product,
                              );
                            },
                          ),

                const SizedBox(
                  height: 120,
                ),
              ],
            ),
          ),
        ),
      ),
          ),
        ],
      ),
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

      width: 180,

      padding:
          const EdgeInsets.all(
        20,
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

              fontSize: 28,

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