import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';

import '../../widgets/cards/product_card.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() =>
      _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Toko Miring',
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              onChanged:
                  productProvider.searchProducts,
              decoration:
                  const InputDecoration(
                hintText:
                    'Search products...',
                prefixIcon:
                    Icon(Icons.search),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection:
                    Axis.horizontal,
                itemCount: productProvider
                    .categories.length,
                itemBuilder: (context, index) {
                  final category =
                      productProvider.categories[
                          index];

                  return Padding(
                    padding:
                        const EdgeInsets.only(
                      right: 10,
                    ),
                    child: ChoiceChip(
                      label: Text(category),
                      selected:
                          productProvider
                                  .selectedCategory ==
                              category,
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

            const SizedBox(height: 20),

            Expanded(
              child: productProvider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio:
                            0.72,
                      ),
                      itemCount:
                          productProvider.products.length,
                      itemBuilder:
                          (context, index) {
                        return ProductCard(
                          product:
                              productProvider.products[
                                  index],
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
