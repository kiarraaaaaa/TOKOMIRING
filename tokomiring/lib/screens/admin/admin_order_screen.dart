// lib/screens/admin/admin_order_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_format.dart';

import '../../providers/order_provider.dart';

class AdminOrderScreen
    extends StatelessWidget {

  const AdminOrderScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    final orderProvider =
        Provider.of<OrderProvider>(
      context,
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
          'Orders Management',
        ),
      ),

      // =================================================
      // BODY
      // =================================================

      body:
          orderProvider.isLoading

              ? const Center(
                  child:
                      CircularProgressIndicator(),
                )

              : orderProvider
                      .orders
                      .isEmpty

                  // =====================================
                  // EMPTY
                  // =====================================

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
                            'No Orders',

                            style: TextStyle(
                              fontSize: 24,

                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )

                  // =====================================
                  // ORDER LIST
                  // =====================================

                  : ListView.builder(

                      padding:
                          const EdgeInsets.all(
                        20,
                      ),

                      itemCount:
                          orderProvider
                              .orders
                              .length,

                      itemBuilder:
                          (
                            context,
                            index,
                          ) {

                        final order =
                            orderProvider
                                    .orders[
                                index];

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

                              // =======================
                              // TOP
                              // =======================

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,

                                children: [

                                  Expanded(
                                    child: Text(
                                      order.customerName,

                                      style:
                                          const TextStyle(
                                        fontSize:
                                            18,

                                        fontWeight:
                                            FontWeight.bold,
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
                                height: 10,
                              ),

                              // =======================
                              // DATE
                              // =======================

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
                                height: 20,
                              ),

                              // =======================
                              // CUSTOMER INFO
                              // =======================

                              _buildInfo(
                                title:
                                    'Phone',

                                value:
                                    order.customerPhone,
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              _buildInfo(
                                title:
                                    'Address',

                                value:
                                    order.address,
                              ),

                              const SizedBox(
                                height: 20,
                              ),

                              // =======================
                              // ITEMS
                              // =======================

                              const Text(
                                'Order Items',

                                style:
                                    TextStyle(
                                  fontWeight:
                                      FontWeight.bold,

                                  fontSize:
                                      16,
                                ),
                              ),

                              const SizedBox(
                                height: 16,
                              ),

                              ...order.items.map(
                                (item) {

                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(
                                      bottom:
                                          14,
                                    ),

                                    child: Row(
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
                                              14,
                                            ),
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

                                                return Container(
                                                  color:
                                                      Colors.grey
                                                          .shade200,

                                                  child:
                                                      const Icon(
                                                    Icons.image,
                                                  ),
                                                );
                                              },
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
                                                CrossAxisAlignment.start,

                                            children: [

                                              Text(
                                                item.productName,

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

                              const Divider(
                                height: 30,
                              ),

                              // =======================
                              // TOTAL
                              // =======================

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,

                                children: [

                                  const Text(
                                    'Total Price',

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

                                      fontSize:
                                          22,

                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 25,
                              ),

                              // =======================
                              // ACTIONS
                              // =======================

                              Wrap(
                                spacing: 10,

                                runSpacing: 10,

                                children: [

                                  ElevatedButton(
                                    onPressed: () {

                                      orderProvider
                                          .validateOrder(
                                        order.orderId,
                                      );
                                    },

                                    child:
                                        const Text(
                                      'Validate',
                                    ),
                                  ),

                                  OutlinedButton(
                                    onPressed: () {

                                      orderProvider
                                          .updateOrderStatus(

                                        orderId:
                                            order.orderId,

                                        status:
                                            'Processing',
                                      );
                                    },

                                    child:
                                        const Text(
                                      'Processing',
                                    ),
                                  ),

                                  OutlinedButton(
                                    onPressed: () {

                                      orderProvider
                                          .updateOrderStatus(

                                        orderId:
                                            order.orderId,

                                        status:
                                            'Shipping',
                                      );
                                    },

                                    child:
                                        const Text(
                                      'Shipping',
                                    ),
                                  ),

                                  OutlinedButton(
                                    onPressed: () {

                                      orderProvider
                                          .updateOrderStatus(

                                        orderId:
                                            order.orderId,

                                        status:
                                            'Completed',
                                      );
                                    },

                                    child:
                                        const Text(
                                      'Completed',
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
  // INFO ITEM
  // =====================================================

  Widget _buildInfo({

    required String title,

    required String value,

  }) {

    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        SizedBox(
          width: 80,

          child: Text(
            '$title :',

            style:
                const TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ),

        Expanded(
          child: Text(
            value,
          ),
        ),
      ],
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