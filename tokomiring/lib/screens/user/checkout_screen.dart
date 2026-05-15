// =====================================================
// lib/screens/user/checkout_screen.dart
// FINAL COMPACT PREMIUM RESPONSIVE VERSION
// =====================================================

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_format.dart';

import '../../models/order_model.dart';

import '../../providers/auth_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/order_provider.dart';
import '../../providers/product_provider.dart';

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
        milliseconds: 450,
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

  bool hasInvalidStock(

    ProductProvider
        productProvider,

    CartProvider
        cartProvider,
  ) {

    for (final item
        in cartProvider.items) {

      final product =
          productProvider
              .getProductById(
        item.product.id,
      );

      if (product == null) {
        return true;
      }

      if (product.stock <= 0) {
        return true;
      }

      if (item.quantity >
          product.stock) {
        return true;
      }
    }

    return false;
  }

  Future<void>
      createOrder()
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

    final productProvider =
        context.read<
            ProductProvider>();

    if (hasInvalidStock(

      productProvider,

      cartProvider,
    )) {

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(

        const SnackBar(

          backgroundColor:
              Colors.red,

          content: Text(

            'Some products exceed available stock',
          ),
        ),
      );

      return;
    }

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

    final success =
        await orderProvider
            .createOrder(
      order,
    );

    if (!mounted) {
      return;
    }

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
        context.watch<
            CartProvider>();

    final orderProvider =
        context.watch<
            OrderProvider>();

    final authProvider =
        context.watch<
            AuthProvider>();

    final productProvider =
        context.watch<
            ProductProvider>();

    final screenWidth =
        MediaQuery.of(context)
            .size
            .width;

    final isMobile =
        screenWidth < 700;

    final invalidStock =
        hasInvalidStock(

      productProvider,

      cartProvider,
    );

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

                fontSize: 18,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            SizedBox(
              height: 2,
            ),

            Text(

              'Modern compact checkout',

              style: TextStyle(

                color:
                    Colors.grey,

                fontSize: 11,
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

          child:
              SingleChildScrollView(

            physics:
                const BouncingScrollPhysics(),

            padding:
                EdgeInsets.all(
              isMobile ? 14 : 18,
            ),

            child: Center(

              child: ConstrainedBox(

                constraints:
                    const BoxConstraints(
                  maxWidth: 760,
                ),

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    if (invalidStock)

                      Container(

                        width:
                            double.infinity,

                        margin:
                            const EdgeInsets.only(
                          bottom: 16,
                        ),

                        padding:
                            const EdgeInsets.symmetric(

                          horizontal: 14,

                          vertical: 12,
                        ),

                        decoration:
                            BoxDecoration(

                          color:
                              Colors.red
                                  .withOpacity(
                            0.08,
                          ),

                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),
                        ),

                        child: const Row(

                          children: [

                            Icon(

                              Icons
                                  .warning_amber_rounded,

                              color:
                                  Colors.red,

                              size: 18,
                            ),

                            SizedBox(
                              width: 10,
                            ),

                            Expanded(

                              child: Text(

                                'Some products exceed available stock.',

                                style:
                                    TextStyle(

                                  color:
                                      Colors.red,

                                  fontSize: 12,

                                  fontWeight:
                                      FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    // =====================================
                    // PROFILE
                    // =====================================

                    Container(

                      width:
                          double.infinity,

                      padding:
                          EdgeInsets.all(
                        isMobile
                            ? 16
                            : 18,
                      ),

                      decoration:
                          BoxDecoration(

                        borderRadius:
                            BorderRadius.circular(
                          24,
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

                            width: 52,

                            height: 52,

                            decoration:
                                BoxDecoration(

                              color:
                                  Colors.white
                                      .withOpacity(
                                0.16,
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
                                            Colors.white,

                                        size:
                                            22,
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

                                Text(

                                  authProvider
                                          .user
                                          ?.displayName ??

                                      'Member',

                                  overflow:
                                      TextOverflow
                                          .ellipsis,

                                  style:
                                      TextStyle(

                                    color:
                                        Colors
                                            .white,

                                    fontSize:
                                        isMobile
                                            ? 16
                                            : 18,

                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(
                                  height: 3,
                                ),

                                Text(

                                  authProvider
                                      .email,

                                  overflow:
                                      TextOverflow
                                          .ellipsis,

                                  style:
                                      TextStyle(

                                    fontSize: 11,

                                    color:
                                        Colors
                                            .white
                                            .withOpacity(
                                      0.88,
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
                      height: 22,
                    ),

                    // =====================================
                    // SHIPPING
                    // =====================================

                    const Text(

                      'Shipping Information',

                      style: TextStyle(

                        fontSize: 20,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 14,
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
                      height: 12,
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
                      height: 12,
                    ),

                    _buildInputField(

                      controller:
                          addressController,

                      label:
                          'Shipping Address',

                      icon:
                          Icons.location_on,

                      minLines: 2,

                      maxLines: 3,
                    ),

                    const SizedBox(
                      height: 22,
                    ),

                    // =====================================
                    // PAYMENT
                    // =====================================

                    const Text(

                      'Payment Method',

                      style: TextStyle(

                        fontSize: 20,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 14,
                    ),

                    Wrap(

                      spacing: 12,

                      runSpacing: 12,

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
                      height: 20,
                    ),

                    // =====================================
                    // INFO BOX
                    // =====================================

                    Container(

                      width:
                          double.infinity,

                      padding:
                          const EdgeInsets.all(
                        14,
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
                          18,
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

                            size: 18,
                          ),

                          const SizedBox(
                            width: 10,
                          ),

                          Expanded(

                            child: Text(

                              'Orders will be validated before delivery process.',

                              style:
                                  TextStyle(

                                fontSize: 12,

                                color:
                                    Colors.grey
                                        .shade800,

                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    // =====================================
                    // SUMMARY TITLE
                    // =====================================

                    const Text(

                      'Order Summary',

                      style: TextStyle(

                        fontSize: 20,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 14,
                    ),

                    // =====================================
                    // SUMMARY CARD
                    // =====================================

                    Container(

                      width:
                          double.infinity,

                      padding:
                          EdgeInsets.all(
                        isMobile
                            ? 14
                            : 16,
                      ),

                      decoration:
                          BoxDecoration(

                        color:
                            Colors.white,

                        borderRadius:
                            BorderRadius.circular(
                          22,
                        ),

                        boxShadow: [

                          BoxShadow(

                            color:
                                Colors.black
                                    .withOpacity(
                              0.03,
                            ),

                            blurRadius: 12,

                            offset:
                                const Offset(
                              0,
                              6,
                            ),
                          ),
                        ],
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
                                      12,
                                ),

                                child: Row(

                                  children: [

                                    ClipRRect(

                                      borderRadius:
                                          BorderRadius.circular(
                                        14,
                                      ),

                                      child:
                                          Image.memory(

                                        base64Decode(
                                          item.product.imageBase64,
                                        ),

                                        width:
                                            50,

                                        height:
                                            50,

                                        fit:
                                            BoxFit.cover,
                                      ),
                                    ),

                                    const SizedBox(
                                      width:
                                          10,
                                    ),

                                    Expanded(

                                      child:
                                          Column(

                                        crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,

                                        children: [

                                          Text(

                                            item.product.name,

                                            maxLines:
                                                1,

                                            overflow:
                                                TextOverflow
                                                    .ellipsis,

                                            style:
                                                const TextStyle(

                                              fontSize:
                                                  13,

                                              fontWeight:
                                                  FontWeight.bold,
                                            ),
                                          ),

                                          const SizedBox(
                                            height:
                                                3,
                                          ),

                                          Text(

                                            '${item.quantity} x ${AppFormat.currency(item.product.price)}',

                                            style:
                                                TextStyle(

                                              fontSize:
                                                  11,

                                              color:
                                                  Colors.grey
                                                      .shade700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(
                                      width:
                                          10,
                                    ),

                                    Text(

                                      AppFormat.currency(
                                        item.subtotal,
                                      ),

                                      style:
                                          const TextStyle(

                                        fontSize:
                                            13,

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
                      height: 18,
                    ),

                    // =====================================
                    // TOTAL CARD
                    // =====================================

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
                            Colors.white,

                        borderRadius:
                            BorderRadius.circular(
                          22,
                        ),

                        boxShadow: [

                          BoxShadow(

                            color:
                                Colors.black
                                    .withOpacity(
                              0.04,
                            ),

                            blurRadius: 16,

                            offset:
                                const Offset(
                              0,
                              8,
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
                            height: 8,
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
                                  14,
                            ),

                            child:
                                Divider(),
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
                                      16,

                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              Flexible(

                                child: Text(

                                  AppFormat.currency(
                                    cartProvider
                                        .totalPrice,
                                  ),

                                  overflow:
                                      TextOverflow
                                          .ellipsis,

                                  textAlign:
                                      TextAlign.right,

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
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 16,
                          ),

                          SizedBox(

                            width:
                                double.infinity,

                            height: 48,

                            child:
                                ElevatedButton(

                              style:
                                  ElevatedButton.styleFrom(

                                elevation:
                                    0,

                                backgroundColor:

                                    invalidStock

                                        ? Colors.grey

                                        : AppColors.primary,

                                foregroundColor:
                                    Colors.white,

                                shape:
                                    RoundedRectangleBorder(

                                  borderRadius:
                                      BorderRadius.circular(
                                    16,
                                  ),
                                ),
                              ),

                              onPressed:

                                  orderProvider
                                          .isLoading ||

                                      invalidStock

                                      ? null

                                      : createOrder,

                              child:
                                  orderProvider
                                          .isLoading

                                      ? const SizedBox(

                                          width:
                                              20,

                                          height:
                                              20,

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
                                                14,

                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

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

      style:
          const TextStyle(
        fontSize: 13,
      ),

      decoration:
          InputDecoration(

        labelText:
            label,

        labelStyle:
            const TextStyle(
          fontSize: 13,
        ),

        prefixIcon:
            Icon(
          icon,
          size: 18,
        ),

        filled: true,

        fillColor:
            Colors.white,

        contentPadding:
            const EdgeInsets.symmetric(

          horizontal: 14,

          vertical: 14,
        ),

        border:
            OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(
            16,
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

      child:
          AnimatedContainer(

        duration:
            const Duration(
          milliseconds:
              220,
        ),

        width: 145,

        padding:
            const EdgeInsets.all(
          14,
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
            18,
          ),

          border: Border.all(

            color:

                selected

                    ? AppColors
                        .primary

                    : Colors.grey
                        .shade200,

            width: 1.5,
          ),
        ),

        child: Column(

          children: [

            Icon(

              icon,

              size: 24,

              color:

                  selected

                      ? AppColors
                          .primary

                      : Colors
                          .grey,
            ),

            const SizedBox(
              height: 8,
            ),

            Text(

              title,

              textAlign:
                  TextAlign.center,

              style: TextStyle(

                fontSize: 12,

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

  Widget _buildPriceRow({

    required String title,

    required String value,
  }) {

    return Row(

      mainAxisAlignment:
          MainAxisAlignment
              .spaceBetween,

      children: [

        Text(

          title,

          style:
              TextStyle(

            fontSize: 13,

            color:
                Colors.grey
                    .shade700,
          ),
        ),

        Flexible(

          child: Text(

            value,

            overflow:
                TextOverflow
                    .ellipsis,

            textAlign:
                TextAlign.right,

            style:
                const TextStyle(

              fontSize: 13,

              fontWeight:
                  FontWeight.bold,
            ),
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