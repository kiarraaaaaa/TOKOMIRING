// =====================================================
// lib/screens/user/user_order_screen.dart
// FINAL ULTRA COMPACT PREMIUM VERSION
// =====================================================

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

  @override
  void initState() {

    super.initState();

    _animationController =
        AnimationController(

      vsync: this,

      duration:
          const Duration(
        milliseconds: 420,
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

  @override
  void dispose() {

    _animationController
        .dispose();

    super.dispose();
  }

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

    if (user == null) {

      return const Scaffold(

        body: Center(

          child: Text(
            'User not found',
          ),
        ),
      );
    }

    final orders =
        orderProvider
            .getUserOrders(
      user.uid,
    );

    final width =
        MediaQuery.of(context)
            .size
            .width;

    final isMobile =
        width < 700;

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

        titleSpacing: 18,

        title: Column(

          crossAxisAlignment:
              CrossAxisAlignment
                  .start,

          children: [

            Text(

              'Transaction History',

              style: TextStyle(

                color:
                    Colors.black,

                fontSize:
                    isMobile
                        ? 19
                        : 21,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 1,
            ),

            Text(

              'Compact premium order dashboard',

              style: TextStyle(

                color:
                    Colors.grey,

                fontSize:
                    isMobile
                        ? 10
                        : 11,
              ),
            ),
          ],
        ),
      ),

      body: FadeTransition(

        opacity:
            _fadeAnimation,

        child:
            orders.isEmpty

                ? Center(

                    child: Padding(

                      padding:
                          const EdgeInsets.all(
                        22,
                      ),

                      child: Column(

                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,

                        children: [

                          Container(

                            width: 100,

                            height: 100,

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
                                    0.14,
                                  ),

                                  AppColors
                                      .primary
                                      .withOpacity(
                                    0.04,
                                  ),
                                ],
                              ),
                            ),

                            child:
                                const Icon(

                              Icons
                                  .receipt_long,

                              size: 54,

                              color:
                                  AppColors
                                      .primary,
                            ),
                          ),

                          const SizedBox(
                            height: 18,
                          ),

                          const Text(

                            'No Orders Yet',

                            textAlign:
                                TextAlign.center,

                            style: TextStyle(

                              fontSize: 18,

                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(
                            height: 8,
                          ),

                          Text(

                            'Your transaction history will appear here.',

                            textAlign:
                                TextAlign.center,

                            style: TextStyle(

                              color:
                                  Colors
                                      .grey
                                      .shade600,

                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )

                : ListView(

                    physics:
                        const BouncingScrollPhysics(),

                    padding:
                        EdgeInsets.all(
                      isMobile
                          ? 12
                          : 16,
                    ),

                    children: [

                      // =================================
                      // ANALYTICS
                      // =================================

                      Wrap(

                        spacing: 10,

                        runSpacing: 10,

                        children: [

                          _buildAnalyticsCard(

                            title:
                                'Pending',

                            value:
                                '${orders.where((e) => e.status == 'Waiting Admin Validation').length}',

                            icon:
                                Icons.pending_actions_rounded,

                            color:
                                Colors.orange,
                          ),

                          _buildAnalyticsCard(

                            title:
                                'Validated',

                            value:
                                '${orders.where((e) => e.status == 'Processing Delivery').length}',

                            icon:
                                Icons.verified_rounded,

                            color:
                                Colors.blue,
                          ),

                          _buildAnalyticsCard(

                            title:
                                'Completed',

                            value:
                                '${orders.where((e) => e.status == 'Completed').length}',

                            icon:
                                Icons.check_circle_rounded,

                            color:
                                Colors.green,
                          ),

                          _buildAnalyticsCard(

                            title:
                                'Rejected',

                            value:
                                '${orders.where((e) => e.status == 'Rejected').length}',

                            icon:
                                Icons.cancel_rounded,

                            color:
                                Colors.red,
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      // =================================
                      // ORDER LIST
                      // =================================

                      ...orders.map(
                        (order) {

                          return Container(

                            margin:
                                const EdgeInsets.only(
                              bottom: 14,
                            ),

                            decoration:
                                BoxDecoration(

                              color:
                                  Colors.white,

                              borderRadius:
                                  BorderRadius.circular(
                                22,
                              ),

                              border: Border.all(

                                color:
                                    Colors.grey
                                        .shade100,
                              ),

                              boxShadow: [

                                BoxShadow(

                                  color:
                                      Colors.black
                                          .withOpacity(
                                    0.03,
                                  ),

                                  blurRadius:
                                      10,

                                  offset:
                                      const Offset(
                                    0,
                                    5,
                                  ),
                                ),
                              ],
                            ),

                            child: ExpansionTile(

                              tilePadding:
                                  const EdgeInsets.symmetric(

                                horizontal:
                                    14,

                                vertical:
                                    4,
                              ),

                              childrenPadding:
                                  const EdgeInsets.fromLTRB(

                                14,
                                0,
                                14,
                                14,
                              ),

                              shape:
                                  RoundedRectangleBorder(

                                borderRadius:
                                    BorderRadius.circular(
                                  22,
                                ),
                              ),

                              collapsedShape:
                                  RoundedRectangleBorder(

                                borderRadius:
                                    BorderRadius.circular(
                                  22,
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
                                                13,
                                          ),
                                        ),
                                      ),

                                      Container(

                                        padding:
                                            const EdgeInsets.symmetric(

                                          horizontal:
                                              9,

                                          vertical:
                                              5,
                                        ),

                                        decoration:
                                            BoxDecoration(

                                          color:
                                              _statusColor(
                                            order.status,
                                          ).withOpacity(
                                            0.10,
                                          ),

                                          borderRadius:
                                              BorderRadius.circular(
                                            11,
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
                                                9,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 7,
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
                                          10,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 10,
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

                                          fontSize:
                                              11,
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
                                                15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              children: [

                                const Divider(
                                  height: 22,
                                ),

                                _buildInfoTile(

                                  icon:
                                      Icons.location_on_outlined,

                                  title:
                                      'Shipping Address',

                                  value:
                                      order.address,
                                ),

                                const SizedBox(
                                  height: 12,
                                ),

                                _buildInfoTile(

                                  icon:
                                      Icons.payments_outlined,

                                  title:
                                      'Payment Method',

                                  value:
                                      order.paymentMethod,
                                ),

                                const SizedBox(
                                  height: 16,
                                ),

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
                                          14,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 12,
                                ),

                                ...order.items.map(
                                  (item) {

                                    return Container(

                                      margin:
                                          const EdgeInsets.only(
                                        bottom:
                                            10,
                                      ),

                                      padding:
                                          const EdgeInsets.all(
                                        10,
                                      ),

                                      decoration:
                                          BoxDecoration(

                                        gradient:
                                            LinearGradient(

                                          begin:
                                              Alignment.topLeft,

                                          end:
                                              Alignment.bottomRight,

                                          colors: [

                                            const Color(
                                              0xffF8FAFC,
                                            ),

                                            Colors.white,
                                          ],
                                        ),

                                        borderRadius:
                                            BorderRadius.circular(
                                          16,
                                        ),
                                      ),

                                      child: Row(

                                        crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,

                                        children: [

                                          Container(

                                            width:
                                                54,

                                            height:
                                                54,

                                            decoration:
                                                BoxDecoration(

                                              borderRadius:
                                                  BorderRadius.circular(
                                                12,
                                              ),
                                            ),

                                            child:
                                                ClipRRect(

                                              borderRadius:
                                                  BorderRadius.circular(
                                                12,
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
                                                            size:
                                                                16,
                                                          ),
                                                        ),
                                            ),
                                          ),

                                          const SizedBox(
                                            width:
                                                10,
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
                                                        12,
                                                  ),
                                                ),

                                                const SizedBox(
                                                  height:
                                                      4,
                                                ),

                                                Text(

                                                  '${item.quantity} x ${AppFormat.currency(item.productPrice)}',

                                                  style:
                                                      TextStyle(

                                                    color:
                                                        Colors.grey.shade600,

                                                    fontSize:
                                                        10,
                                                  ),
                                                ),

                                                const SizedBox(
                                                  height:
                                                      6,
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
                                                        13,
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
                                  height: 22,
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

                                        fontWeight:
                                            FontWeight.bold,

                                        fontSize:
                                            14,
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
                                              17,
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
                        height: 24,
                      ),
                    ],
                  ),
      ),
    );
  }

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
            9,
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
              12,
            ),
          ),

          child: Icon(

            icon,

            color:
                AppColors.primary,

            size: 16,
          ),
        ),

        const SizedBox(
          width: 10,
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
                      10,
                ),
              ),

              const SizedBox(
                height: 2,
              ),

              Text(

                value,

                style:
                    const TextStyle(

                  fontWeight:
                      FontWeight.bold,

                  fontSize:
                      12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAnalyticsCard({

    required String title,

    required String value,

    required IconData icon,

    required Color color,
  }) {

    return Container(

      width: 128,

      padding:
          const EdgeInsets.all(
        12,
      ),

      decoration:
          BoxDecoration(

        gradient:
            LinearGradient(

          begin:
              Alignment.topLeft,

          end:
              Alignment.bottomRight,

          colors: [

            Colors.white,

            color.withOpacity(
              0.03,
            ),
          ],
        ),

        borderRadius:
            BorderRadius.circular(
          18,
        ),

        border: Border.all(

          color:
              color.withOpacity(
            0.08,
          ),
        ),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black
                    .withOpacity(
              0.03,
            ),

            blurRadius: 10,

            offset:
                const Offset(
              0,
              4,
            ),
          ),
        ],
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment
                .start,

        children: [

          Row(

            children: [

              Container(

                width: 34,

                height: 34,

                decoration:
                    BoxDecoration(

                  color:
                      color.withOpacity(
                    0.10,
                  ),

                  borderRadius:
                      BorderRadius.circular(
                    10,
                  ),
                ),

                child: Icon(

                  icon,

                  size: 16,

                  color:
                      color,
                ),
              ),

              const Spacer(),

              Container(

                width: 7,

                height: 7,

                decoration:
                    BoxDecoration(

                  color:
                      color,

                  shape:
                      BoxShape.circle,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 12,
          ),

          Text(

            value,

            overflow:
                TextOverflow
                    .ellipsis,

            style:
                const TextStyle(

              fontSize: 16,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 2,
          ),

          Text(

            title,

            overflow:
                TextOverflow
                    .ellipsis,

            style:
                TextStyle(

              color:
                  Colors.grey
                      .shade600,

              fontSize: 10,

              fontWeight:
                  FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

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