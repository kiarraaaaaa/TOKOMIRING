// lib/screens/admin/admin_dashboard_screen.dart

import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../core/utils/app_format.dart';

import '../../models/product_model.dart';

import '../../providers/product_provider.dart';

import '../../services/storage_service.dart';

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
  final StorageService _storageService =
      StorageService();

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
  // ADD PRODUCT
  // =====================================================

  Future<void> showAddProductDialog() async {
    final nameController =
        TextEditingController();

    final descriptionController =
        TextEditingController();

    final priceController =
        TextEditingController();

    final stockController =
        TextEditingController();

    String selectedCategory =
        'Food';

    Uint8List? imageBytes;

    String? imageName;

    await showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (
            context,
            setStateDialog,
          ) {
            return AlertDialog(
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                  24,
                ),
              ),

              title: const Text(
                'Add Product',
              ),

              content: SizedBox(
                width: 500,

                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize:
                        MainAxisSize.min,

                    children: [
                      // =====================
                      // IMAGE PICKER
                      // =====================

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
                            imageBytes =
                                result
                                    .files
                                    .first
                                    .bytes;

                            imageName =
                                result
                                    .files
                                    .first
                                    .name;

                            setStateDialog(
                              () {},
                            );
                          }
                        },

                        child: Container(
                          height: 180,

                          width:
                              double.infinity,

                          decoration:
                              BoxDecoration(
                            color: Colors
                                .grey
                                .shade200,

                            borderRadius:
                                BorderRadius.circular(
                              20,
                            ),
                          ),

                          child:
                              imageBytes ==
                                      null
                                  ? const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,

                                      children: [
                                        Icon(
                                          Icons
                                              .image,
                                          size:
                                              60,
                                        ),

                                        SizedBox(
                                          height:
                                              10,
                                        ),

                                        Text(
                                          'Upload Product Image',
                                        ),
                                      ],
                                    )
                                  : ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(
                                        20,
                                      ),

                                      child:
                                          Image.memory(
                                        imageBytes!,

                                        fit: BoxFit
                                            .cover,
                                      ),
                                    ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
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
                        height: 15,
                      ),

                      TextField(
                        controller:
                            descriptionController,

                        maxLines: 3,

                        decoration:
                            const InputDecoration(
                          labelText:
                              'Description',
                        ),
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      DropdownButtonFormField<
                          String>(
                        value:
                            selectedCategory,

                        items: [
                          'Food',
                          'Drinks',
                          'Snacks',
                          'Electronics',
                          'Household',
                          'Others',
                        ]
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
                          selectedCategory =
                              value!;
                        },

                        decoration:
                            const InputDecoration(
                          labelText:
                              'Category',
                        ),
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      TextField(
                        controller:
                            priceController,

                        keyboardType:
                            TextInputType
                                .number,

                        decoration:
                            const InputDecoration(
                          labelText:
                              'Price',
                        ),
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      TextField(
                        controller:
                            stockController,

                        keyboardType:
                            TextInputType
                                .number,

                        decoration:
                            const InputDecoration(
                          labelText:
                              'Stock',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },

                  child: const Text(
                    'Cancel',
                  ),
                ),

                ElevatedButton(
                  onPressed: () async {
                    if (nameController
                            .text
                            .isEmpty ||
                        priceController
                            .text
                            .isEmpty ||
                        stockController
                            .text
                            .isEmpty ||
                        imageBytes ==
                            null) {
                      return;
                    }

                    final provider =
                        Provider.of<
                            ProductProvider>(
                      context,
                      listen: false,
                    );

                    // =====================
                    // UPLOAD IMAGE
                    // =====================

                    final imageUrl =
                        await _storageService
                            .uploadWebImage(
                      imageBytes:
                          imageBytes!,

                      fileName:
                          imageName ??
                              DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                    );

                    // =====================
                    // CREATE PRODUCT
                    // =====================

                    final product =
                        ProductModel(
                      id:
                          const Uuid()
                              .v4(),

                      name:
                          nameController
                              .text,

                      description:
                          descriptionController
                              .text,

                      category:
                          selectedCategory,

                      imageUrl:
                          imageUrl,

                      price: double.parse(
                        priceController
                            .text,
                      ),

                      stock: int.parse(
                        stockController
                            .text,
                      ),

                      isAvailable:
                          true,

                      isPopular:
                          false,

                      sold: 0,

                      createdAt:
                          DateTime.now(),
                    );

                    await provider
                        .addProduct(
                      product,
                    );

                    if (!mounted) {
                      return;
                    }

                    Navigator.pop(
                      context,
                    );

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Product added successfully',
                        ),
                      ),
                    );
                  },

                  child: const Text(
                    'Add Product',
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // =====================================================
  // UPDATE STOCK
  // =====================================================

  Future<void> showStockDialog(
    ProductModel product,
  ) async {
    final controller =
        TextEditingController(
      text: product.stock.toString(),
    );

    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text(
            'Update Stock',
          ),

          content: TextField(
            controller: controller,

            keyboardType:
                TextInputType.number,

            decoration:
                const InputDecoration(
              labelText: 'Stock',
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },

              child: const Text(
                'Cancel',
              ),
            ),

            ElevatedButton(
              onPressed: () async {
                await Provider.of<
                    ProductProvider>(
                  context,
                  listen: false,
                ).updateStock(
                  productId:
                      product.id,

                  stock: int.parse(
                    controller.text,
                  ),
                );

                if (!mounted) {
                  return;
                }

                Navigator.pop(
                  context,
                );
              },

              child: const Text(
                'Save',
              ),
            ),
          ],
        );
      },
    );
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<ProductProvider>(
      context,
    );

    return Scaffold(
      backgroundColor:
          const Color(0xffF1F5F9),

      // =========================================
      // FLOATING BUTTON
      // =========================================

      floatingActionButton:
          FloatingActionButton.extended(
        backgroundColor:
            Colors.blue,

        onPressed: () async {
          await showAddProductDialog();
        },

        icon: const Icon(
          Icons.add,
        ),

        label: const Text(
          'Add Product',
        ),
      ),

      // =========================================
      // APPBAR
      // =========================================

      appBar: AppBar(
        elevation: 0,

        backgroundColor:
            Colors.white,

        foregroundColor:
            Colors.black,

        title: const Text(
          'Admin Product Dashboard',
          style: TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {
              provider
                  .initializeProducts();
            },

            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),

      // =========================================
      // BODY
      // =========================================

      body: Padding(
        padding:
            const EdgeInsets.all(20),

        child: Column(
          children: [
            // =================================
            // DASHBOARD CARDS
            // =================================

            Row(
              children: [
                dashboardCard(
                  title:
                      'Total Products',

                  value: provider
                      .products
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

                  value: provider
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

                  value: provider
                      .categories
                      .length
                      .toString(),

                  icon:
                      Icons.category,
                ),
              ],
            ),

            const SizedBox(
              height: 25,
            ),

            // =================================
            // PRODUCT LIST
            // =================================

            Expanded(
              child: provider
                      .isLoading
                  ? const Center(
                      child:
                          CircularProgressIndicator(),
                    )
                  : provider.products.isEmpty
                      ? const Center(
                          child: Text(
                            'No products available',
                          ),
                        )
                      : ListView.builder(
                          itemCount:
                              provider
                                  .products
                                  .length,

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
                              margin:
                                  const EdgeInsets
                                      .only(
                                bottom:
                                    15,
                              ),

                              padding:
                                  const EdgeInsets
                                      .all(
                                15,
                              ),

                              decoration:
                                  BoxDecoration(
                                color: Colors
                                    .white,

                                borderRadius:
                                    BorderRadius.circular(
                                  20,
                                ),
                              ),

                              child: Row(
                                children: [
                                  // ===================
                                  // IMAGE
                                  // ===================

                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(
                                      15,
                                    ),

                                    child:
                                        Image.network(
                                      product
                                          .imageUrl,

                                      width:
                                          90,

                                      height:
                                          90,

                                      fit: BoxFit
                                          .cover,

                                      errorBuilder:
                                          (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return Container(
                                          width:
                                              90,

                                          height:
                                              90,

                                          color: Colors
                                              .grey
                                              .shade300,

                                          child:
                                              const Icon(
                                            Icons
                                                .image,
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                  const SizedBox(
                                    width:
                                        20,
                                  ),

                                  // ===================
                                  // INFO
                                  // ===================

                                  Expanded(
                                    child:
                                        Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,

                                      children: [
                                        Text(
                                          product
                                              .name,

                                          style:
                                              const TextStyle(
                                            fontSize:
                                                20,

                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(
                                          height:
                                              5,
                                        ),

                                        Text(
                                          product
                                              .category,
                                        ),

                                        const SizedBox(
                                          height:
                                              8,
                                        ),

                                        Text(
                                          AppFormat.currency(
                                            product
                                                .price,
                                          ),

                                          style:
                                              const TextStyle(
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // ===================
                                  // STOCK
                                  // ===================

                                  Column(
                                    children: [
                                      const Text(
                                        'Stock',
                                      ),

                                      const SizedBox(
                                        height:
                                            8,
                                      ),

                                      Text(
                                        product
                                            .stock
                                            .toString(),

                                        style:
                                            const TextStyle(
                                          fontSize:
                                              24,

                                          fontWeight:
                                              FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    width:
                                        20,
                                  ),

                                  // ===================
                                  // ACTIONS
                                  // ===================

                                  Column(
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed:
                                            () {
                                          showStockDialog(
                                            product,
                                          );
                                        },

                                        icon:
                                            const Icon(
                                          Icons
                                              .edit,
                                        ),

                                        label:
                                            const Text(
                                          'Edit Stock',
                                        ),
                                      ),

                                      const SizedBox(
                                        height:
                                            10,
                                      ),

                                      ElevatedButton.icon(
                                        style:
                                            ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.red,
                                        ),

                                        onPressed:
                                            () async {
                                          await provider
                                              .deleteProduct(
                                            product
                                                .id,
                                          );
                                        },

                                        icon:
                                            const Icon(
                                          Icons
                                              .delete,
                                        ),

                                        label:
                                            const Text(
                                          'Delete',
                                        ),
                                      ),
                                    ],
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

  // =====================================================
  // CARD
  // =====================================================

  Widget dashboardCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        padding:
            const EdgeInsets.all(20),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.circular(
            25,
          ),
        ),

        child: Column(
          children: [
            Icon(
              icon,
              size: 45,
            ),

            const SizedBox(
              height: 15,
            ),

            Text(
              value,

              style: const TextStyle(
                fontSize: 28,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            Text(title),
          ],
        ),
      ),
    );
  }
}