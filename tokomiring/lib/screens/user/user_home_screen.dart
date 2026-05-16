// =====================================================
// lib/screens/user/user_home_screen.dart
// FINAL COMPACT PREMIUM VERSION
// =====================================================

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_format.dart';

import '../../providers/auth_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/order_provider.dart';
import '../../providers/product_provider.dart';

import '../../routes/app_routes.dart';

import '../../widgets/cards/dashboard_card.dart';
import '../../widgets/cards/product_grid.dart';

import '../../widgets/user/user_sidebar.dart';

import 'cart_screen.dart';

class UserHomeScreen extends StatefulWidget {

  const UserHomeScreen({
    super.key,
  });

  @override
  State<UserHomeScreen> createState() =>
      _UserHomeScreenState();
}

class _UserHomeScreenState
    extends State<UserHomeScreen>
    with TickerProviderStateMixin {

  late AnimationController
      _fadeController;

  late Animation<double>
      _fadeAnimation;

  int _selectedIndex = 0;

  @override
  void initState() {

    super.initState();

    _fadeController =
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

  @override
  void dispose() {

    _fadeController.dispose();

    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    final productProvider =
        context.watch<ProductProvider>();

    final cartProvider =
        context.watch<CartProvider>();

    final authProvider =
        context.watch<AuthProvider>();

    final orderProvider =
        context.watch<OrderProvider>();

    final width =
        MediaQuery.of(context)
            .size
            .width;

    final isMobile =
        width < 700;

    final isTablet =
        width >= 700 &&
            width < 1200;

    final displayProducts =
        productProvider.searchQuery.isEmpty &&
                productProvider
                        .selectedCategory ==
                    'All'
            ? (productProvider
                    .popularProducts
                    .isNotEmpty
                ? productProvider
                    .popularProducts
                : productProvider
                    .products)
            : productProvider.products;

    return Scaffold(

      backgroundColor:
          const Color(
        0xffF4F7FC,
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation
              .centerFloat,

      // =================================================
      // PREMIUM MINI CART
      // =================================================

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

                  child: Container(

                    width:

                        isMobile
                            ? width * 0.90
                            : 340,

                    padding:
                        const EdgeInsets.all(
                      12,
                    ),

                    decoration:
                        BoxDecoration(

                      gradient:
                          const LinearGradient(

                        begin:
                            Alignment.topLeft,

                        end:
                            Alignment.bottomRight,

                        colors: [

                          Color(
                            0xff2563EB,
                          ),

                          Color(
                            0xff1D4ED8,
                          ),
                        ],
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        22,
                      ),

                      boxShadow: [

                        BoxShadow(

                          color:
                              Colors.blue
                                  .withOpacity(
                            0.18,
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

                    child: Row(

                      children: [

                        // =====================
                        // IMAGE
                        // =====================

                        Stack(

                          children: [

                            Container(

                              width: 54,

                              height: 54,

                              decoration:
                                  BoxDecoration(

                                color:
                                    Colors.white
                                        .withOpacity(
                                  0.12,
                                ),

                                borderRadius:
                                    BorderRadius.circular(
                                  16,
                                ),
                              ),

                              child:
                                  ClipRRect(

                                borderRadius:
                                    BorderRadius.circular(
                                  16,
                                ),

                                child:

                                    cartProvider
                                            .items
                                            .isNotEmpty

                                        ? Image.memory(

                                            base64Decode(

                                              cartProvider
                                                  .items
                                                  .last
                                                  .productImage,
                                            ),

                                            fit:
                                                BoxFit.cover,
                                          )

                                        : const Icon(

                                            Icons
                                                .shopping_bag_rounded,

                                            color:
                                                Colors
                                                    .white,
                                          ),
                              ),
                            ),

                            Positioned(

                              top: -2,

                              right: -2,

                              child:
                                  Container(

                                padding:
                                    const EdgeInsets.symmetric(

                                  horizontal:
                                      6,

                                  vertical:
                                      3,
                                ),

                                decoration:
                                    BoxDecoration(

                                  color:
                                      Colors.red,

                                  borderRadius:
                                      BorderRadius.circular(
                                    30,
                                  ),

                                  border:
                                      Border.all(

                                    color:
                                        Colors
                                            .white,

                                    width:
                                        1.5,
                                  ),
                                ),

                                child: Text(

                                  cartProvider
                                      .totalItems
                                      .toString(),

                                  style:
                                      const TextStyle(

                                    color:
                                        Colors
                                            .white,

                                    fontSize:
                                        9,

                                    fontWeight:
                                        FontWeight
                                            .bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          width: 12,
                        ),

                        // =====================
                        // CONTENT
                        // =====================

                        Expanded(

                          child: Column(

                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            mainAxisSize:
                                MainAxisSize
                                    .min,

                            children: [

                              const Text(

                                'View Cart',

                                overflow:
                                    TextOverflow
                                        .ellipsis,

                                style:
                                    TextStyle(

                                  color:
                                      Colors.white,

                                  fontWeight:
                                      FontWeight.bold,

                                  fontSize:
                                      13,
                                ),
                              ),

                              const SizedBox(
                                height: 2,
                              ),

                              Text(

                                cartProvider
                                    .items
                                    .last
                                    .productName,

                                maxLines: 1,

                                overflow:
                                    TextOverflow
                                        .ellipsis,

                                style:
                                    TextStyle(

                                  color:
                                      Colors.white
                                          .withOpacity(
                                    0.84,
                                  ),

                                  fontSize:
                                      10,
                                ),
                              ),

                              const SizedBox(
                                height: 6,
                              ),

                              Row(

                                children: [

                                  Container(

                                    padding:
                                        const EdgeInsets.symmetric(

                                      horizontal:
                                          8,

                                      vertical:
                                          4,
                                    ),

                                    decoration:
                                        BoxDecoration(

                                      color:
                                          Colors.white
                                              .withOpacity(
                                        0.12,
                                      ),

                                      borderRadius:
                                          BorderRadius.circular(
                                        20,
                                      ),
                                    ),

                                    child: Text(

                                      '${cartProvider.totalItems} Items',

                                      style:
                                          const TextStyle(

                                        color:
                                            Colors
                                                .white,

                                        fontWeight:
                                            FontWeight
                                                .w600,

                                        fontSize:
                                            8,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                    width: 6,
                                  ),

                                  Container(

                                    padding:
                                        const EdgeInsets.symmetric(

                                      horizontal:
                                          8,

                                      vertical:
                                          4,
                                    ),

                                    decoration:
                                        BoxDecoration(

                                      color:
                                          Colors.white
                                              .withOpacity(
                                        0.12,
                                      ),

                                      borderRadius:
                                          BorderRadius.circular(
                                        20,
                                      ),
                                    ),

                                    child:
                                        const Text(

                                      'Checkout',

                                      style:
                                          TextStyle(

                                        color:
                                            Colors
                                                .white,

                                        fontWeight:
                                            FontWeight
                                                .w600,

                                        fontSize:
                                            8,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          width: 10,
                        ),

                        // =====================
                        // PRICE
                        // =====================

                        Column(

                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .end,

                          children: [

                            Text(

                              AppFormat.currency(
                                cartProvider
                                    .totalPrice,
                              ),

                              style:
                                  const TextStyle(

                                color:
                                    Colors.white,

                                fontWeight:
                                    FontWeight.bold,

                                fontSize:
                                    14,
                              ),
                            ),

                            const SizedBox(
                              height: 4,
                            ),

                            Container(

                              width: 30,

                              height: 30,

                              decoration:
                                  BoxDecoration(

                                color:
                                    Colors.white
                                        .withOpacity(
                                  0.14,
                                ),

                                shape:
                                    BoxShape.circle,
                              ),

                              child:
                                  const Icon(

                                Icons
                                    .arrow_forward_rounded,

                                color:
                                    Colors.white,

                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

      body: Row(

        children: [

          if (!isMobile)

            UserSidebar(

              selectedIndex:
                  _selectedIndex,

              onSelected: (
                index,
              ) {

                setState(() {

                  _selectedIndex =
                      index;
                });

                switch (index) {

                  case 2:

                    Navigator.pushNamed(
                      context,
                      AppRoutes.cart,
                    );

                    break;

                  case 3:

                    Navigator.pushNamed(
                      context,
                      AppRoutes.userOrders,
                    );

                    break;

                  case 4:

                    Navigator.pushNamed(
                      context,
                      AppRoutes.userWishlist,
                    );

                    break;

                  case 5:

                    Navigator.pushNamed(
                      context,
                      AppRoutes.userNotifications,
                    );

                    break;

                  case 6:

                    Navigator.pushNamed(
                      context,
                      AppRoutes.userProfile,
                    );

                    break;
                }
              },
            ),

          Expanded(

            child: FadeTransition(

              opacity:
                  _fadeAnimation,

              child: SafeArea(

                child:
                    SingleChildScrollView(

                  physics:
                      const BouncingScrollPhysics(),

                  padding:
                      EdgeInsets.all(

                    isMobile
                        ? 12
                        : 18,
                  ),

                  child: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [

                      // HEADER

                      Container(

                        padding:
                            const EdgeInsets.symmetric(

                          horizontal:
                              18,

                          vertical:
                              14,
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
                                0.03,
                              ),

                              blurRadius:
                                  12,

                              offset:
                                  const Offset(
                                0,
                                5,
                              ),
                            ),
                          ],
                        ),

                        child: Row(

                          children: [

                            Expanded(

                              child: Column(

                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                children: [

                                  Text(

                                    'Welcome Back 👋',

                                    style:
                                        TextStyle(

                                      color:
                                          Colors.grey
                                              .shade600,

                                      fontSize:
                                          10,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 2,
                                  ),

                                  Text(

                                    authProvider
                                            .user
                                            ?.displayName ??
                                        'User',

                                    overflow:
                                        TextOverflow
                                            .ellipsis,

                                    style:
                                        TextStyle(

                                      fontSize:

                                          isMobile
                                              ? 20
                                              : 23,

                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Container(

                              padding:
                                  const EdgeInsets.all(
                                9,
                              ),

                              decoration:
                                  BoxDecoration(

                                color:
                                    Colors.grey
                                        .shade100,

                                borderRadius:
                                    BorderRadius.circular(
                                  13,
                                ),
                              ),

                              child: const Icon(

                                Icons
                                    .notifications_none_rounded,

                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      // HERO

                      Container(

                        width:
                            double.infinity,

                        padding:
                            const EdgeInsets.all(
                          22,
                        ),

                        decoration:
                            BoxDecoration(

                          borderRadius:
                              BorderRadius.circular(
                            26,
                          ),

                          gradient:
                              const LinearGradient(

                            begin:
                                Alignment.topLeft,

                            end:
                                Alignment.bottomRight,

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
                                    10,

                                vertical:
                                    5,
                              ),

                              decoration:
                                  BoxDecoration(

                                color:
                                    Colors.white
                                        .withOpacity(
                                  0.12,
                                ),

                                borderRadius:
                                    BorderRadius.circular(
                                  20,
                                ),
                              ),

                              child:
                                  const Text(

                                'PREMIUM DASHBOARD',

                                style:
                                    TextStyle(

                                  color:
                                      Colors.white,

                                  fontWeight:
                                      FontWeight.bold,

                                  fontSize:
                                      9,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 14,
                            ),

                            Text(

                              'Modern Ecommerce Experience',

                              style:
                                  TextStyle(

                                color:
                                    Colors.white,

                                fontWeight:
                                    FontWeight.bold,

                                fontSize:

                                    isMobile
                                        ? 22
                                        : 28,
                              ),
                            ),

                            const SizedBox(
                              height: 6,
                            ),

                            Text(

                              'Responsive marketplace with compact premium interface.',

                              style:
                                  TextStyle(

                                color:
                                    Colors.white
                                        .withOpacity(
                                  0.84,
                                ),

                                fontSize:
                                    11,

                                height:
                                    1.4,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      // DASHBOARD

                      GridView.count(

                        shrinkWrap: true,

                        physics:
                            const NeverScrollableScrollPhysics(),

                        crossAxisCount:

                            isMobile

                                ? 2

                                : isTablet

                                    ? 2

                                    : 4,

                        crossAxisSpacing:
                            12,

                        mainAxisSpacing:
                            12,

                        childAspectRatio:

                            isMobile
                                ? 1.42
                                : 1.70,

                        children: [

                          DashboardCard(
                            title:
                                'Products',
                            value:
                                '${productProvider.products.length}',
                            icon:
                                Icons.inventory_2_rounded,
                            color:
                                Colors.blue,
                            subtitle:
                                'Available products',
                          ),

                          DashboardCard(
                            title:
                                'Orders',
                            value:
                                '${orderProvider.orders.length}',
                            icon:
                                Icons.receipt_long_rounded,
                            color:
                                Colors.orange,
                            subtitle:
                                'Total orders',
                          ),

                          DashboardCard(
                            title:
                                'Cart',
                            value:
                                '${cartProvider.totalItems}',
                            icon:
                                Icons.shopping_cart_rounded,
                            color:
                                Colors.green,
                            subtitle:
                                'Items in cart',
                          ),

                          DashboardCard(
                            title:
                                'Favorites',
                            value:
                                '${productProvider.favorites.length}',
                            icon:
                                Icons.favorite_rounded,
                            color:
                                Colors.pink,
                            subtitle:
                                'Wishlist items',
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      // SEARCH

                      Container(

                        decoration:
                            BoxDecoration(

                          color:
                              Colors.white,

                          borderRadius:
                              BorderRadius.circular(
                            16,
                          ),
                        ),

                        child: TextField(

                          onChanged:
                              productProvider
                                  .searchProducts,

                          decoration:
                              const InputDecoration(

                            hintText:
                                'Search product...',

                            prefixIcon:
                                Icon(
                              Icons.search,
                              size: 18,
                            ),

                            border:
                                InputBorder.none,

                            contentPadding:
                                EdgeInsets.symmetric(

                              horizontal:
                                  14,

                              vertical:
                                  13,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      // CATEGORY

                      SizedBox(

                        height: 36,

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
                                right: 8,
                              ),

                              child:
                                  ChoiceChip(

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

                                          ? Colors
                                              .white

                                          : Colors
                                              .black87,

                                  fontWeight:
                                      FontWeight
                                          .w600,

                                  fontSize:
                                      10,
                                ),

                                shape:
                                    RoundedRectangleBorder(

                                  borderRadius:
                                      BorderRadius.circular(
                                    11,
                                  ),
                                ),

                                onSelected:
                                    (_) {

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
                        height: 20,
                      ),

                      // TITLE

                      Row(

                        mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,

                        children: [

                          const Text(

                            'Recommended Products',

                            style:
                                TextStyle(

                              fontSize:
                                  17,

                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          Text(

                            '${displayProducts.length} items',

                            style:
                                TextStyle(

                              color:
                                  Colors.grey
                                      .shade600,

                              fontSize:
                                  10,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 14,
                      ),

                      // PRODUCT GRID

                      ProductGrid(
                        products:
                            displayProducts,
                      ),

                      const SizedBox(
                        height: 100,
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
}