// =====================================================
// lib/widgets/cards/product_grid.dart
// COMPACT PREMIUM RESPONSIVE PRODUCT GRID
// =====================================================

import 'package:flutter/material.dart';

import '../../models/product_model.dart';

import 'product_card.dart';

class ProductGrid
    extends StatelessWidget {

  final List<ProductModel>
      products;

  final EdgeInsetsGeometry?
      padding;

  const ProductGrid({

    super.key,

    required this.products,

    this.padding,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    final width =
        MediaQuery.of(context)
            .size
            .width;

    int crossAxisCount = 2;

    double aspectRatio = 0.82;

    double spacing = 14;

    // =====================================
    // RESPONSIVE GRID
    // =====================================

    if (width >= 1700) {

      crossAxisCount = 6;

      aspectRatio = 0.96;

    } else if (width >= 1450) {

      crossAxisCount = 5;

      aspectRatio = 0.93;

    } else if (width >= 1150) {

      crossAxisCount = 4;

      aspectRatio = 0.90;

    } else if (width >= 850) {

      crossAxisCount = 3;

      aspectRatio = 0.86;

    } else if (width >= 600) {

      crossAxisCount = 2;

      aspectRatio = 0.82;

    } else {

      crossAxisCount = 2;

      aspectRatio = 0.78;

      spacing = 10;
    }

    return GridView.builder(

      shrinkWrap: true,

      physics:
          const NeverScrollableScrollPhysics(),

      padding:
          padding,

      itemCount:
          products.length,

      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(

        crossAxisCount:
            crossAxisCount,

        crossAxisSpacing:
            spacing,

        mainAxisSpacing:
            spacing,

        childAspectRatio:
            aspectRatio,
      ),

      itemBuilder:
          (
        context,
        index,
      ) {

        final product =
            products[index];

        return AnimatedContainer(

          duration:
              Duration(

            milliseconds:
                120 +
                    (index * 20),
          ),

          curve:
              Curves.easeOut,

          child: ProductCard(
            product: product,
          ),
        );
      },
    );
  }
}