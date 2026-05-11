// lib/screens/user/checkout_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_format.dart';

import '../../models/order_model.dart';

import '../../providers/auth_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/order_provider.dart';

class CheckoutScreen
    extends StatefulWidget {

  const CheckoutScreen({
    super.key,
  });

  @override
  State<CheckoutScreen>
      createState() =>
          _CheckoutScreenState();
}

class _CheckoutScreenState
    extends State<CheckoutScreen> {

  final GlobalKey<FormState>
      _formKey =
      GlobalKey<FormState>();

  final nameController =
      TextEditingController();

  final phoneController =
      TextEditingController();

  final addressController =
      TextEditingController();

  String paymentMethod =
      'Cash';

  @override
  void initState() {

    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback(
      (_) {

        final authProvider =
            Provider.of<AuthProvider>(
          context,
          listen: false,
        );

        final user =
            authProvider.user;

        if (user != null) {

          nameController.text =
              user.name;

          phoneController.text =
              user.phone;

          addressController.text =
              user.address;
        }
      },
    );
  }

  // =====================================================
  // CREATE ORDER
  // =====================================================

  Future<void> createOrder()
      async {

    if (!_formKey.currentState!
        .validate()) {

      return;
    }

    final cartProvider =
        Provider.of<CartProvider>(
      context,
      listen: false,
    );

    final authProvider =
        Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    final orderProvider =
        Provider.of<OrderProvider>(
      context,
      listen: false,
    );

    final order =
        OrderModel(

      orderId: '',

      userId:
          authProvider
                  .user
                  ?.uid ??
              '',

      customerName:
          nameController.text
              .trim(),

      customerPhone:
          phoneController.text
              .trim(),

      address:
          addressController.text
              .trim(),

      items:
          cartProvider.items.map(
        (item) {

          return OrderItemModel(

            productId:
                item.product.id,

            productName:
                item.product.name,

            productImage:
                item.product.imageBase64,

            productPrice:
                item.product.price,

            quantity:
                item.quantity,

            subtotal:
                item.subtotal,
          );
        },
      ).toList(),

      totalPrice:
          cartProvider.totalPrice,

      totalItems:
          cartProvider.totalItems,

      paymentMethod:
          paymentMethod,

      paymentProof:
          '',

      status:
          'Waiting Admin Validation',

      isValidated:
          false,

      createdAt:
          DateTime.now(),

      updatedAt:
          DateTime.now(),
    );

    final success =
        await orderProvider
            .createOrder(
      order,
    );

    if (!mounted) {
      return;
    }

    // ===================================================
    // SUCCESS
    // ===================================================

    if (success) {

      cartProvider.clearCart();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(

        SnackBar(

          backgroundColor:
              AppColors.success,

          content: const Text(
            'Order created successfully',
          ),
        ),
      );

      Navigator.pop(
        context,
      );
    }

    // ===================================================
    // FAILED
    // ===================================================

    else {

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(

        SnackBar(

          backgroundColor:
              AppColors.danger,

          content: Text(

            orderProvider
                    .errorMessage ??
                'Failed to create order',
          ),
        ),
      );
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    final cartProvider =
        Provider.of<CartProvider>(
      context,
    );

    final orderProvider =
        Provider.of<OrderProvider>(
      context,
    );

    return Scaffold(

      backgroundColor:
          AppColors.background,

      appBar: AppBar(

        elevation: 0,

        backgroundColor:
            Colors.white,

        foregroundColor:
            Colors.black,

        centerTitle: true,

        title: const Text(

          'Checkout',

          style: TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: Form(

        key: _formKey,

        child: Stack(

          children: [

            // =============================================
            // CONTENT
            // =============================================

            Padding(

              padding:
                  const EdgeInsets.only(
                bottom: 160,
              ),

              child: SingleChildScrollView(

                padding:
                    const EdgeInsets.all(
                  20,
                ),

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    // =====================================
                    // CUSTOMER INFO
                    // =====================================

                    const Text(

                      'Customer Information',

                      style: TextStyle(

                        fontSize: 22,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    TextFormField(

                      controller:
                          nameController,

                      decoration:
                          const InputDecoration(

                        labelText:
                            'Customer Name',

                        prefixIcon:
                            Icon(
                          Icons.person,
                        ),
                      ),

                      validator:
                          (value) {

                        if (value ==
                                null ||
                            value
                                .trim()
                                .isEmpty) {

                          return 'Name is required';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    TextFormField(

                      controller:
                          phoneController,

                      keyboardType:
                          TextInputType
                              .phone,

                      decoration:
                          const InputDecoration(

                        labelText:
                            'Phone Number',

                        prefixIcon:
                            Icon(
                          Icons.phone,
                        ),
                      ),

                      validator:
                          (value) {

                        if (value ==
                                null ||
                            value
                                .trim()
                                .isEmpty) {

                          return 'Phone number is required';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    TextFormField(

                      controller:
                          addressController,

                      maxLines: 3,

                      decoration:
                          const InputDecoration(

                        labelText:
                            'Address',

                        prefixIcon:
                            Icon(
                          Icons.location_on,
                        ),
                      ),

                      validator:
                          (value) {

                        if (value ==
                                null ||
                            value
                                .trim()
                                .isEmpty) {

                          return 'Address is required';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    // =====================================
                    // PAYMENT
                    // =====================================

                    const Text(

                      'Payment Method',

                      style: TextStyle(

                        fontSize: 22,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    DropdownButtonFormField<
                        String>(

                      value:
                          paymentMethod,

                      decoration:
                          const InputDecoration(

                        prefixIcon:
                            Icon(
                          Icons.payment,
                        ),
                      ),

                      items: const [

                        DropdownMenuItem(

                          value:
                              'Cash',

                          child:
                              Text(
                            'Cash',
                          ),
                        ),

                        DropdownMenuItem(

                          value:
                              'Bank Transfer',

                          child:
                              Text(
                            'Bank Transfer',
                          ),
                        ),
                      ],

                      onChanged: (
                        value,
                      ) {

                        if (value !=
                            null) {

                          setState(() {

                            paymentMethod =
                                value;
                          });
                        }
                      },
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    // =====================================
                    // ORDER SUMMARY
                    // =====================================

                    const Text(

                      'Order Summary',

                      style: TextStyle(

                        fontSize: 22,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Container(

                      padding:
                          const EdgeInsets.all(
                        20,
                      ),

                      decoration:
                          BoxDecoration(

                        color:
                            Colors.white,

                        borderRadius:
                            BorderRadius.circular(
                          24,
                        ),
                      ),

                      child: Column(

                        children: [

                          ...cartProvider
                              .items
                              .map(
                            (item) {

                              return Padding(

                                padding:
                                    const EdgeInsets.only(
                                  bottom: 18,
                                ),

                                child: Row(

                                  children: [

                                    Expanded(

                                      child: Column(

                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,

                                        children: [

                                          Text(

                                            item.product.name,

                                            style:
                                                const TextStyle(
                                              fontWeight:
                                                  FontWeight.bold,
                                            ),
                                          ),

                                          const SizedBox(
                                            height:
                                                4,
                                          ),

                                          Text(
                                            '${item.quantity} x ${AppFormat.currency(item.product.price)}',
                                          ),
                                        ],
                                      ),
                                    ),

                                    Text(

                                      AppFormat.currency(
                                        item.subtotal,
                                      ),

                                      style:
                                          const TextStyle(
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // =============================================
            // BOTTOM CHECKOUT
            // =============================================

            Positioned(

              left: 20,

              right: 20,

              bottom: 20,

              child: Container(

                padding:
                    const EdgeInsets.all(
                  22,
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
                        0.08,
                      ),

                      blurRadius:
                          30,
                    ),
                  ],
                ),

                child: Column(

                  mainAxisSize:
                      MainAxisSize.min,

                  children: [

                    Row(

                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,

                      children: [

                        const Text(

                          'Total Price',

                          style: TextStyle(

                            fontSize: 18,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        Text(

                          AppFormat.currency(
                            cartProvider
                                .totalPrice,
                          ),

                          style:
                              const TextStyle(

                            fontSize: 24,

                            color:
                                AppColors.primary,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 22,
                    ),

                    SizedBox(

                      width:
                          double.infinity,

                      height: 58,

                      child:
                          ElevatedButton(

                        style:
                            ElevatedButton.styleFrom(

                          backgroundColor:
                              AppColors.primary,

                          foregroundColor:
                              Colors.white,

                          shape:
                              RoundedRectangleBorder(

                            borderRadius:
                                BorderRadius.circular(
                              18,
                            ),
                          ),
                        ),

                        onPressed:
                            orderProvider
                                    .isLoading

                                ? null

                                : createOrder,

                        child:
                            orderProvider
                                    .isLoading

                                ? const SizedBox(

                                    width: 24,

                                    height: 24,

                                    child:
                                        CircularProgressIndicator(

                                      color:
                                          Colors.white,

                                      strokeWidth:
                                          2,
                                    ),
                                  )

                                : const Text(

                                    'Create Order',

                                    style: TextStyle(

                                      fontSize:
                                          18,

                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                      ),
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

  @override
  void dispose() {

    nameController.dispose();

    phoneController.dispose();

    addressController.dispose();

    super.dispose();
  }
}