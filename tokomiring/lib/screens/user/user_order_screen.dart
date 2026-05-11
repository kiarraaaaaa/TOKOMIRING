// lib/screens/user/user_order_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_format.dart';

import '../../providers/auth_provider.dart';
import '../../providers/order_provider.dart';

class UserOrderScreen
    extends StatelessWidget {

  const UserOrderScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    final authProvider =
        Provider.of<AuthProvider>(
      context,
    );

    final orderProvider =
        Provider.of<OrderProvider>(
      context,
    );

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
        orderProvider.getUserOrders(
      user.uid,
    );

    return Scaffold(

      backgroundColor:
          AppColors.background,

      // =================================================
      // APP BAR
      // =================================================

      appBar: AppBar(
        title:
            const Text(
          'My Orders',
        ),
      ),

      // =================================================
      // BODY
      // =================================================

      body:
          orders.isEmpty

              // =========================================
              // EMPTY
              // =========================================

              ? Center(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    children: [

                      Icon(
                        Icons.receipt_long,

                        size: 100,

                        color:
                            Colors.grey
                                .shade400,
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      const Text(
                        'No Orders Yet',

                        style: TextStyle(
                          fontSize: 22,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      Text(
                        'Your order history will appear here',

                        style: TextStyle(
                          color:
                              Colors.grey
                                  .shade600,
                        ),
                      ),
                    ],
                  ),
                )

              // =========================================
              // ORDER LIST
              // =========================================

              : ListView.builder(

                  padding:
                      const EdgeInsets.all(
                    20,
                  ),

                  itemCount:
                      orders.length,

                  itemBuilder:
                      (
                        context,
                        index,
                      ) {

                    final order =
                        orders[index];

                    return Container(

                      margin:
                          const EdgeInsets.only(
                        bottom: 20,
                      ),

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

                        boxShadow: [

                          BoxShadow(
                            color:
                                Colors.black
                                    .withOpacity(
                              0.04,
                            ),

                            blurRadius:
                                15,
                          ),
                        ],
                      ),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          // =============================
                          // TOP
                          // =============================

                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,

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
                                        16,
                                  ),
                                ),
                              ),

                              Container(
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
                                    14,
                                  ),
                                ),

                                child: Text(
                                  order.status,

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
                            height: 12,
                          ),

                          // =============================
                          // DATE
                          // =============================

                          Text(
                            AppFormat.dateTime(
                              order.createdAt,
                            ),

                            style:
                                TextStyle(
                              color:
                                  Colors.grey
                                      .shade600,
                            ),
                          ),

                          const SizedBox(
                            height: 18,
                          ),

                          // =============================
                          // ITEMS
                          // =============================

                          ...order.items.map(
                            (item) {

                              return Padding(
                                padding:
                                    const EdgeInsets.only(
                                  bottom:
                                      12,
                                ),

                                child: Row(
                                  children: [

                                    // ===================
                                    // IMAGE
                                    // ===================

                                    Container(
                                      width: 60,

                                      height: 60,

                                      decoration:
                                          BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(
                                          14,
                                        ),

                                        color:
                                            Colors.grey
                                                .shade100,
                                      ),

                                      child:
                                          ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(
                                          14,
                                        ),

                                        child:
                                            Image.network(
                                          item.productImage,

                                          fit:
                                              BoxFit.cover,

                                          errorBuilder:
                                              (
                                                context,
                                                error,
                                                stackTrace,
                                              ) {

                                            return const Icon(
                                              Icons.image,
                                            );
                                          },
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                      width:
                                          14,
                                    ),

                                    // ===================
                                    // INFO
                                    // ===================

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,

                                        children: [

                                          Text(
                                            item.productName,

                                            maxLines:
                                                1,

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
                                            '${item.quantity} x ${AppFormat.currency(item.productPrice)}',

                                            style:
                                                TextStyle(
                                              color:
                                                  Colors.grey
                                                      .shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // ===================
                                    // SUBTOTAL
                                    // ===================

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

                          const Divider(
                            height: 30,
                          ),

                          // =============================
                          // TOTAL
                          // =============================

                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,

                            children: [

                              const Text(
                                'Total',

                                style:
                                    TextStyle(
                                  fontWeight:
                                      FontWeight.bold,

                                  fontSize:
                                      16,
                                ),
                              ),

                              Text(
                                AppFormat.currency(
                                  order.totalPrice,
                                ),

                                style:
                                    const TextStyle(
                                  color:
                                      AppColors.primary,

                                  fontWeight:
                                      FontWeight.bold,

                                  fontSize:
                                      20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
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

      case 'shipping':
        return AppColors.primary;

      case 'processing':
        return AppColors.warning;

      case 'cancelled':
        return AppColors.danger;

      default:
        return AppColors.pending;
    }
  }
}