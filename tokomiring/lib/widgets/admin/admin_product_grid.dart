// =====================================================
// FULL FIXED VERSION
// lib/widgets/admin/admin_product_grid.dart
// =====================================================

import 'dart:convert';

import 'package:flutter/material.dart';

import '../../models/product_model.dart';
import '../../core/utils/app_format.dart';

class AdminProductGrid
    extends StatefulWidget {

  final List<ProductModel>
      products;

  final Function(
    ProductModel product,
  ) onEdit;

  final Function(
    ProductModel product,
  ) onDelete;

  final Function(
    ProductModel product,
  ) onStock;

  const AdminProductGrid({
    super.key,
    required this.products,
    required this.onEdit,
    required this.onDelete,
    required this.onStock,
  });

  @override
  State<AdminProductGrid>
      createState() =>
          _AdminProductGridState();
}

class _AdminProductGridState
    extends State<AdminProductGrid>
    with SingleTickerProviderStateMixin {

  late AnimationController
      _controller;

  late Animation<double>
      _fadeAnimation;

  @override
  void initState() {

    super.initState();

    _controller =
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
          _controller,

      curve:
          Curves.easeInOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {

    _controller.dispose();

    super.dispose();
  }

  Color stockColor(
    int stock,
  ) {

    if (stock <= 0) {
      return Colors.red;
    }

    if (stock <= 10) {
      return Colors.orange;
    }

    return Colors.green;
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    final width =
        MediaQuery.of(
          context,
        ).size.width;

    return FadeTransition(

      opacity:
          _fadeAnimation,

      child:
          GridView.builder(

        shrinkWrap: true,

        physics:
            const NeverScrollableScrollPhysics(),

        itemCount:
            widget.products.length,

        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(

          crossAxisCount:

              width < 700

                  ? 1

                  : width < 1100

                      ? 2

                      : width < 1500

                          ? 3

                          : 4,

          crossAxisSpacing:
              20,

          mainAxisSpacing:
              20,

          childAspectRatio:

              width < 700

                  ? 0.84

                  : width < 1100

                      ? 0.72

                      : 0.78,
        ),

        itemBuilder: (
          context,
          index,
        ) {

          final product =
              widget.products[index];

          return ProductCard(

            product:
                product,

            stockColor:
                stockColor(
              product.stock,
            ),

            onEdit: () {

              widget.onEdit(
                product,
              );
            },

            onDelete: () {

              widget.onDelete(
                product,
              );
            },

            onStock: () {

              widget.onStock(
                product,
              );
            },
          );
        },
      ),
    );
  }
}

// =====================================================
// PRODUCT CARD
// =====================================================

class ProductCard
    extends StatefulWidget {

  final ProductModel product;

  final Color stockColor;

  final VoidCallback onEdit;

  final VoidCallback onDelete;

  final VoidCallback onStock;

  const ProductCard({
    super.key,
    required this.product,
    required this.stockColor,
    required this.onEdit,
    required this.onDelete,
    required this.onStock,
  });

  @override
  State<ProductCard>
      createState() =>
          _ProductCardState();
}

class _ProductCardState
    extends State<ProductCard> {

  bool isHovered = false;

  @override
  Widget build(
    BuildContext context,
  ) {

    final width =
        MediaQuery.of(
          context,
        ).size.width;

    final isMobile =
        width < 700;

    return MouseRegion(

      onEnter: (_) {

        setState(() {

          isHovered = true;
        });
      },

      onExit: (_) {

        setState(() {

          isHovered = false;
        });
      },

      child:
          AnimatedContainer(

        duration:
            const Duration(
          milliseconds: 250,
        ),

        transform:
            Matrix4.identity()

              ..translate(
                0.0,
                isHovered
                    ? -6.0
                    : 0.0,
              )

              ..scale(
                isHovered
                    ? 1.01
                    : 1.0,
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
                isHovered
                    ? 0.08
                    : 0.04,
              ),

              blurRadius:
                  isHovered
                      ? 20
                      : 12,

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

            // =========================================
            // IMAGE
            // =========================================

            Expanded(

              flex: 5,

              child: Stack(
                children: [

                  ClipRRect(

                    borderRadius:
                        const BorderRadius.only(

                      topLeft:
                          Radius.circular(
                        28,
                      ),

                      topRight:
                          Radius.circular(
                        28,
                      ),
                    ),

                    child:

                        widget.product
                                .imageBase64
                                .isNotEmpty

                            ? Image.memory(

                                base64Decode(
                                  widget.product
                                      .imageBase64,
                                ),

                                width:
                                    double.infinity,

                                height:
                                    double.infinity,

                                fit:
                                    BoxFit.cover,

                                errorBuilder: (
                                  context,
                                  error,
                                  stackTrace,
                                ) {

                                  return placeholderImage();
                                },
                              )

                            : placeholderImage(),
                  ),

                  // =====================================
                  // CATEGORY
                  // =====================================

                  Positioned(

                    top: 14,

                    left: 14,

                    child:
                        Container(

                      constraints:
                          const BoxConstraints(
                        maxWidth:
                            120,
                      ),

                      padding:
                          const EdgeInsets.symmetric(

                        horizontal:
                            12,

                        vertical:
                            8,
                      ),

                      decoration:
                          BoxDecoration(

                        color:
                            Colors.white,

                        borderRadius:
                            BorderRadius.circular(
                          14,
                        ),
                      ),

                      child: Text(

                        widget.product
                            .category,

                        overflow:
                            TextOverflow
                                .ellipsis,

                        style:
                            const TextStyle(

                          fontWeight:
                              FontWeight.bold,

                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),

                  // =====================================
                  // STOCK
                  // =====================================

                  Positioned(

                    top: 14,

                    right: 14,

                    child:
                        Container(

                      padding:
                          const EdgeInsets.symmetric(

                        horizontal:
                            12,

                        vertical:
                            8,
                      ),

                      decoration:
                          BoxDecoration(

                        color:
                            widget.stockColor
                                .withOpacity(
                          0.12,
                        ),

                        borderRadius:
                            BorderRadius.circular(
                          14,
                        ),
                      ),

                      child: Text(

                        '${widget.product.stock}',

                        style:
                            TextStyle(

                          color:
                              widget.stockColor,

                          fontWeight:
                              FontWeight.bold,

                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // =========================================
            // CONTENT
            // =========================================

            Expanded(

              flex: 4,

              child: Padding(

                padding:
                    EdgeInsets.all(
                  isMobile
                      ? 18
                      : 20,
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    Text(

                      widget.product.name,

                      maxLines: 1,

                      overflow:
                          TextOverflow
                              .ellipsis,

                      style:
                          TextStyle(

                        fontSize:
                            isMobile
                                ? 18
                                : 20,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Expanded(
                      child: Text(

                        widget.product
                            .description,

                        maxLines:
                            isMobile
                                ? 2
                                : 3,

                        overflow:
                            TextOverflow
                                .ellipsis,

                        style:
                            TextStyle(

                          color:
                              Colors.grey
                                  .shade600,

                          fontSize:
                              isMobile
                                  ? 13
                                  : 14,

                          height: 1.45,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 14,
                    ),

                    FittedBox(

                      fit:
                          BoxFit.scaleDown,

                      alignment:
                          Alignment.centerLeft,

                      child: Text(

                        AppFormat.currency(
                          widget.product
                              .price,
                        ),

                        style:
                            TextStyle(

                          fontSize:
                              isMobile
                                  ? 22
                                  : 24,

                          fontWeight:
                              FontWeight.bold,

                          color:
                              Colors.green,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Row(
                      children: [

                        Icon(

                          Icons
                              .shopping_bag_rounded,

                          size: 18,

                          color:
                              Colors.grey
                                  .shade600,
                        ),

                        const SizedBox(
                          width: 6,
                        ),

                        Expanded(
                          child: Text(

                            '${widget.product.sold} sold',

                            overflow:
                                TextOverflow
                                    .ellipsis,

                            style:
                                TextStyle(

                              color:
                                  Colors.grey
                                      .shade600,

                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 18,
                    ),

                    Row(
                      children: [

                        Expanded(
                          child:
                              actionButton(

                            icon:
                                Icons
                                    .edit_rounded,

                            title:
                                'Edit',

                            color:
                                Colors.blue,

                            onTap:
                                widget.onEdit,
                          ),
                        ),

                        const SizedBox(
                          width: 8,
                        ),

                        Expanded(
                          child:
                              actionButton(

                            icon:
                                Icons
                                    .inventory_2_rounded,

                            title:
                                'Stock',

                            color:
                                Colors.orange,

                            onTap:
                                widget.onStock,
                          ),
                        ),

                        const SizedBox(
                          width: 8,
                        ),

                        Expanded(
                          child:
                              actionButton(

                            icon:
                                Icons
                                    .delete_rounded,

                            title:
                                'Delete',

                            color:
                                Colors.red,

                            onTap:
                                widget.onDelete,
                          ),
                        ),
                      ],
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
  // PLACEHOLDER
  // =====================================================

  Widget placeholderImage() {

    return Container(

      width:
          double.infinity,

      height:
          double.infinity,

      decoration:
          BoxDecoration(

        gradient:
            LinearGradient(

          colors: [

            Colors.blue
                .withOpacity(
              0.08,
            ),

            Colors.purple
                .withOpacity(
              0.08,
            ),
          ],
        ),
      ),

      child:
          const Center(

        child: Icon(

          Icons
              .inventory_2_rounded,

          size: 80,

          color:
              Colors.blue,
        ),
      ),
    );
  }

  // =====================================================
  // ACTION BUTTON
  // =====================================================

  Widget actionButton({

    required IconData icon,

    required String title,

    required Color color,

    required VoidCallback onTap,
  }) {

    return GestureDetector(

      onTap:
          onTap,

      child:
          AnimatedContainer(

        duration:
            const Duration(
          milliseconds: 250,
        ),

        padding:
            const EdgeInsets.symmetric(
          vertical: 12,
        ),

        decoration:
            BoxDecoration(

          color:
              color.withOpacity(
            0.1,
          ),

          borderRadius:
              BorderRadius.circular(
            16,
          ),
        ),

        child: Column(
          mainAxisSize:
              MainAxisSize.min,

          children: [

            Icon(

              icon,

              color:
                  color,

              size: 20,
            ),

            const SizedBox(
              height: 6,
            ),

            Text(

              title,

              overflow:
                  TextOverflow
                      .ellipsis,

              style:
                  TextStyle(

                color:
                    color,

                fontSize: 11,

                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}