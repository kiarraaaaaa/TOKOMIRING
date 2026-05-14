// lib/screens/user/checkout_screen.dart

import 'dart:convert';

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
    extends State<CheckoutScreen>
    with
        SingleTickerProviderStateMixin {

  // =====================================================
  // FORM
  // =====================================================

  final GlobalKey<FormState>
      _formKey =
      GlobalKey<FormState>();

  final nameController =
      TextEditingController();

  final phoneController =
      TextEditingController();

  final addressController =
      TextEditingController();

  // =====================================================
  // PAYMENT
  // =====================================================

  String paymentMethod =
      'Cash';

  // =====================================================
  // ANIMATION
  // =====================================================

  late AnimationController
      _animationController;

  late Animation<double>
      _fadeAnimation;

  // =====================================================
  // INIT
  // =====================================================

  @override
  void initState() {

    super.initState();

    _animationController =
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
          _animationController,

      curve:
          Curves.easeOut,
    );

    _animationController
        .forward();

    WidgetsBinding.instance
        .addPostFrameCallback(
      (_) {

        final authProvider =
            context.read<
                AuthProvider>();

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
        context.read<
            CartProvider>();

    final authProvider =
        context.read<
            AuthProvider>();

    final orderProvider =
        context.read<
            OrderProvider>();

    // ===================================================
    // SAVE USER DATA REALTIME
    // ===================================================

    await authProvider
        .updateAddress(

      addressController.text
          .trim(),
    );

    await authProvider
        .updatePhone(

      phoneController.text
          .trim(),
    );

    // ===================================================
    // CREATE ORDER
    // ===================================================

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
                item.product
                    .imageBase64,

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

      completedAt:
          null,
    );

    // ===================================================
    // CREATE ORDER
    // ===================================================

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

        const SnackBar(

          backgroundColor:
              AppColors.success,

          content: Text(
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

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(
    BuildContext context,
  ) {

    final cartProvider =
        context.watch<
            CartProvider>();

    final orderProvider =
        context.watch<
            OrderProvider>();

    final authProvider =
        context.watch<
            AuthProvider>();

    final screenWidth =
        MediaQuery.of(context)
            .size
            .width;

    final isTablet =
        screenWidth >= 700;

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

        titleSpacing: 20,

        title: const Column(

          crossAxisAlignment:
              CrossAxisAlignment
                  .start,

          children: [

            Text(

              'Premium Checkout',

              style: TextStyle(

                color:
                    Colors.black,

                fontSize: 24,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            SizedBox(
              height: 2,
            ),

            Text(

              'Realtime marketplace checkout',

              style: TextStyle(

                color:
                    Colors.grey,

                fontSize: 13,
              ),
            ),
          ],
        ),
      ),

      body: FadeTransition(

        opacity:
            _fadeAnimation,

        child: Form(

          key: _formKey,

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Padding(

                padding:
                    const EdgeInsets.only(
                  bottom: 0,
                ),

                child:
                    SingleChildScrollView(

                  physics:
                      const BouncingScrollPhysics(),

                  padding:
                      const EdgeInsets.all(
                    20,
                  ),

                  child: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [

                      // =====================================
                      // PROFILE CARD
                      // =====================================

                      Container(

                        width:
                            double.infinity,

                        padding:
                            const EdgeInsets.all(
                          20,
                        ),

                        decoration:
                            BoxDecoration(

                          borderRadius:
                              BorderRadius.circular(
                            28,
                          ),

                          gradient:
                              const LinearGradient(

                            colors: [

                              Color(
                                0xff2563EB,
                              ),

                              Color(
                                0xff1D4ED8,
                              ),
                            ],
                          ),
                        ),

                        child: Row(

                          children: [

                            Container(

                              width: 60,

                              height: 60,

                              decoration:
                                  BoxDecoration(

                                color:
                                    Colors
                                        .white
                                        .withOpacity(
                                  0.2,
                                ),

                                shape:
                                    BoxShape.circle,
                              ),

                              child:
                                  authProvider
                                          .photoUrl
                                          .isNotEmpty

                                      ? ClipOval(

                                          child:
                                              Image.memory(

                                            base64Decode(
                                              authProvider
                                                  .photoUrl,
                                            ),

                                            fit:
                                                BoxFit.cover,
                                          ),
                                        )

                                      : const Icon(

                                          Icons.person,

                                          color:
                                              Colors
                                                  .white,

                                          size:
                                              30,
                                        ),
                            ),

                            const SizedBox(
                              width: 16,
                            ),

                            Expanded(

                              child: Column(

                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                children: [

                                  Text(

                                    authProvider
                                            .user
                                            ?.displayName ??

                                        'Member',

                                    overflow:
                                        TextOverflow
                                            .ellipsis,

                                    style:
                                        const TextStyle(

                                      color:
                                          Colors
                                              .white,

                                      fontSize:
                                          20,

                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(
                                    height:
                                        4,
                                  ),

                                  Text(

                                    authProvider
                                            .email,

                                    overflow:
                                        TextOverflow
                                            .ellipsis,

                                    style:
                                        TextStyle(

                                      color:
                                          Colors
                                              .white
                                              .withOpacity(
                                        0.9,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 28,
                      ),

                      const Text(

                        'Shipping Information',

                        style: TextStyle(

                          fontSize: 24,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      _buildInputField(

                        controller:
                            nameController,

                        label:
                            'Full Name',

                        icon:
                            Icons.person,
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      _buildInputField(

                        controller:
                            phoneController,

                        label:
                            'Phone Number',

                        icon:
                            Icons.phone,

                        keyboardType:
                            TextInputType
                                .phone,
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      _buildInputField(

                        controller:
                            addressController,

                        label:
                            'Shipping Address',

                        icon:
                            Icons.location_on,

                        minLines:
                            2,

                        maxLines:
                            3,
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      const Text(

                        'Payment Method',

                        style: TextStyle(

                          fontSize: 24,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      Wrap(

                        spacing: 16,

                        runSpacing: 16,

                        children: [

                          _buildPaymentCard(
                            'Cash',
                            Icons.payments,
                          ),

                          _buildPaymentCard(
                            'Bank Transfer',
                            Icons.account_balance,
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      Container(

                        width:
                            double.infinity,

                        padding:
                            const EdgeInsets.all(
                          18,
                        ),

                        decoration:
                            BoxDecoration(

                          color:
                              Colors.orange
                                  .withOpacity(
                            0.08,
                          ),

                          borderRadius:
                              BorderRadius.circular(
                            22,
                          ),
                        ),

                        child: Row(

                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            const Icon(

                              Icons.info_outline,

                              color:
                                  Colors.orange,
                            ),

                            const SizedBox(
                              width: 12,
                            ),

                            Expanded(

                              child: Text(

                                'Orders will be validated by admin before delivery processing.',

                                style: TextStyle(

                                  color:
                                      Colors
                                          .grey
                                          .shade800,

                                  height:
                                      1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      const Text(

                        'Order Summary',

                        style: TextStyle(

                          fontSize: 24,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      Container(

                        width:
                            double.infinity,

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
                            28,
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
                                    bottom:
                                        18,
                                  ),

                                  child: Row(

                                    children: [

                                      Container(

                                        width: 60,

                                        height: 60,

                                        decoration:
                                            BoxDecoration(

                                          borderRadius:
                                              BorderRadius.circular(
                                            18,
                                          ),
                                        ),

                                        child:
                                            ClipRRect(

                                          borderRadius:
                                              BorderRadius.circular(
                                            18,
                                          ),

                                          child:
                                              Image.memory(

                                            base64Decode(
                                              item.product.imageBase64,
                                            ),

                                            fit:
                                                BoxFit.cover,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(
                                        width:
                                            14,
                                      ),

                                      Expanded(

                                        child: Column(

                                          crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,

                                          children: [

                                            Text(

                                              item.product.name,

                                              maxLines:
                                                  2,

                                              overflow:
                                                  TextOverflow
                                                      .ellipsis,

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

                                      const SizedBox(
                                        width:
                                            12,
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

                      const SizedBox(
                        height: 24,
                      ),

                      Container(

                        width:
                            double.infinity,

                        padding:
                            const EdgeInsets.all(
                          20,
                        ),

                        decoration:
                            BoxDecoration(

                          color: Colors.white,

                          borderRadius:
                              BorderRadius.circular(
                            24,
                          ),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(
                                0.05,
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

                        child: Column(

                          children: [

                            _buildPriceRow(

                              title:
                                  'Subtotal',

                              value:
                                  AppFormat.currency(
                                cartProvider
                                    .totalPrice,
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            _buildPriceRow(

                              title:
                                  'Shipping',

                              value:
                                  'Free',
                            ),

                            const Padding(

                              padding:
                                  EdgeInsets.symmetric(
                                vertical:
                                    16,
                              ),

                              child: Divider(),
                            ),

                            Row(

                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,

                              children: [

                                const Text(

                                  'Grand Total',

                                  style:
                                      TextStyle(

                                    fontSize:
                                        18,

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

                                    fontSize:
                                        22,

                                    color:
                                        AppColors.primary,

                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 18,
                            ),

                            SizedBox(

                              width:
                                  double.infinity,

                              height: 54,

                              child:
                                  ElevatedButton(

                                style:
                                    ElevatedButton.styleFrom(

                                  backgroundColor:
                                      AppColors.primary,

                                  foregroundColor:
                                      Colors.white,

                                  elevation:
                                      0,

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

                                            width:
                                                24,

                                            height:
                                                24,

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

                                            style:
                                                TextStyle(

                                              fontSize:
                                                  16,

                                              fontWeight:
                                                  FontWeight.bold,
                                            ),
                                          ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // INPUT
  // =====================================================

  Widget _buildInputField({

    required TextEditingController
        controller,

    required String label,

    required IconData icon,

    TextInputType?
        keyboardType,

    int minLines = 1,

    int maxLines = 1,

  }) {

    return TextFormField(

      controller:
          controller,

      keyboardType:
          keyboardType,

      minLines:
          minLines,

      maxLines:
          maxLines,

      decoration:
          InputDecoration(

        labelText:
            label,

        prefixIcon:
            Icon(icon),

        filled:
            true,

        fillColor:
            Colors.white,

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

      validator:
          (value) {

        if (value == null ||
            value
                .trim()
                .isEmpty) {

          return '$label is required';
        }

        return null;
      },
    );
  }

  // =====================================================
  // PAYMENT CARD
  // =====================================================

  Widget _buildPaymentCard(
    String title,
    IconData icon,
  ) {

    final selected =
        paymentMethod ==
            title;

    return GestureDetector(

      onTap: () {

        setState(() {

          paymentMethod =
              title;
        });
      },

      child: AnimatedContainer(

        duration:
            const Duration(
          milliseconds:
              250,
        ),

        width: 170,

        padding:
            const EdgeInsets.all(
          18,
        ),

        decoration:
            BoxDecoration(

          color:
              selected

                  ? AppColors.primary
                      .withOpacity(
                    0.08,
                  )

                  : Colors.white,

          borderRadius:
              BorderRadius.circular(
            22,
          ),

          border: Border.all(

            color:
                selected

                    ? AppColors
                        .primary

                    : Colors
                        .grey
                        .shade200,

            width: 2,
          ),
        ),

        child: Column(

          children: [

            Icon(

              icon,

              size: 34,

              color:
                  selected

                      ? AppColors
                          .primary

                      : Colors
                          .grey,
            ),

            const SizedBox(
              height: 12,
            ),

            Text(

              title,

              textAlign:
                  TextAlign.center,

              style: TextStyle(

                fontWeight:
                    FontWeight.bold,

                color:
                    selected

                        ? AppColors
                            .primary

                        : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // PRICE ROW
  // =====================================================

  Widget _buildPriceRow({

    required String title,

    required String value,

  }) {

    return Row(

      mainAxisAlignment:
          MainAxisAlignment
              .spaceBetween,

      children: [

        Text(title),

        Text(

          value,

          style:
              const TextStyle(

            fontWeight:
                FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {

    _animationController
        .dispose();

    nameController.dispose();

    phoneController.dispose();

    addressController.dispose();

    super.dispose();
  }
}