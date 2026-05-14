// lib/screens/user/user_order_screen.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_format.dart';

import '../../providers/auth_provider.dart';
import '../../providers/order_provider.dart';

class UserOrderScreen
    extends StatefulWidget {

  const UserOrderScreen({
    super.key,
  });

  @override
  State<UserOrderScreen>
      createState() =>
          _UserOrderScreenState();
}

class _UserOrderScreenState
    extends State<UserOrderScreen>
    with
        TickerProviderStateMixin {

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
  }

  // =====================================================
  // DISPOSE
  // =====================================================

  @override
  void dispose() {

    _animationController
        .dispose();

    super.dispose();
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(
    BuildContext context,
  ) {

    final authProvider =
        context.watch<
            AuthProvider>();

    final orderProvider =
        context.watch<
            OrderProvider>();

    final user =
        authProvider.user;

    // ===================================================
    // USER NULL
    // ===================================================

    if (user == null) {

      return const Scaffold(

        body: Center(

          child: Text(
            'User not found',
          ),
        ),
      );
    }

    // ===================================================
    // USER ORDERS
    // ===================================================

    final orders =
        orderProvider
            .getUserOrders(
      user.uid,
    );

    return Scaffold(

      backgroundColor:
          const Color(
        0xffF5F7FB,
      ),

      // =================================================
      // APPBAR
      // =================================================

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

              'Transaction History',

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

              'Premium marketplace orders',

              style: TextStyle(

                color:
                    Colors.grey,

                fontSize: 13,
              ),
            ),
          ],
        ),
      ),

      // =================================================
      // BODY
      // =================================================

      body: FadeTransition(

        opacity:
            _fadeAnimation,

        child:
            orders.isEmpty

                // =========================================
                // EMPTY
                // =========================================

                ? Center(

                    child: Padding(

                      padding:
                          const EdgeInsets.all(
                        24,
                      ),

                      child: Column(

                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,

                        children: [

                          Container(

                            width: 180,

                            height: 180,

                            decoration:
                                BoxDecoration(

                              shape:
                                  BoxShape.circle,

                              gradient:
                                  LinearGradient(

                                colors: [

                                  AppColors
                                      .primary
                                      .withOpacity(
                                    0.15,
                                  ),

                                  AppColors
                                      .primary
                                      .withOpacity(
                                    0.05,
                                  ),
                                ],
                              ),
                            ),

                            child:
                                const Icon(

                              Icons
                                  .receipt_long,

                              size: 90,

                              color:
                                  AppColors
                                      .primary,
                            ),
                          ),

                          const SizedBox(
                            height: 28,
                          ),

                          const Text(

                            'No Orders Yet',

                            textAlign:
                                TextAlign.center,

                            style: TextStyle(

                              fontSize: 28,

                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(
                            height: 12,
                          ),

                          Text(

                            'Your transaction history will appear here after checkout.',

                            textAlign:
                                TextAlign.center,

                            style: TextStyle(

                              color:
                                  Colors
                                      .grey
                                      .shade600,

                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )

                // =========================================
                // LIST
                // =========================================

                : ListView(

                    physics:
                        const BouncingScrollPhysics(),

                    padding:
                        const EdgeInsets.all(
                      20,
                    ),

                    children: [

                      // =====================================
                      // ANALYTICS
                      // =====================================

                      Wrap(

                        spacing: 16,

                        runSpacing: 16,

                        children: [

                          _buildAnalyticsCard(

                            title:
                                'Pending',

                            value:
                                '${orders.where((e) => e.status == 'Waiting Admin Validation').length}',

                            icon:
                                Icons.pending_actions,

                            color:
                                Colors.orange,
                          ),

                          _buildAnalyticsCard(

                            title:
                                'Validated',

                            value:
                                '${orders.where((e) => e.status == 'Processing Delivery').length}',

                            icon:
                                Icons.verified,

                            color:
                                Colors.blue,
                          ),

                          _buildAnalyticsCard(

                            title:
                                'Completed',

                            value:
                                '${orders.where((e) => e.status == 'Completed').length}',

                            icon:
                                Icons.check_circle,

                            color:
                                Colors.green,
                          ),

                          _buildAnalyticsCard(

                            title:
                                'Rejected',

                            value:
                                '${orders.where((e) => e.status == 'Rejected').length}',

                            icon:
                                Icons.cancel,

                            color:
                                Colors.red,
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 28,
                      ),

                      // =====================================
                      // ORDER LIST
                      // =====================================

                      ...orders.map(
                        (order) {

                          return Container(

                            margin:
                                const EdgeInsets.only(
                              bottom: 22,
                            ),

                            decoration:
                                BoxDecoration(

                              color:
                                  Colors.white,

                              borderRadius:
                                  BorderRadius.circular(
                                30,
                              ),

                              boxShadow: [

                                BoxShadow(

                                  color:
                                      Colors.black
                                          .withOpacity(
                                    0.04,
                                  ),

                                  blurRadius:
                                      15,

                                  offset:
                                      const Offset(
                                    0,
                                    8,
                                  ),
                                ),
                              ],
                            ),

                            child: ExpansionTile(

                              tilePadding:
                                  const EdgeInsets.symmetric(

                                horizontal:
                                    22,

                                vertical:
                                    12,
                              ),

                              childrenPadding:
                                  const EdgeInsets.fromLTRB(

                                22,
                                0,
                                22,
                                22,
                              ),

                              shape:
                                  RoundedRectangleBorder(

                                borderRadius:
                                    BorderRadius.circular(
                                  30,
                                ),
                              ),

                              collapsedShape:
                                  RoundedRectangleBorder(

                                borderRadius:
                                    BorderRadius.circular(
                                  30,
                                ),
                              ),

                              title: Column(

                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                children: [

                                  Row(

                                    children: [

                                      Expanded(

                                        child: Text(

                                          order.orderId,

                                          maxLines: 1,

                                          overflow:
                                              TextOverflow
                                                  .ellipsis,

                                          style:
                                              const TextStyle(

                                            fontWeight:
                                                FontWeight.bold,

                                            fontSize:
                                                17,
                                          ),
                                        ),
                                      ),

                                      AnimatedContainer(

                                        duration:
                                            const Duration(
                                          milliseconds:
                                              250,
                                        ),

                                        padding:
                                            const EdgeInsets.symmetric(

                                          horizontal:
                                              14,

                                          vertical:
                                              8,
                                        ),

                                        decoration:
                                            BoxDecoration(

                                          color:
                                              _statusColor(
                                            order.status,
                                          ).withOpacity(
                                            0.12,
                                          ),

                                          borderRadius:
                                              BorderRadius.circular(
                                            16,
                                          ),
                                        ),

                                        child: Text(

                                          order.status,

                                          overflow:
                                              TextOverflow
                                                  .ellipsis,

                                          style:
                                              TextStyle(

                                            color:
                                                _statusColor(
                                              order.status,
                                            ),

                                            fontWeight:
                                                FontWeight.bold,

                                            fontSize:
                                                12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),

                                  Text(

                                    AppFormat.dateTime(
                                      order.createdAt,
                                    ),

                                    style:
                                        TextStyle(

                                      color:
                                          Colors
                                              .grey
                                              .shade600,

                                      fontSize:
                                          13,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 16,
                                  ),

                                  Row(

                                    mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,

                                    children: [

                                      Text(

                                        '${order.totalItems} Items',

                                        style:
                                            TextStyle(

                                          color:
                                              Colors
                                                  .grey
                                                  .shade700,
                                        ),
                                      ),

                                      Flexible(

                                        child: Text(

                                          AppFormat.currency(
                                            order.totalPrice,
                                          ),

                                          overflow:
                                              TextOverflow
                                                  .ellipsis,

                                          textAlign:
                                              TextAlign
                                                  .right,

                                          style:
                                              const TextStyle(

                                            color:
                                                AppColors
                                                    .primary,

                                            fontWeight:
                                                FontWeight.bold,

                                            fontSize:
                                                20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              children: [

                                const Divider(
                                  height: 30,
                                ),

                                // =========================
                                // SHIPPING INFO
                                // =========================

                                _buildInfoTile(

                                  icon:
                                      Icons.location_on,

                                  title:
                                      'Shipping Address',

                                  value:
                                      order.address,
                                ),

                                const SizedBox(
                                  height: 16,
                                ),

                                _buildInfoTile(

                                  icon:
                                      Icons.payments,

                                  title:
                                      'Payment Method',

                                  value:
                                      order.paymentMethod,
                                ),

                                const SizedBox(
                                  height: 24,
                                ),

                                // =========================
                                // PRODUCTS
                                // =========================

                                const Align(

                                  alignment:
                                      Alignment
                                          .centerLeft,

                                  child: Text(

                                    'Order Items',

                                    style:
                                        TextStyle(

                                      fontWeight:
                                          FontWeight.bold,

                                      fontSize:
                                          18,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 18,
                                ),

                                ...order.items.map(
                                  (item) {

                                    return Container(

                                      margin:
                                          const EdgeInsets.only(
                                        bottom:
                                            16,
                                      ),

                                      padding:
                                          const EdgeInsets.all(
                                        16,
                                      ),

                                      decoration:
                                          BoxDecoration(

                                        color:
                                            const Color(
                                          0xffF8FAFC,
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

                                          // =================
                                          // IMAGE
                                          // =================

                                          Container(

                                            width:
                                                70,

                                            height:
                                                70,

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
                                                  item.productImage.isNotEmpty

                                                      ? Image.memory(

                                                          base64Decode(
                                                            item.productImage,
                                                          ),

                                                          fit:
                                                              BoxFit.cover,
                                                        )

                                                      : Container(

                                                          color:
                                                              Colors.grey.shade200,

                                                          child:
                                                              const Icon(
                                                            Icons.image,
                                                          ),
                                                        ),
                                            ),
                                          ),

                                          const SizedBox(
                                            width:
                                                16,
                                          ),

                                          Expanded(

                                            child: Column(

                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,

                                              children: [

                                                Text(

                                                  item.productName,

                                                  maxLines:
                                                      2,

                                                  overflow:
                                                      TextOverflow.ellipsis,

                                                  style:
                                                      const TextStyle(

                                                    fontWeight:
                                                        FontWeight.bold,

                                                    fontSize:
                                                        15,
                                                  ),
                                                ),

                                                const SizedBox(
                                                  height:
                                                      8,
                                                ),

                                                Text(

                                                  '${item.quantity} x ${AppFormat.currency(item.productPrice)}',

                                                  style:
                                                      TextStyle(

                                                    color:
                                                        Colors.grey.shade600,
                                                  ),
                                                ),

                                                const SizedBox(
                                                  height:
                                                      10,
                                                ),

                                                Text(

                                                  AppFormat.currency(
                                                    item.subtotal,
                                                  ),

                                                  style:
                                                      const TextStyle(

                                                    color:
                                                        AppColors.primary,

                                                    fontWeight:
                                                        FontWeight.bold,

                                                    fontSize:
                                                        16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),

                                const Divider(
                                  height: 30,
                                ),

                                // =========================
                                // TOTAL
                                // =========================

                                Row(

                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,

                                  children: [

                                    const Text(

                                      'Grand Total',

                                      style:
                                          TextStyle(

                                        fontWeight:
                                            FontWeight.bold,

                                        fontSize:
                                            18,
                                      ),
                                    ),

                                    Flexible(

                                      child: Text(

                                        AppFormat.currency(
                                          order.totalPrice,
                                        ),

                                        overflow:
                                            TextOverflow
                                                .ellipsis,

                                        textAlign:
                                            TextAlign
                                                .right,

                                        style:
                                            const TextStyle(

                                          color:
                                              AppColors
                                                  .primary,

                                          fontWeight:
                                              FontWeight.bold,

                                          fontSize:
                                              24,
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

                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
      ),
    );
  }

  // =====================================================
  // INFO TILE
  // =====================================================

  Widget _buildInfoTile({

    required IconData icon,

    required String title,

    required String value,

  }) {

    return Row(

      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Container(

          padding:
              const EdgeInsets.all(
            12,
          ),

          decoration:
              BoxDecoration(

            color:
                AppColors.primary
                    .withOpacity(
              0.08,
            ),

            borderRadius:
                BorderRadius.circular(
              16,
            ),
          ),

          child: Icon(

            icon,

            color:
                AppColors.primary,

            size: 22,
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

                title,

                style: TextStyle(

                  color:
                      Colors
                          .grey
                          .shade600,

                  fontSize:
                      13,
                ),
              ),

              const SizedBox(
                height: 4,
              ),

              Text(

                value,

                style:
                    const TextStyle(

                  fontWeight:
                      FontWeight.bold,

                  fontSize:
                      15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // =====================================================
  // ANALYTICS CARD
  // =====================================================

  Widget _buildAnalyticsCard({

    required String title,

    required String value,

    required IconData icon,

    required Color color,

  }) {

    return Container(

      width: 170,

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
          24,
        ),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black
                    .withOpacity(
              0.04,
            ),

            blurRadius:
                15,

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

          Container(

            padding:
                const EdgeInsets.all(
              12,
            ),

            decoration:
                BoxDecoration(

              color:
                  color.withOpacity(
                0.12,
              ),

              borderRadius:
                  BorderRadius.circular(
                18,
              ),
            ),

            child: Icon(

              icon,

              color:
                  color,
            ),
          ),

          const SizedBox(
            height: 18,
          ),

          Text(

            value,

            overflow:
                TextOverflow
                    .ellipsis,

            style:
                const TextStyle(

              fontSize: 24,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 4,
          ),

          Text(

            title,

            overflow:
                TextOverflow
                    .ellipsis,

            style: TextStyle(

              color:
                  Colors
                      .grey
                      .shade600,
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // STATUS COLOR
  // =====================================================

  Color _statusColor(
    String status,
  ) {

    switch (
        status.toLowerCase()) {

      case 'completed':
        return AppColors.success;

      case 'processing delivery':
        return AppColors.primary;

      case 'waiting admin validation':
        return AppColors.warning;

      case 'rejected':
        return AppColors.danger;

      default:
        return AppColors.pending;
    }
  }
}