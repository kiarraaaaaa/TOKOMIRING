// =====================================================
// lib/screens/user/user_wishlist_screen.dart
// FINAL ULTRA COMPACT PREMIUM VERSION
// =====================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';

import '../../providers/product_provider.dart';

import '../../widgets/cards/product_grid.dart';

class UserWishlistScreen
    extends StatefulWidget {

  const UserWishlistScreen({
    super.key,
  });

  @override
  State<UserWishlistScreen>
      createState() =>
          _UserWishlistScreenState();
}

class _UserWishlistScreenState
    extends State<UserWishlistScreen>
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
        milliseconds: 420,
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

  @override
  void dispose() {

    _animationController
        .dispose();

    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    final productProvider =
        context.watch<
            ProductProvider>();

    final favorites =
        productProvider
            .favoriteProducts;

    final width =
        MediaQuery.of(context)
            .size
            .width;

    final isMobile =
        width < 700;

    return Scaffold(

      backgroundColor:
          const Color(
        0xffF5F7FB,
      ),

      appBar: AppBar(

        elevation: 0,

        backgroundColor:
            Colors.transparent,

        surfaceTintColor:
            Colors.transparent,

        titleSpacing: 18,

        title: Column(

          crossAxisAlignment:
              CrossAxisAlignment
                  .start,

          children: [

            Text(

              'Wishlist',

              style: TextStyle(

                color:
                    Colors.black,

                fontSize:
                    isMobile
                        ? 19
                        : 21,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 1,
            ),

            Text(

              'Favorite products collection',

              style: TextStyle(

                color:
                    Colors.grey,

                fontSize:
                    isMobile
                        ? 10
                        : 11,
              ),
            ),
          ],
        ),
      ),

      body: FadeTransition(

        opacity:
            _fadeAnimation,

        child:
            SafeArea(

          child: Padding(

            padding:
                EdgeInsets.all(

              isMobile
                  ? 12
                  : 18,
            ),

            child:

                favorites.isEmpty

                    ? Center(

                        child:
                            SingleChildScrollView(

                          physics:
                              const BouncingScrollPhysics(),

                          child: Column(

                            mainAxisSize:
                                MainAxisSize
                                    .min,

                            children: [

                              Container(

                                width:
                                    isMobile
                                        ? 120
                                        : 135,

                                height:
                                    isMobile
                                        ? 120
                                        : 135,

                                decoration:
                                    BoxDecoration(

                                  shape:
                                      BoxShape.circle,

                                  gradient:
                                      LinearGradient(

                                    colors: [

                                      Colors.pink
                                          .withOpacity(
                                        0.14,
                                      ),

                                      Colors.pink
                                          .withOpacity(
                                        0.04,
                                      ),
                                    ],
                                  ),
                                ),

                                child:
                                    Icon(

                                  Icons
                                      .favorite_border_rounded,

                                  size:
                                      isMobile
                                          ? 52
                                          : 60,

                                  color:
                                      Colors.pink,
                                ),
                              ),

                              const SizedBox(
                                height: 20,
                              ),

                              Text(

                                'No Wishlist Yet',

                                textAlign:
                                    TextAlign
                                        .center,

                                style:
                                    TextStyle(

                                  fontSize:
                                      isMobile
                                          ? 20
                                          : 22,

                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              const SizedBox(
                                height: 8,
                              ),

                              Container(

                                constraints:
                                    const BoxConstraints(
                                  maxWidth:
                                      320,
                                ),

                                child: Text(

                                  'Tap the favorite icon on products to save them here.',

                                  textAlign:
                                      TextAlign
                                          .center,

                                  style:
                                      TextStyle(

                                    color:
                                        Colors
                                            .grey
                                            .shade600,

                                    fontSize:
                                        isMobile
                                            ? 12
                                            : 13,

                                    height:
                                        1.45,
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: 22,
                              ),

                              ElevatedButton.icon(

                                style:
                                    ElevatedButton.styleFrom(

                                  elevation: 0,

                                  backgroundColor:
                                      AppColors
                                          .primary,

                                  foregroundColor:
                                      Colors.white,

                                  padding:
                                      const EdgeInsets.symmetric(

                                    horizontal:
                                        18,

                                    vertical:
                                        13,
                                  ),

                                  shape:
                                      RoundedRectangleBorder(

                                    borderRadius:
                                        BorderRadius.circular(
                                      16,
                                    ),
                                  ),
                                ),

                                onPressed:
                                    () {

                                      Navigator.pop(
                                        context,
                                      );
                                    },

                                icon:
                                    const Icon(

                                  Icons
                                      .shopping_bag_rounded,

                                  size: 16,
                                ),

                                label:
                                    const Text(

                                  'Explore Products',

                                  style:
                                      TextStyle(

                                    fontSize:
                                        12,

                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )

                    : Column(

                        children: [

                          // =================================
                          // HEADER CARD
                          // =================================

                          Container(

                            width:
                                double.infinity,

                            padding:
                                const EdgeInsets.all(
                              16,
                            ),

                            decoration:
                                BoxDecoration(

                              borderRadius:
                                  BorderRadius.circular(
                                22,
                              ),

                              gradient:
                                  const LinearGradient(

                                begin:
                                    Alignment.topLeft,

                                end:
                                    Alignment.bottomRight,

                                colors: [

                                  Color(
                                    0xffEC4899,
                                  ),

                                  Color(
                                    0xffDB2777,
                                  ),
                                ],
                              ),

                              boxShadow: [

                                BoxShadow(

                                  color:
                                      Colors.pink
                                          .withOpacity(
                                    0.16,
                                  ),

                                  blurRadius:
                                      16,

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

                                Container(

                                  width: 46,

                                  height: 46,

                                  decoration:
                                      BoxDecoration(

                                    color:
                                        Colors.white
                                            .withOpacity(
                                      0.14,
                                    ),

                                    borderRadius:
                                        BorderRadius.circular(
                                      14,
                                    ),
                                  ),

                                  child:
                                      const Icon(

                                    Icons
                                        .favorite_rounded,

                                    color:
                                        Colors.white,

                                    size: 22,
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

                                        'Wishlist Items',

                                        style:
                                            TextStyle(

                                          color:
                                              Colors
                                                  .white,

                                          fontWeight:
                                              FontWeight.bold,

                                          fontSize:
                                              15,
                                        ),
                                      ),

                                      const SizedBox(
                                        height:
                                            2,
                                      ),

                                      Text(

                                        '${favorites.length} favorite products saved',

                                        style:
                                            TextStyle(

                                          color:
                                              Colors
                                                  .white
                                                  .withOpacity(
                                            0.84,
                                          ),

                                          fontSize:
                                              11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Container(

                                  padding:
                                      const EdgeInsets.symmetric(

                                    horizontal:
                                        12,

                                    vertical:
                                        7,
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
                                      18,
                                    ),
                                  ),

                                  child: Text(

                                    '${favorites.length}',

                                    style:
                                        const TextStyle(

                                      color:
                                          Colors
                                              .white,

                                      fontWeight:
                                          FontWeight.bold,

                                      fontSize:
                                          12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 18,
                          ),

                          // =================================
                          // PRODUCT GRID
                          // =================================

                          Expanded(

                            child: ProductGrid(
                              products:
                                  favorites,
                            ),
                          ),
                        ],
                      ),
          ),
        ),
      ),
    );
  }
}