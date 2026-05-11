// lib/screens/user/user_home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';

import '../../widgets/cards/product_card.dart';

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
  // INIT
  // =====================================================

  @override
  void initState() {
    super.initState();

    Future.microtask(() {

      Provider.of<ProductProvider>(
        context,
        listen: false,
      ).initializeProducts();
    });
  }

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

    return Scaffold(
      backgroundColor:
          const Color(0xffF8FAFC),

      // ===================================================
      // APP BAR
      // ===================================================

      appBar: AppBar(
        elevation: 0,

        backgroundColor:
            Colors.white,

        foregroundColor:
            Colors.black,

        title: const Text(
          'Toko Miring',

          style: TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),

        actions: [

          IconButton(
            onPressed: () {},

            icon: const Icon(
              Icons.shopping_cart,
            ),
          ),

          const SizedBox(
            width: 10,
          ),
        ],
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
          children: [

            // ===============================================
            // SEARCH
            // ===============================================

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

                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    18,
                  ),

                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            // ===============================================
            // CATEGORY FILTER
            // ===============================================

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
                      right: 10,
                    ),

                    child: ChoiceChip(
                      label:
                          Text(category),

                      selected:
                          selected,

                      selectedColor:
                          Colors.blue,

                      labelStyle:
                          TextStyle(
                        color:
                            selected
                                ? Colors
                                    .white
                                : Colors
                                    .black,
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
              height: 20,
            ),

            // ===============================================
            // PRODUCT GRID
            // ===============================================

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
                          ? const Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,

                                children: [

                                  Icon(
                                    Icons.inventory_2_outlined,

                                    size:
                                        90,

                                    color:
                                        Colors.grey,
                                  ),

                                  SizedBox(
                                    height:
                                        20,
                                  ),

                                  Text(
                                    'No products available',

                                    style:
                                        TextStyle(
                                      fontSize:
                                          20,

                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )

                          : GridView.builder(

                              itemCount:
                                  productProvider
                                      .products
                                      .length,

                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    4,

                                crossAxisSpacing:
                                    20,

                                mainAxisSpacing:
                                    20,

                                childAspectRatio:
                                    0.70,
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