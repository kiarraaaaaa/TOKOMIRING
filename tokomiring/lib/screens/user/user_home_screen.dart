// lib/screens/user/user_home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_format.dart';

import '../../providers/cart_provider.dart';
import '../../providers/product_provider.dart';

import '../../widgets/cards/product_card.dart';

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
    extends State<UserHomeScreen> {

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(
    BuildContext context,
  ) {

    final productProvider =
        Provider.of<ProductProvider>(
      context,
    );

    final screenWidth =
        MediaQuery.of(context)
            .size
            .width;

    // ===================================================
    // RESPONSIVE GRID
    // ===================================================

    int crossAxisCount = 2;

    if (screenWidth >= 1200) {

      crossAxisCount = 5;
    }

    else if (screenWidth >= 900) {

      crossAxisCount = 4;
    }

    else if (screenWidth >= 700) {

      crossAxisCount = 3;
    }

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

        centerTitle: false,

        title: const Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(

              'Toko Miring',

              style: TextStyle(

                fontWeight:
                    FontWeight.bold,

                fontSize: 24,
              ),
            ),

            SizedBox(
              height: 2,
            ),

            Text(

              'Realtime Ecommerce',

              style: TextStyle(

                fontSize: 13,

                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),

      // ===================================================
      // FLOATING CART
      // ===================================================

      floatingActionButtonLocation:
          FloatingActionButtonLocation
              .centerFloat,

      floatingActionButton:
          Consumer<CartProvider>(

        builder: (
          context,
          cartProvider,
          child,
        ) {

          if (cartProvider.isEmpty) {

            return const SizedBox();
          }

          return GestureDetector(

            onTap: () {

              Navigator.push(

                context,

                MaterialPageRoute(

                  builder: (_) =>
                      const CartScreen(),
                ),
              );
            },

            child: AnimatedContainer(

              duration:
                  const Duration(
                milliseconds: 250,
              ),

              margin:
                  const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              width: double.infinity,

              constraints:
                  const BoxConstraints(
                maxWidth: 420,
              ),

              padding:
                  const EdgeInsets.symmetric(

                horizontal: 22,

                vertical: 16,
              ),

              decoration:
                  BoxDecoration(

                gradient:
                    const LinearGradient(

                  colors: [

                    Color(0xff2563EB),

                    Color(0xff1D4ED8),
                  ],
                ),

                borderRadius:
                    BorderRadius.circular(
                  24,
                ),

                boxShadow: [

                  BoxShadow(

                    color:
                        Colors.blue
                            .withOpacity(
                      0.25,
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

                  // =====================================
                  // ICON
                  // =====================================

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
                        0.18,
                      ),

                      shape:
                          BoxShape.circle,
                    ),

                    child: Stack(

                      clipBehavior:
                          Clip.none,

                      children: [

                        const Icon(

                          Icons.shopping_cart,

                          color:
                              Colors.white,
                        ),

                        Positioned(

                          top: -6,

                          right: -6,

                          child: Container(

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
                    width: 16,
                  ),

                  // =====================================
                  // INFO
                  // =====================================

                  Expanded(

                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        const Text(

                          'View Cart',

                          style: TextStyle(

                            color:
                                Colors.white,

                            fontSize: 16,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 4,
                        ),

                        Text(

                          '${cartProvider.totalItems} items',

                          style: TextStyle(

                            color:
                                Colors.white
                                    .withOpacity(
                              0.9,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // =====================================
                  // TOTAL
                  // =====================================

                  Text(

                    AppFormat.currency(
                      cartProvider
                          .totalPrice,
                    ),

                    style:
                        const TextStyle(

                      color:
                          Colors.white,

                      fontSize: 18,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      // ===================================================
      // BODY
      // ===================================================

      body: Padding(

        padding:
            const EdgeInsets.all(
          20,
        ),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // =============================================
            // HEADER
            // =============================================

            const Text(

              'Discover Products',

              style: TextStyle(

                fontSize: 30,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            Text(

              'Find your favorite products easily',

              style: TextStyle(

                color:
                    Colors.grey
                        .shade600,

                fontSize: 16,
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            // =============================================
            // SEARCH
            // =============================================

            TextField(

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

                filled: true,

                fillColor:
                    Colors.white,

                contentPadding:
                    const EdgeInsets.symmetric(
                  vertical: 18,
                ),

                border:
                    OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),

                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            // =============================================
            // CATEGORY
            // =============================================

            SizedBox(

              height: 52,

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
                          Text(category),

                      selected:
                          selected,

                      showCheckmark:
                          false,

                      selectedColor:
                          AppColors.primary,

                      backgroundColor:
                          Colors.white,

                      side: BorderSide(

                        color:
                            selected

                                ? AppColors
                                    .primary

                                : Colors
                                    .grey
                                    .shade300,
                      ),

                      labelStyle:
                          TextStyle(

                        color:
                            selected

                                ? Colors
                                    .white

                                : Colors
                                    .black,

                        fontWeight:
                            FontWeight.w600,
                      ),

                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
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
              height: 25,
            ),

            // =============================================
            // GRID
            // =============================================

            Expanded(

              child:
                  productProvider
                          .isLoading

                      ? const Center(
                          child:
                              CircularProgressIndicator(),
                        )

                      : productProvider
                              .products
                              .isEmpty

                          ? Center(

                              child: Column(

                                mainAxisAlignment:
                                    MainAxisAlignment.center,

                                children: [

                                  Icon(

                                    Icons
                                        .inventory_2_outlined,

                                    size: 100,

                                    color:
                                        Colors.grey
                                            .shade400,
                                  ),

                                  const SizedBox(
                                    height: 20,
                                  ),

                                  const Text(

                                    'No Products Found',

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

                                    'Try another keyword or category',

                                    style: TextStyle(

                                      color:
                                          Colors.grey
                                              .shade600,
                                    ),
                                  ),
                                ],
                              ),
                            )

                          : GridView.builder(

                              physics:
                                  const BouncingScrollPhysics(),

                              padding:
                                  const EdgeInsets.only(
                                bottom: 120,
                              ),

                              itemCount:
                                  productProvider
                                      .products
                                      .length,

                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(

                                crossAxisCount:
                                    crossAxisCount,

                                crossAxisSpacing:
                                    20,

                                mainAxisSpacing:
                                    20,

                                childAspectRatio:
                                    0.68,
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
            ),
          ],
        ),
      ),
    );
  }
}