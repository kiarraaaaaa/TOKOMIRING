// =====================================================
// FULL FIX FINAL
// lib/screens/admin/admin_product_screen.dart
// FIX:
// ✅ CATEGORY SELECTED BUTTON
// ✅ FOOD / DRINKS / SNACKS / ELECTRONICS
// ✅ DROPDOWN CATEGORY
// ✅ IMAGE PICKER
// ✅ BASE64 IMAGE
// ✅ EDIT PRODUCT
// ✅ DELETE PRODUCT
// =====================================================

import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';
import '../../models/product_model.dart';

import '../../core/utils/app_format.dart';

class AdminProductScreen
    extends StatefulWidget {

  const AdminProductScreen({
    super.key,
  });

  @override
  State<AdminProductScreen>
      createState() =>
          _AdminProductScreenState();
}

class _AdminProductScreenState
    extends State<AdminProductScreen> {

  final TextEditingController
      _searchController =
          TextEditingController();

  String searchKeyword = '';

  final List<String> categories = [

    'Food',

    'Drinks',

    'Snacks',

    'Electronics',

    'Household',

    'Others',
  ];

  @override
  void initState() {

    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {

      Provider.of<ProductProvider>(
        context,
        listen: false,
      ).initializeProducts();
    });
  }

  @override
  void dispose() {

    _searchController.dispose();

    super.dispose();
  }

  // =====================================================
  // FILTER
  // =====================================================

  List<ProductModel> filterProducts(
    List<ProductModel> products,
  ) {

    if (searchKeyword.isEmpty) {
      return products;
    }

    return products.where(
      (
        product,
      ) {

        return product.name
                .toLowerCase()
                .contains(
                  searchKeyword
                      .toLowerCase(),
                ) ||

            product.category
                .toLowerCase()
                .contains(
                  searchKeyword
                      .toLowerCase(),
                );
      },
    ).toList();
  }

  // =====================================================
  // DELETE
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
  // PICK IMAGE
  // =====================================================

  Future<String?> pickImageBase64()
  async {

    FilePickerResult? result =
        await FilePicker.platform
            .pickFiles(

      type: FileType.image,

      withData: true,
    );

    if (result == null) {
      return null;
    }

    Uint8List? bytes =
        result.files.first.bytes;

    if (bytes == null) {
      return null;
    }

    return base64Encode(
      bytes,
    );
  }

  // =====================================================
  // DIALOG
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
      text:
          product?.name ?? '',
    );

    final priceController =
        TextEditingController(
      text:
          product != null
              ? product.price
                  .toString()
              : '',
    );

    final stockController =
        TextEditingController(
      text:
          product != null
              ? product.stock
                  .toString()
              : '',
    );

    String selectedCategory =
        product?.category ??
            categories.first;

    String imageBase64 =
        product?.imageBase64 ??
            '';

    await showDialog(

      context: context,

      builder: (_) {

        return StatefulBuilder(

          builder:
              (
                context,
                setState,
              ) {

            return Dialog(

              shape:
                  RoundedRectangleBorder(

                borderRadius:
                    BorderRadius.circular(
                  24,
                ),
              ),

              child:
                  SingleChildScrollView(

                padding:
                    const EdgeInsets.all(
                  24,
                ),

                child:
                    SizedBox(

                  width: 450,

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

                          fontSize: 24,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 24,
                      ),

                      // =================================
                      // IMAGE
                      // =================================

                      InkWell(

                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),

                        onTap: () async {

                          final picked =
                              await pickImageBase64();

                          if (picked ==
                              null) {
                            return;
                          }

                          setState(() {

                            imageBase64 =
                                picked;
                          });
                        },

                        child: Container(

                          width:
                              double.infinity,

                          height: 220,

                          decoration:
                              BoxDecoration(

                            color:
                                Colors.grey
                                    .shade100,

                            borderRadius:
                                BorderRadius.circular(
                              20,
                            ),
                          ),

                          child:

                              imageBase64
                                      .isNotEmpty

                                  ? ClipRRect(

                                      borderRadius:
                                          BorderRadius.circular(
                                        20,
                                      ),

                                      child: Image.memory(

                                        base64Decode(
                                          imageBase64,
                                        ),

                                        fit:
                                            BoxFit.cover,
                                      ),
                                    )

                                  : Column(

                                      mainAxisAlignment:
                                          MainAxisAlignment.center,

                                      children: [

                                        Icon(

                                          Icons
                                              .add_photo_alternate,

                                          size: 60,

                                          color:
                                              Colors.grey
                                                  .shade500,
                                        ),

                                        const SizedBox(
                                          height:
                                              12,
                                        ),

                                        Text(

                                          'Click to upload image',

                                          style:
                                              TextStyle(

                                            color:
                                                Colors.grey
                                                    .shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                        ),
                      ),

                      const SizedBox(
                        height: 24,
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
                        height: 16,
                      ),

                      // =================================
                      // CATEGORY DROPDOWN
                      // =================================

                      DropdownButtonFormField<String>(

                        value:
                            selectedCategory,

                        decoration:
                            const InputDecoration(
                          labelText:
                              'Category',
                        ),

                        borderRadius:
                            BorderRadius.circular(
                          18,
                        ),

                        items:
                            categories.map(
                          (
                            category,
                          ) {

                            return DropdownMenuItem(

                              value:
                                  category,

                              child:
                                  Text(
                                category,
                              ),
                            );
                          },
                        ).toList(),

                        onChanged:
                            (
                              value,
                            ) {

                          if (value ==
                              null) {
                            return;
                          }

                          setState(() {

                            selectedCategory =
                                value;
                          });
                        },
                      ),

                      const SizedBox(
                        height: 16,
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
                        height: 16,
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
                        height: 28,
                      ),

                      SizedBox(

                        width:
                            double.infinity,

                        height: 52,

                        child:
                            ElevatedButton(

                          style:
                              ElevatedButton.styleFrom(

                            backgroundColor:
                                Colors.blue,
                          ),

                          onPressed:
                              () async {

                            final newProduct =
                                ProductModel(

                              id:
                                  product?.id ??

                                      DateTime.now()
                                          .millisecondsSinceEpoch
                                          .toString(),

                              name:
                                  nameController
                                      .text,

                              description:
                                  '',

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

                            if (product ==
                                null) {

                              await provider
                                  .addProduct(
                                newProduct,
                              );

                            } else {

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
                          },

                          child:
                              Text(

                            product == null

                                ? 'Add Product'

                                : 'Save Changes',

                            style:
                                const TextStyle(
                              color:
                                  Colors.white,
                            ),
                          ),
                        ),
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
  // BUILD
  // =====================================================

  @override
  Widget build(
    BuildContext context,
  ) {

    final provider =
        Provider.of<ProductProvider>(
      context,
    );

    final products =
        filterProducts(
      provider.products,
    );

    final width =
        MediaQuery.of(context)
            .size
            .width;

    int crossAxisCount = 4;

    if (width < 700) {

      crossAxisCount = 1;

    } else if (width < 1100) {

      crossAxisCount = 2;

    } else if (width < 1500) {

      crossAxisCount = 3;
    }

    return Container(

      color:
          const Color(
        0xffF8FAFC,
      ),

      child:
          SingleChildScrollView(

        padding:
            const EdgeInsets.all(
          24,
        ),

        child:
            Column(
          crossAxisAlignment:
              CrossAxisAlignment
                  .start,

          children: [

            Wrap(

              spacing: 20,

              runSpacing: 20,

              alignment:
                  WrapAlignment
                      .spaceBetween,

              crossAxisAlignment:
                  WrapCrossAlignment
                      .center,

              children: [

                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    Text(

                      'Product Management',

                      style:
                          TextStyle(

                        fontSize:

                            width < 700
                                ? 28
                                : 40,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    Text(

                      'Manage ecommerce products.',

                      style:
                          TextStyle(

                        color:
                            Colors.grey
                                .shade600,
                      ),
                    ),
                  ],
                ),

                SizedBox(

                  height: 48,

                  child:
                      ElevatedButton.icon(

                    style:
                        ElevatedButton.styleFrom(

                      backgroundColor:
                          Colors.blue,
                    ),

                    onPressed: () {

                      showProductDialog();
                    },

                    icon:
                        const Icon(
                      Icons.add,
                      color:
                          Colors.white,
                    ),

                    label:
                        const Text(

                      'Add Product',

                      style:
                          TextStyle(
                        color:
                            Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 24,
            ),

            Container(

              constraints:
                  const BoxConstraints(
                maxWidth: 450,
              ),

              decoration:
                  BoxDecoration(

                color:
                    Colors.white,

                borderRadius:
                    BorderRadius.circular(
                  18,
                ),
              ),

              child:
                  TextField(

                controller:
                    _searchController,

                onChanged:
                    (
                      value,
                    ) {

                  setState(() {

                    searchKeyword =
                        value;
                  });
                },

                decoration:
                    InputDecoration(

                  hintText:
                      'Search product...',

                  prefixIcon:
                      const Icon(
                    Icons.search,
                  ),

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
            ),

            const SizedBox(
              height: 28,
            ),

            GridView.builder(

              shrinkWrap: true,

              physics:
                  const NeverScrollableScrollPhysics(),

              itemCount:
                  products.length,

              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(

                crossAxisCount:
                    crossAxisCount,

                crossAxisSpacing:
                    18,

                mainAxisSpacing:
                    18,

                mainAxisExtent:
                    500,
              ),

              itemBuilder:
                  (
                    context,
                    index,
                  ) {

                return productCard(
                  products[index],
                );
              },
            ),

            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  Widget productCard(
    ProductModel product,
  ) {

    return Container(

      decoration:
          BoxDecoration(

        color:
            Colors.white,

        borderRadius:
            BorderRadius.circular(
          24,
        ),
      ),

      child:
          Column(
        crossAxisAlignment:
            CrossAxisAlignment
                .start,

        children: [

          SizedBox(

            height: 200,

            width:
                double.infinity,

            child:
                ClipRRect(

              borderRadius:
                  const BorderRadius.vertical(
                top:
                    Radius.circular(
                  24,
                ),
              ),

              child:

                  product.imageBase64
                          .isNotEmpty

                      ? Image.memory(

                          base64Decode(
                            product
                                .imageBase64,
                          ),

                          fit:
                              BoxFit.cover,

                          errorBuilder:
                              (
                            context,
                            error,
                            stackTrace,
                          ) {

                            return fallbackImage();
                          },
                        )

                      : fallbackImage(),
            ),
          ),

          Expanded(

            child:
                Padding(

              padding:
                  const EdgeInsets.all(
                16,
              ),

              child:
                  Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  Text(

                    product.name,

                    maxLines: 1,

                    overflow:
                        TextOverflow
                            .ellipsis,

                    style:
                        const TextStyle(

                      fontSize: 18,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 6,
                  ),

                  Text(
                    product.category,
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  Text(

                    AppFormat.currency(
                      product.price,
                    ),

                    style:
                        const TextStyle(

                      fontSize: 20,

                      fontWeight:
                          FontWeight.bold,

                      color:
                          Colors.green,
                    ),
                  ),

                  const SizedBox(
                    height: 14,
                  ),

                  Container(

                    width:
                        double.infinity,

                    padding:
                        const EdgeInsets.symmetric(

                      vertical: 10,
                    ),

                    decoration:
                        BoxDecoration(

                      color:
                          Colors.green
                              .withOpacity(
                        0.1,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),
                    ),

                    child:
                        Text(

                      'Stock: ${product.stock}',

                      textAlign:
                          TextAlign.center,

                      style:
                          const TextStyle(

                        fontWeight:
                            FontWeight.bold,

                        color:
                            Colors.green,
                      ),
                    ),
                  ),

                  const Spacer(),

                  Row(
                    children: [

                      Expanded(

                        child:
                            SizedBox(

                          height: 42,

                          child:
                              ElevatedButton(

                            style:
                                ElevatedButton.styleFrom(

                              backgroundColor:
                                  Colors.blue,
                            ),

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
                                color:
                                    Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 10,
                      ),

                      Expanded(

                        child:
                            SizedBox(

                          height: 42,

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
                                color:
                                    Colors.white,
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
          ),
        ],
      ),
    );
  }

  Widget fallbackImage() {

    return Container(

      color:
          Colors.grey
              .shade200,

      child:
          Center(

        child: Icon(

          Icons
              .image_not_supported,

          size: 60,

          color:
              Colors.grey
                  .shade500,
        ),
      ),
    );
  }
}