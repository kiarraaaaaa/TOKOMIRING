// =====================================================
// lib/screens/admin/admin_dashboard_screen.dart
// FULL FIX NO DOUBLE PRODUCT FINAL
// =====================================================

import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../core/utils/app_format.dart';
import '../../models/product_model.dart';
import '../../providers/product_provider.dart';

class AdminDashboardScreen
    extends StatefulWidget {

  const AdminDashboardScreen({
    super.key,
  });

  @override
  State<AdminDashboardScreen>
      createState() =>
          _AdminDashboardScreenState();
}

class _AdminDashboardScreenState
    extends State<AdminDashboardScreen> {

  final TextEditingController
      searchController =
      TextEditingController();

  // =====================================================
  // FIX DOUBLE INITIALIZE
  // =====================================================

  bool _alreadyInitialized =
      false;

  @override
  void initState() {

    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {

      if (_alreadyInitialized) {
        return;
      }

      _alreadyInitialized = true;

      final provider =
          Provider.of<ProductProvider>(
        context,
        listen: false,
      );

      provider.initializeProducts();
    });
  }

  // =====================================================
  // ADD / EDIT PRODUCT
  // =====================================================

  Future<void> showProductDialog({
    ProductModel? product,
  }) async {

    final provider =
        Provider.of<ProductProvider>(
      context,
      listen: false,
    );

    final nameController =
        TextEditingController(
      text: product?.name ?? '',
    );

    final descriptionController =
        TextEditingController(
      text:
          product?.description ??
              '',
    );

    final priceController =
        TextEditingController(
      text:
          product?.price
              .toString() ??
          '',
    );

    final stockController =
        TextEditingController(
      text:
          product?.stock
              .toString() ??
          '',
    );

    String selectedCategory =
        product?.category ??
            'Food';

    String imageBase64 =
        product?.imageBase64 ?? '';

    await showDialog(
      context: context,

      builder: (_) {

        return StatefulBuilder(
          builder: (
            context,
            setStateDialog,
          ) {

            return Dialog(
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                  25,
                ),
              ),

              child: Container(
                width: 650,

                padding:
                    const EdgeInsets.all(
                  30,
                ),

                child:
                    SingleChildScrollView(
                  child: Column(
                    mainAxisSize:
                        MainAxisSize.min,

                    children: [

                      Text(
                        product == null
                            ? 'Add Product'
                            : 'Edit Product',

                        style:
                            const TextStyle(
                          fontSize: 28,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      // =====================================
                      // IMAGE
                      // =====================================

                      GestureDetector(
                        onTap: () async {

                          final result =
                              await FilePicker
                                  .platform
                                  .pickFiles(
                            type:
                                FileType.image,

                            withData:
                                true,
                          );

                          if (result !=
                              null) {

                            Uint8List?
                                imageBytes =
                                result
                                    .files
                                    .first
                                    .bytes;

                            if (imageBytes !=
                                null) {

                              imageBase64 =
                                  base64Encode(
                                imageBytes,
                              );

                              setStateDialog(
                                () {},
                              );
                            }
                          }
                        },

                        child: Container(
                          width:
                              double.infinity,

                          height: 220,

                          decoration:
                              BoxDecoration(
                            color:
                                Colors.grey
                                    .shade200,

                            borderRadius:
                                BorderRadius.circular(
                              25,
                            ),
                          ),

                          child:
                              imageBase64
                                      .isEmpty

                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,

                                      children: const [

                                        Icon(
                                          Icons.image,
                                          size: 70,
                                        ),

                                        SizedBox(
                                          height: 15,
                                        ),

                                        Text(
                                          'Upload Product Image',
                                        ),
                                      ],
                                    )

                                  : ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(
                                        25,
                                      ),

                                      child:
                                          Image.memory(
                                        base64Decode(
                                          imageBase64,
                                        ),

                                        fit:
                                            BoxFit.cover,
                                      ),
                                    ),
                        ),
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      TextField(
                        controller:
                            nameController,

                        decoration:
                            const InputDecoration(
                          labelText:
                              'Product Name',
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      TextField(
                        controller:
                            descriptionController,

                        maxLines: 4,

                        decoration:
                            const InputDecoration(
                          labelText:
                              'Description',
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      DropdownButtonFormField<
                          String>(
                        value:
                            selectedCategory,

                        items: provider
                            .categories
                            .where(
                              (e) =>
                                  e !=
                                  'All',
                            )
                            .map(
                              (e) =>
                                  DropdownMenuItem(
                                value:
                                    e,

                                child:
                                    Text(
                                  e,
                                ),
                              ),
                            )
                            .toList(),

                        onChanged: (
                          value,
                        ) {

                          if (value !=
                              null) {

                            selectedCategory =
                                value;
                          }
                        },

                        decoration:
                            const InputDecoration(
                          labelText:
                              'Category',
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      TextField(
                        controller:
                            priceController,

                        keyboardType:
                            TextInputType.number,

                        decoration:
                            const InputDecoration(
                          labelText:
                              'Price',
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      TextField(
                        controller:
                            stockController,

                        keyboardType:
                            TextInputType.number,

                        decoration:
                            const InputDecoration(
                          labelText:
                              'Stock',
                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      Row(
                        children: [

                          Expanded(
                            child:
                                OutlinedButton(
                              onPressed:
                                  () {

                                Navigator.pop(
                                  context,
                                );
                              },

                              child:
                                  const Text(
                                'Cancel',
                              ),
                            ),
                          ),

                          const SizedBox(
                            width: 15,
                          ),

                          Expanded(
                            child:
                                ElevatedButton(
                              onPressed:
                                  () async {

                                if (nameController
                                        .text
                                        .trim()
                                        .isEmpty ||
                                    descriptionController
                                        .text
                                        .trim()
                                        .isEmpty ||
                                    priceController
                                        .text
                                        .trim()
                                        .isEmpty ||
                                    stockController
                                        .text
                                        .trim()
                                        .isEmpty ||
                                    imageBase64
                                        .isEmpty) {

                                  ScaffoldMessenger.of(
                                    context,
                                  ).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text(
                                        'Please complete all fields',
                                      ),
                                    ),
                                  );

                                  return;
                                }

                                // =================================
                                // FIX NO DOUBLE PRODUCT
                                // =================================

                                final productId =
                                    product?.id ??
                                        const Uuid()
                                            .v4();

                                final newProduct =
                                    ProductModel(

                                  id:
                                      productId,

                                  name:
                                      nameController
                                          .text
                                          .trim(),

                                  description:
                                      descriptionController
                                          .text
                                          .trim(),

                                  category:
                                      selectedCategory,

                                  imageBase64:
                                      imageBase64,

                                  price:
                                      double.tryParse(
                                            priceController
                                                .text,
                                          ) ??
                                          0,

                                  stock:
                                      int.tryParse(
                                            stockController
                                                .text,
                                          ) ??
                                          0,

                                  isAvailable:
                                      true,

                                  isPopular:
                                      false,

                                  sold:
                                      product?.sold ??
                                          0,

                                  createdAt:
                                      product?.createdAt ??
                                          DateTime.now(),
                                );

                                bool success;

                                // =============================
                                // ADD PRODUCT
                                // =============================

                                if (product ==
                                    null) {

                                  // =========================
                                  // CEK DUPLIKAT NAMA
                                  // =========================

                                  bool alreadyExists =
                                      provider.products.any(
                                    (item) =>
                                        item.name
                                            .toLowerCase() ==
                                        newProduct.name
                                            .toLowerCase(),
                                  );

                                  if (alreadyExists) {

                                    if (!mounted) {
                                      return;
                                    }

                                    ScaffoldMessenger.of(
                                      context,
                                    ).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text(
                                          'Product already exists',
                                        ),
                                      ),
                                    );

                                    return;
                                  }

                                  success =
                                      await provider
                                          .addProduct(
                                    newProduct,
                                  );
                                }

                                // =============================
                                // UPDATE PRODUCT
                                // =============================

                                else {

                                  success =
                                      await provider
                                          .updateProduct(
                                    newProduct,
                                  );
                                }

                                if (!mounted) {
                                  return;
                                }

                                Navigator.pop(
                                  context,
                                );

                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text(
                                      success
                                          ? 'Product saved'
                                          : 'Failed',
                                    ),
                                  ),
                                );
                              },

                              child:
                                  Text(
                                product ==
                                        null
                                    ? 'Add Product'
                                    : 'Save',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // =====================================================
  // DELETE PRODUCT
  // =====================================================

  Future<void> deleteProduct(
    ProductModel product,
  ) async {

    final provider =
        Provider.of<ProductProvider>(
      context,
      listen: false,
    );

    await provider.deleteProduct(
      product.id,
    );
  }

  // =====================================================
  // ADD STOCK
  // =====================================================

  Future<void> addStock(
    ProductModel product,
  ) async {

    final stockController =
        TextEditingController();

    await showDialog(
      context: context,

      builder: (_) {

        return AlertDialog(
          title:
              const Text(
            'Add Stock',
          ),

          content:
              TextField(
            controller:
                stockController,

            keyboardType:
                TextInputType.number,

            decoration:
                const InputDecoration(
              labelText:
                  'Input Stock',
            ),
          ),

          actions: [

            TextButton(
              onPressed:
                  () {

                Navigator.pop(
                  context,
                );
              },

              child:
                  const Text(
                'Cancel',
              ),
            ),

            ElevatedButton(
              onPressed:
                  () async {

                int addValue =
                    int.tryParse(
                          stockController
                              .text,
                        ) ??
                        0;

                final updatedProduct =
                    product.copyWith(
                  stock:
                      product.stock +
                          addValue,
                );

                await Provider.of<
                    ProductProvider>(
                  context,
                  listen: false,
                ).updateProduct(
                  updatedProduct,
                );

                if (!mounted) {
                  return;
                }

                Navigator.pop(
                  context,
                );
              },

              child:
                  const Text(
                'Save',
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    final provider =
        Provider.of<ProductProvider>(
      context,
    );

    return Scaffold(
      backgroundColor:
          const Color(0xffF8FAFC),

      floatingActionButton:
          FloatingActionButton.extended(

        onPressed: () {

          showProductDialog();
        },

        icon: const Icon(
          Icons.add,
        ),

        label: const Text(
          'Add Product',
        ),
      ),

      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
        ),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(
          20,
        ),

        child: Column(
          children: [

            Row(
              children: [

                dashboardCard(
                  title:
                      'Total Products',

                  value:
                      provider.products
                          .length
                          .toString(),

                  icon:
                      Icons.inventory_2,
                ),

                const SizedBox(
                  width: 20,
                ),

                dashboardCard(
                  title:
                      'Low Stock',

                  value:
                      provider
                          .lowStockProducts
                          .length
                          .toString(),

                  icon:
                      Icons.warning,
                ),

                const SizedBox(
                  width: 20,
                ),

                dashboardCard(
                  title:
                      'Categories',

                  value:
                      provider
                          .categories
                          .where(
                            (e) =>
                                e !=
                                'All',
                          )
                          .length
                          .toString(),

                  icon:
                      Icons.category,
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),

            TextField(
              controller:
                  searchController,

              onChanged:
                  provider
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

            Expanded(
              child:
                  provider.products
                          .isEmpty

                      ? const Center(
                          child:
                              Text(
                            'No products available',
                          ),
                        )

                      : GridView.builder(

                          itemCount:
                              provider
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
                                0.78,
                          ),

                          itemBuilder:
                              (
                                context,
                                index,
                              ) {

                            final product =
                                provider
                                        .products[
                                    index];

                            return Container(
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
                                        Colors.black.withOpacity(
                                      0.05,
                                    ),

                                    blurRadius:
                                        10,
                                  ),
                                ],
                              ),

                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,

                                children: [

                                  Expanded(
                                    child:
                                        Stack(
                                      children: [

                                        ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                            top:
                                                Radius.circular(
                                              24,
                                            ),
                                          ),

                                          child:
                                              product.imageBase64.isEmpty

                                                  ? Container(
                                                      width:
                                                          double.infinity,

                                                      color:
                                                          Colors.grey.shade300,

                                                      child:
                                                          const Center(
                                                        child:
                                                            Icon(
                                                          Icons.image,
                                                          size:
                                                              60,
                                                        ),
                                                      ),
                                                    )

                                                  : Image.memory(
                                                      base64Decode(
                                                        product.imageBase64,
                                                      ),

                                                      width:
                                                          double.infinity,

                                                      fit:
                                                          BoxFit.cover,
                                                    ),
                                        ),

                                        Positioned(
                                          top: 10,
                                          left: 10,

                                          child:
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
                                                  Colors.black.withOpacity(
                                                0.7,
                                              ),

                                              borderRadius:
                                                  BorderRadius.circular(
                                                20,
                                              ),
                                            ),

                                            child:
                                                Text(
                                              product.category,

                                              style:
                                                  const TextStyle(
                                                color:
                                                    Colors.white,

                                                fontSize:
                                                    11,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding:
                                        const EdgeInsets.all(
                                      12,
                                    ),

                                    child:
                                        Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,

                                      children: [

                                        Text(
                                          product
                                              .name,

                                          maxLines:
                                              1,

                                          overflow:
                                              TextOverflow.ellipsis,

                                          style:
                                              const TextStyle(
                                            fontSize:
                                                16,

                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(
                                          height:
                                              6,
                                        ),

                                        Text(
                                          AppFormat.currency(
                                            product.price,
                                          ),

                                          style:
                                              const TextStyle(
                                            fontWeight:
                                                FontWeight.bold,

                                            color:
                                                Colors.green,
                                          ),
                                        ),

                                        const SizedBox(
                                          height:
                                              8,
                                        ),

                                        Text(
                                          'Stock: ${product.stock}',
                                        ),

                                        const SizedBox(
                                          height:
                                              12,
                                        ),

                                        Row(
                                          children: [

                                            Expanded(
                                              child:
                                                  SizedBox(
                                                height:
                                                    36,

                                                child:
                                                    ElevatedButton(
                                                  onPressed:
                                                      () {

                                                    showProductDialog(
                                                      product:
                                                          product,
                                                    );
                                                  },

                                                  child:
                                                      const Text(
                                                    'Edit',

                                                    style:
                                                        TextStyle(
                                                      fontSize:
                                                          11,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),

                                            const SizedBox(
                                              width:
                                                  6,
                                            ),

                                            Expanded(
                                              child:
                                                  SizedBox(
                                                height:
                                                    36,

                                                child:
                                                    ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.orange,
                                                  ),

                                                  onPressed:
                                                      () {

                                                    addStock(
                                                      product,
                                                    );
                                                  },

                                                  child:
                                                      const Text(
                                                    'Stock',

                                                    style:
                                                        TextStyle(
                                                      fontSize:
                                                          11,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),

                                            const SizedBox(
                                              width:
                                                  6,
                                            ),

                                            Expanded(
                                              child:
                                                  SizedBox(
                                                height:
                                                    36,

                                                child:
                                                    ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.red,
                                                  ),

                                                  onPressed:
                                                      () {

                                                    deleteProduct(
                                                      product,
                                                    );
                                                  },

                                                  child:
                                                      const Text(
                                                    'Delete',

                                                    style:
                                                        TextStyle(
                                                      fontSize:
                                                          11,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dashboardCard({
    required String title,
    required String value,
    required IconData icon,
  }) {

    return Expanded(
      child: Container(
        padding:
            const EdgeInsets.all(
          18,
        ),

        decoration:
            BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.circular(
            22,
          ),

          boxShadow: [

            BoxShadow(
              color:
                  Colors.black.withOpacity(
                0.04,
              ),

              blurRadius: 10,
            ),
          ],
        ),

        child: Column(
          children: [

            Icon(
              icon,
              size: 38,
            ),

            const SizedBox(
              height: 12,
            ),

            Text(
              value,

              style:
                  const TextStyle(
                fontSize: 24,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 6,
            ),

            Text(
              title,
            ),
          ],
        ),
      ),
    );
  }
}