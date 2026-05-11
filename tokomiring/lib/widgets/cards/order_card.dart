// lib/widgets/cards/order_card.dart

import 'package:flutter/material.dart';

import '../../models/order_model.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_format.dart';

class OrderCard
    extends StatelessWidget {

  final OrderModel order;

  final VoidCallback? onTap;

  // =====================================================
  // CONSTRUCTOR
  // =====================================================

  const OrderCard({

    super.key,

    required this.order,

    this.onTap,
  });

  // =====================================================
  // STATUS COLOR
  // =====================================================

  Color getStatusColor() {

    switch (order.status) {

      case 'Waiting Admin Validation':
        return AppColors.warning;

      case 'Processing Delivery':
        return AppColors.primary;

      case 'Package On Delivery':
        return Colors.purple;

      case 'Completed':
        return AppColors.success;

      case 'Cancelled':
        return AppColors.danger;

      default:
        return Colors.grey;
    }
  }

  // =====================================================
  // STATUS ICON
  // =====================================================

  IconData getStatusIcon() {

    switch (order.status) {

      case 'Waiting Admin Validation':
        return Icons.access_time_rounded;

      case 'Processing Delivery':
        return Icons.inventory_2_rounded;

      case 'Package On Delivery':
        return Icons.local_shipping_rounded;

      case 'Completed':
        return Icons.check_circle_rounded;

      case 'Cancelled':
        return Icons.cancel_rounded;

      default:
        return Icons.info_rounded;
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    final statusColor =
        getStatusColor();

    return Material(

      color:
          Colors.transparent,

      child: InkWell(

        borderRadius:
            BorderRadius.circular(
          28,
        ),

        onTap:
            onTap,

        child: Container(

          margin:
              const EdgeInsets.only(
            bottom: 18,
          ),

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

                blurRadius:
                    18,

                offset:
                    const Offset(
                  0,
                  10,
                ),
              ),
            ],
          ),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [

              // =====================================
              // TOP SECTION
              // =====================================

              Row(

                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  // =================================
                  // ORDER INFO
                  // =================================

                  Expanded(

                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        Text(

                          'Order #${order.orderId.substring(0, 8)}',

                          maxLines: 1,

                          overflow:
                              TextOverflow
                                  .ellipsis,

                          style:
                              const TextStyle(

                            fontSize: 19,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 6,
                        ),

                        Text(

                          AppFormat.date(
                            order.createdAt,
                          ),

                          style:
                              TextStyle(

                            color:
                                Colors.grey
                                    .shade600,

                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    width: 12,
                  ),

                  // =================================
                  // STATUS
                  // =================================

                  Container(

                    padding:
                        const EdgeInsets.symmetric(

                      horizontal: 14,

                      vertical: 10,
                    ),

                    decoration:
                        BoxDecoration(

                      color:
                          statusColor
                              .withOpacity(
                        0.1,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        16,
                      ),
                    ),

                    child: Row(

                      mainAxisSize:
                          MainAxisSize.min,

                      children: [

                        Icon(

                          getStatusIcon(),

                          size: 18,

                          color:
                              statusColor,
                        ),

                        const SizedBox(
                          width: 8,
                        ),

                        Text(

                          order.status,

                          style:
                              TextStyle(

                            color:
                                statusColor,

                            fontWeight:
                                FontWeight.bold,

                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 22,
              ),

              // =====================================
              // CUSTOMER
              // =====================================

              Row(

                children: [

                  Container(

                    width: 44,

                    height: 44,

                    decoration:
                        BoxDecoration(

                      color:
                          AppColors.primary
                              .withOpacity(
                        0.1,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        14,
                      ),
                    ),

                    child: const Icon(

                      Icons.person_rounded,

                      color:
                          AppColors.primary,
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

                          order.customerName,

                          maxLines: 1,

                          overflow:
                              TextOverflow
                                  .ellipsis,

                          style:
                              const TextStyle(

                            fontWeight:
                                FontWeight.bold,

                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(
                          height: 4,
                        ),

                        Text(

                          '${order.totalItems} items',

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
                ],
              ),

              const SizedBox(
                height: 22,
              ),

              // =====================================
              // TOTAL
              // =====================================

              Container(

                width:
                    double.infinity,

                padding:
                    const EdgeInsets.all(
                  16,
                ),

                decoration:
                    BoxDecoration(

                  color:
                      AppColors.success
                          .withOpacity(
                    0.08,
                  ),

                  borderRadius:
                      BorderRadius.circular(
                    18,
                  ),
                ),

                child: Row(

                  children: [

                    const Icon(

                      Icons.payments_rounded,

                      color:
                          AppColors.success,
                    ),

                    const SizedBox(
                      width: 12,
                    ),

                    Expanded(

                      child: Column(

                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [

                          Text(

                            'Total Payment',

                            style:
                                TextStyle(

                              color:
                                  Colors.grey
                                      .shade700,

                              fontSize: 13,
                            ),
                          ),

                          const SizedBox(
                            height: 4,
                          ),

                          Text(

                            AppFormat.currency(
                              order.totalPrice,
                            ),

                            style:
                                const TextStyle(

                              fontSize: 24,

                              fontWeight:
                                  FontWeight.bold,

                              color:
                                  AppColors.success,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}