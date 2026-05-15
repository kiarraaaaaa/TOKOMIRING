// =====================================================
// lib/screens/user/user_home_screen.dart
// ULTRA CLEAN PREMIUM RESPONSIVE VERSION
// =====================================================

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
import '../../widgets/cards/product_card.dart';
import '../../widgets/user/user_sidebar.dart';

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

  late Animation<double>
      _fadeAnimation;

  int _selectedIndex = 0;

  // =========================================
  // INIT
  // =========================================

  @override
  void initState() {

    super.initState();

    _fadeController =
        AnimationController(

      vsync: this,

      duration:
          const Duration(
        milliseconds: 600,
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

  // =========================================
  // DISPOSE
  // =========================================

  @override
  void dispose() {

    _fadeController.dispose();

    super.dispose();
  }

  // =========================================
  // BUILD
  // =========================================

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

    // =====================================
    // PRODUCT DISPLAY
    // =====================================

    final displayProducts =

        productProvider.searchQuery
                    .isEmpty &&
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

            : productProvider
                .products;

    // =====================================
    // GRID
    // =====================================

    int gridCount = 2;

    double aspectRatio = 0.72;

    if (width >= 1700) {

      gridCount = 6;

      aspectRatio = 0.84;
    }

    else if (width >= 1450) {

      gridCount = 5;

      aspectRatio = 0.82;
    }

    else if (width >= 1150) {

      gridCount = 4;

      aspectRatio = 0.80;
    }

    else if (width >= 850) {

      gridCount = 3;

      aspectRatio = 0.76;
    }

    return Scaffold(

      backgroundColor:
          const Color(
        0xffF4F7FC,
      ),

      // =====================================
      // FLOATING CART
      // =====================================

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

                  child: Container(

                    width:
                        isMobile
                            ? width * 0.90
                            : 320,

                    padding:
                        const EdgeInsets.symmetric(

                      horizontal: 16,

                      vertical: 12,
                    ),

                    decoration:
                        BoxDecoration(

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

                          blurRadius: 24,

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

                        Container(

                          padding:
                              const EdgeInsets.all(
                            10,
                          ),

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

                          child: Stack(

                            clipBehavior:
                                Clip.none,

                            children: [

                              const Icon(

                                Icons
                                    .shopping_cart_rounded,

                                color:
                                    Colors.white,

                                size: 20,
                              ),

                              Positioned(

                                top: -4,

                                right: -4,

                                child: Container(

                                  padding:
                                      const EdgeInsets.all(
                                    4,
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

                                      fontSize: 9,

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
                          width: 12,
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
                                      Colors.white,

                                  fontWeight:
                                      FontWeight.bold,

                                  fontSize: 13,
                                ),
                              ),

                              const SizedBox(
                                height: 2,
                              ),

                              Text(

                                '${cartProvider.totalItems} items',

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

                                  fontSize: 11,
                                ),
                              ),
                            ],
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
                                TextAlign.right,

                            style:
                                const TextStyle(

                              color:
                                  Colors.white,

                              fontWeight:
                                  FontWeight.bold,

                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

      // =====================================
      // BODY
      // =====================================

      body: Row(

        children: [

          // =================================
          // SIDEBAR
          // =================================

          if (!isMobile)

            UserSidebar(

              selectedIndex:
                  _selectedIndex,

              onSelected: (index) {

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

          // =================================
          // CONTENT
          // =================================

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
                        ? 14
                        : 20,
                  ),

                  child: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [

                      // ===========================
                      // HEADER
                      // ===========================

                      Container(

                        padding:
                            EdgeInsets.all(
                          isMobile
                              ? 16
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
                                0.04,
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

                                      fontSize: 12,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 4,
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
                                              ? 22
                                              : 26,

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
                                12,
                              ),

                              decoration:
                                  BoxDecoration(

                                color:
                                    Colors.grey
                                        .shade100,

                                borderRadius:
                                    BorderRadius.circular(
                                  16,
                                ),
                              ),

                              child:
                                  const Icon(

                                Icons
                                    .notifications_none_rounded,

                                size: 22,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // ===========================
                      // HERO
                      // ===========================

                      Container(

                        width:
                            double.infinity,

                        padding:
                            EdgeInsets.all(
                          isMobile
                              ? 22
                              : 28,
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

                                horizontal: 12,

                                vertical: 7,
                              ),

                              decoration:
                                  BoxDecoration(

                                color:
                                    Colors.white
                                        .withOpacity(
                                  0.14,
                                ),

                                borderRadius:
                                    BorderRadius.circular(
                                  24,
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

                                  fontSize: 11,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 20,
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
                                        ? 24
                                        : 34,
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            Text(

                              'Responsive shopping marketplace with realtime analytics and premium UI.',

                              style:
                                  TextStyle(

                                color:
                                    Colors.white
                                        .withOpacity(
                                  0.88,
                                ),

                                fontSize:
                                    isMobile
                                        ? 12
                                        : 14,

                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 22,
                      ),

                      // ===========================
                      // ANALYTICS
                      // ===========================

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
                            14,

                        mainAxisSpacing:
                            14,

                        childAspectRatio:

                            isMobile
                                ? 1.40
                                : 1.65,

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
                        height: 24,
                      ),

                      // ===========================
                      // SEARCH
                      // ===========================

                      Container(

                        decoration:
                            BoxDecoration(

                          color:
                              Colors.white,

                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),

                          boxShadow: [

                            BoxShadow(

                              color:
                                  Colors.black
                                      .withOpacity(
                                0.03,
                              ),

                              blurRadius: 12,

                              offset:
                                  const Offset(
                                0,
                                5,
                              ),
                            ),
                          ],
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
                            ),

                            border:
                                InputBorder.none,

                            contentPadding:
                                EdgeInsets.symmetric(

                              horizontal: 16,

                              vertical: 15,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      // ===========================
                      // CATEGORY
                      // ===========================

                      SizedBox(

                        height: 42,

                        child:
                            ListView.builder(

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
                                right: 10,
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
                                    AppColors
                                        .primary,

                                backgroundColor:
                                    Colors.white,

                                labelStyle:
                                    TextStyle(

                                  color:
                                      selected

                                          ? Colors.white

                                          : Colors.black87,

                                  fontWeight:
                                      FontWeight.w600,

                                  fontSize:
                                      12,
                                ),

                                shape:
                                    RoundedRectangleBorder(

                                  borderRadius:
                                      BorderRadius.circular(
                                    14,
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
                        height: 24,
                      ),

                      // ===========================
                      // TITLE
                      // ===========================

                      Row(

                        mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,

                        children: [

                          const Expanded(

                            child: Text(

                              'Recommended Products',

                              overflow:
                                  TextOverflow
                                      .ellipsis,

                              style:
                                  TextStyle(

                                fontSize: 22,

                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(
                            width: 12,
                          ),

                          Text(

                            '${displayProducts.length} items',

                            overflow:
                                TextOverflow
                                    .ellipsis,

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

                      // ===========================
                      // PRODUCTS
                      // ===========================

                      productProvider
                              .isLoading

                          ? const Padding(

                              padding:
                                  EdgeInsets.all(
                                60,
                              ),

                              child: Center(

                                child:
                                    CircularProgressIndicator(),
                              ),
                            )

                          : displayProducts
                                  .isEmpty

                              ? Padding(

                                  padding:
                                      const EdgeInsets.symmetric(
                                    vertical:
                                        90,
                                  ),

                                  child: Center(

                                    child:
                                        Column(

                                      children: [

                                        Icon(

                                          Icons
                                              .inventory_2_outlined,

                                          size:
                                              82,

                                          color:
                                              Colors.grey
                                                  .shade400,
                                        ),

                                        const SizedBox(
                                          height:
                                              16,
                                        ),

                                        const Text(

                                          'No Products Found',

                                          style:
                                              TextStyle(

                                            fontSize:
                                                22,

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
                                      displayProducts
                                          .length,

                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(

                                    crossAxisCount:
                                        gridCount,

                                    crossAxisSpacing:
                                        16,

                                    mainAxisSpacing:
                                        16,

                                    childAspectRatio:
                                        aspectRatio,
                                  ),

                                  itemBuilder:
                                      (
                                    context,
                                    index,
                                  ) {

                                    final product =
                                        displayProducts[
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
}