// =====================================================
// lib/screens/user/checkout_screen.dart
// CLEAN PREMIUM RESPONSIVE VERSION
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

  // =========================================
  // FORM
  // =========================================

  final GlobalKey<FormState>
      _formKey =
      GlobalKey<FormState>();

  final nameController =
      TextEditingController();

  final phoneController =
      TextEditingController();

  final addressController =
      TextEditingController();

  // =========================================
  // PAYMENT
  // =========================================

  String paymentMethod =
      'Cash';

  // =========================================
  // ANIMATION
  // =========================================

  late AnimationController
      _animationController;

  late Animation<double>
      _fadeAnimation;

  // =========================================
  // INIT
  // =========================================

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

  // =========================================
  // VALIDATION
  // =========================================

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

  // =========================================
  // CREATE ORDER
  // =========================================

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

    // ===============================
    // VALIDATE STOCK
    // ===============================

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

    // ===============================
    // UPDATE USER DATA
    // ===============================

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

    // ===============================
    // CREATE ORDER MODEL
    // ===============================

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

    // ===============================
    // CREATE ORDER
    // ===============================

    final success =
        await orderProvider
            .createOrder(
      order,
    );

    if (!mounted) {
      return;
    }

    // ===============================
    // SUCCESS
    // ===============================

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

    // ===============================
    // FAILED
    // ===============================

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

  // =========================================
  // BUILD
  // =========================================

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

      // =====================================
      // APPBAR
      // =====================================

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

                fontSize: 20,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            SizedBox(
              height: 2,
            ),

            Text(

              'Modern marketplace checkout',

              style: TextStyle(

                color:
                    Colors.grey,

                fontSize: 12,
              ),
            ),
          ],
        ),
      ),

      // =====================================
      // BODY
      // =====================================

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
              isMobile ? 14 : 20,
            ),

            child: Center(

              child: ConstrainedBox(

                constraints:
                    const BoxConstraints(
                  maxWidth: 920,
                ),

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    // ===============================
                    // WARNING
                    // ===============================

                    if (invalidStock)

                      Container(

                        width:
                            double.infinity,

                        margin:
                            const EdgeInsets.only(
                          bottom: 20,
                        ),

                        padding:
                            const EdgeInsets.all(
                          16,
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
                            22,
                          ),
                        ),

                        child: const Row(

                          children: [

                            Icon(

                              Icons
                                  .warning_amber_rounded,

                              color:
                                  Colors.red,
                            ),

                            SizedBox(
                              width: 12,
                            ),

                            Expanded(

                              child: Text(

                                'Some products exceed available stock.',

                                style:
                                    TextStyle(

                                  color:
                                      Colors.red,

                                  fontWeight:
                                      FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    // ===============================
                    // PROFILE CARD
                    // ===============================

                    Container(

                      width:
                          double.infinity,

                      padding:
                          EdgeInsets.all(
                        isMobile
                            ? 18
                            : 24,
                      ),

                      decoration:
                          BoxDecoration(

                        borderRadius:
                            BorderRadius.circular(
                          30,
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

                            width:
                                isMobile
                                    ? 56
                                    : 64,

                            height:
                                isMobile
                                    ? 56
                                    : 64,

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
                                            28,
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
                                      TextStyle(

                                    color:
                                        Colors
                                            .white,

                                    fontSize:
                                        isMobile
                                            ? 18
                                            : 22,

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
                      height: 26,
                    ),

                    // ===============================
                    // SHIPPING
                    // ===============================

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
                      height: 16,
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
                      height: 16,
                    ),

                    _buildInputField(

                      controller:
                          addressController,

                      label:
                          'Shipping Address',

                      icon:
                          Icons.location_on,

                      minLines: 3,

                      maxLines: 4,
                    ),

                    const SizedBox(
                      height: 28,
                    ),

                    // ===============================
                    // PAYMENT
                    // ===============================

                    const Text(

                      'Payment Method',

                      style: TextStyle(

                        fontSize: 24,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 18,
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
                      height: 28,
                    ),

                    // ===============================
                    // INFO BOX
                    // ===============================

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

                              style:
                                  TextStyle(

                                color:
                                    Colors.grey
                                        .shade800,

                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    // ===============================
                    // ORDER SUMMARY
                    // ===============================

                    const Text(

                      'Order Summary',

                      style: TextStyle(

                        fontSize: 24,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 18,
                    ),

                    Container(

                      width:
                          double.infinity,

                      padding:
                          EdgeInsets.all(
                        isMobile
                            ? 16
                            : 20,
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

                          ...cartProvider
                              .items
                              .map(
                            (item) {

                              final product =
                                  productProvider
                                      .getProductById(
                                item.product.id,
                              );

                              final soldOut =
                                  product ==
                                          null ||

                                      product.stock <=
                                          0;

                              final exceedStock =
                                  product !=
                                          null &&
                                      item.quantity >
                                          product.stock;

                              return Padding(

                                padding:
                                    const EdgeInsets.only(
                                  bottom:
                                      18,
                                ),

                                child: Column(

                                  children: [

                                    if (soldOut ||
                                        exceedStock)

                                      Container(

                                        width:
                                            double.infinity,

                                        margin:
                                            const EdgeInsets.only(
                                          bottom:
                                              10,
                                        ),

                                        padding:
                                            const EdgeInsets.all(
                                          12,
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
                                            16,
                                          ),
                                        ),

                                        child:
                                            Text(

                                          soldOut

                                              ? '${item.product.name} sold out'

                                              : 'Available stock only ${product.stock}',

                                          style:
                                              const TextStyle(

                                            color:
                                                Colors.red,

                                            fontWeight:
                                                FontWeight.w600,
                                          ),
                                        ),
                                      ),

                                    Row(

                                      children: [

                                        Container(

                                          width:
                                              60,

                                          height:
                                              60,

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

                                          child:
                                              Column(

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

                                        Flexible(

                                          child: Text(

                                            AppFormat.currency(
                                              item.subtotal,
                                            ),

                                            overflow:
                                                TextOverflow
                                                    .ellipsis,

                                            textAlign:
                                                TextAlign.right,

                                            style:
                                                const TextStyle(

                                              fontWeight:
                                                  FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
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

                    // ===============================
                    // TOTAL CARD
                    // ===============================

                    Container(

                      width:
                          double.infinity,

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
                              0.05,
                            ),

                            blurRadius: 20,

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
                                      18,

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
                                        24,

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
                            height: 20,
                          ),

                          SizedBox(

                            width:
                                double.infinity,

                            height: 54,

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
                                    18,
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

                                      : Text(

                                          invalidStock

                                              ? 'Stock Not Available'

                                              : 'Create Order',

                                          style:
                                              const TextStyle(

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

  // =========================================
  // INPUT
  // =========================================

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

        filled: true,

        fillColor:
            Colors.white,

        contentPadding:
            const EdgeInsets.symmetric(

          horizontal: 18,

          vertical: 18,
        ),

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

  // =========================================
  // PAYMENT CARD
  // =========================================

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

                    : Colors.grey
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

  // =========================================
  // PRICE ROW
  // =========================================

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