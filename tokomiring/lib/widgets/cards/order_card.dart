// lib/widgets/cards/order_card.dart

import 'package:flutter/material.dart';

import '../../models/order_model.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_format.dart';

class OrderCard
    extends StatefulWidget {

  final OrderModel order;

  final VoidCallback? onTap;

  const OrderCard({

    super.key,

    required this.order,

    this.onTap,
  });

  @override
  State<OrderCard>
      createState() =>
          _OrderCardState();
}

class _OrderCardState
    extends State<OrderCard> {

  bool hovered = false;

  // =====================================================
  // STATUS COLOR
  // =====================================================

  Color getStatusColor() {

    switch (
        widget.order.status) {

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

      case 'Rejected':
        return AppColors.danger;

      default:
        return Colors.grey;
    }
  }

  // =====================================================
  // STATUS ICON
  // =====================================================

  IconData getStatusIcon() {

    switch (
        widget.order.status) {

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

      case 'Rejected':
        return Icons.close_rounded;

      default:
        return Icons.info_rounded;
    }
  }

  // =====================================================
  // PAYMENT STATUS
  // =====================================================

  String paymentStatus() {

    if (widget.order
        .isValidated) {

      return 'Validated';
    }

    if (widget.order
            .status ==
        'Rejected') {

      return 'Rejected';
    }

    return 'Pending';
  }

  // =====================================================
  // PAYMENT COLOR
  // =====================================================

  Color paymentColor() {

    if (widget.order
        .isValidated) {

      return AppColors.success;
    }

    if (widget.order
            .status ==
        'Rejected') {

      return AppColors.danger;
    }

    return AppColors.warning;
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(
    BuildContext context,
  ) {

    final statusColor =
        getStatusColor();

    return MouseRegion(

      onEnter: (_) {

        setState(() {

          hovered = true;
        });
      },

      onExit: (_) {

        setState(() {

          hovered = false;
        });
      },

      child:
          AnimatedScale(

        duration:
            const Duration(
          milliseconds: 220,
        ),

        scale:
            hovered
                ? 1.01
                : 1,

        child:
            Material(

          color:
              Colors.transparent,

          child: InkWell(

            borderRadius:
                BorderRadius.circular(
              30,
            ),

            onTap:
                widget.onTap,

            child:
                AnimatedContainer(

              duration:
                  const Duration(
                milliseconds:
                    220,
              ),

              margin:
                  const EdgeInsets.only(
                bottom: 20,
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
                  30,
                ),

                boxShadow: [

                  BoxShadow(

                    color:
                        hovered

                            ? Colors.black
                                .withOpacity(
                              0.08,
                            )

                            : Colors.black
                                .withOpacity(
                              0.04,
                            ),

                    blurRadius:
                        hovered
                            ? 24
                            : 16,

                    offset:
                        Offset(
                      0,
                      hovered
                          ? 14
                          : 8,
                    ),
                  ),
                ],
              ),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  // =========================================
                  // TOP SECTION
                  // =========================================

                  Row(

                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [

                      Expanded(

                        child: Column(

                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            Text(

                              'Order #${widget.order.orderId.substring(0, 8)}',

                              maxLines: 1,

                              overflow:
                                  TextOverflow
                                      .ellipsis,

                              style:
                                  const TextStyle(

                                fontSize:
                                    20,

                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                              height: 6,
                            ),

                            Text(

                              AppFormat.date(
                                widget.order
                                    .createdAt,
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
                          ],
                        ),
                      ),

                      const SizedBox(
                        width: 10,
                      ),

                      AnimatedContainer(

                        duration:
                            const Duration(
                          milliseconds:
                              220,
                        ),

                        padding:
                            const EdgeInsets.symmetric(

                          horizontal:
                              14,

                          vertical:
                              10,
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
                            18,
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

                              widget
                                  .order
                                  .status,

                              style:
                                  TextStyle(

                                color:
                                    statusColor,

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
                  ),

                  const SizedBox(
                    height: 22,
                  ),

                  // =========================================
                  // CUSTOMER
                  // =========================================

                  Row(

                    children: [

                      Container(

                        width: 52,

                        height: 52,

                        decoration:
                            BoxDecoration(

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

                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),
                        ),

                        child:
                            const Icon(

                          Icons
                              .person_rounded,

                          color:
                              AppColors
                                  .primary,
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

                              widget.order
                                  .customerName,

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

                            const SizedBox(
                              height: 4,
                            ),

                            Text(

                              '${widget.order.totalItems} items',

                              style:
                                  TextStyle(

                                color:
                                    Colors
                                        .grey
                                        .shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 24,
                  ),

                  // =========================================
                  // PAYMENT STATUS
                  // =========================================

                  Row(

                    children: [

                      Expanded(

                        child: Container(

                          padding:
                              const EdgeInsets.all(
                            16,
                          ),

                          decoration:
                              BoxDecoration(

                            color:
                                paymentColor()
                                    .withOpacity(
                              0.1,
                            ),

                            borderRadius:
                                BorderRadius.circular(
                              20,
                            ),
                          ),

                          child: Column(

                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [

                              Row(

                                children: [

                                  Icon(

                                    Icons
                                        .verified_user_rounded,

                                    size: 18,

                                    color:
                                        paymentColor(),
                                  ),

                                  const SizedBox(
                                    width:
                                        8,
                                  ),

                                  Text(

                                    'Validation',

                                    style:
                                        TextStyle(

                                      color:
                                          Colors
                                              .grey
                                              .shade700,

                                      fontSize:
                                          13,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              AnimatedContainer(

                                duration:
                                    const Duration(
                                  milliseconds:
                                      220,
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
                                      paymentColor(),

                                  borderRadius:
                                      BorderRadius.circular(
                                    30,
                                  ),
                                ),

                                child: Text(

                                  paymentStatus(),

                                  style:
                                      const TextStyle(

                                    color:
                                        Colors.white,

                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 16,
                      ),

                      Expanded(

                        child: Container(

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
                              20,
                            ),
                          ),

                          child: Column(

                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [

                              Row(

                                children: [

                                  const Icon(

                                    Icons
                                        .payments_rounded,

                                    size: 18,

                                    color:
                                        AppColors
                                            .success,
                                  ),

                                  const SizedBox(
                                    width:
                                        8,
                                  ),

                                  Text(

                                    'Payment',

                                    style:
                                        TextStyle(

                                      color:
                                          Colors
                                              .grey
                                              .shade700,

                                      fontSize:
                                          13,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              Text(

                                AppFormat.currency(
                                  widget.order
                                      .totalPrice,
                                ),

                                maxLines: 1,

                                overflow:
                                    TextOverflow
                                        .ellipsis,

                                style:
                                    const TextStyle(

                                  fontSize:
                                      22,

                                  fontWeight:
                                      FontWeight.bold,

                                  color:
                                      AppColors
                                          .success,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 22,
                  ),

                  // =========================================
                  // ORDER DETAIL
                  // =========================================

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
                          const Color(
                        0xffF8FAFC,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        22,
                      ),
                    ),

                    child: Column(

                      children: [

                        _buildDetailRow(

                          'Payment Method',

                          widget.order
                              .paymentMethod,
                        ),

                        const SizedBox(
                          height: 14,
                        ),

                        _buildDetailRow(

                          'Phone Number',

                          widget.order
                              .customerPhone,
                        ),

                        const SizedBox(
                          height: 14,
                        ),

                        _buildDetailRow(

                          'Address',

                          widget.order
                              .address,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // =====================================================
  // DETAIL ROW
  // =====================================================

  Widget _buildDetailRow(

    String title,

    String value,
  ) {

    return Row(

      crossAxisAlignment:
          CrossAxisAlignment
              .start,

      children: [

        Expanded(

          flex: 2,

          child: Text(

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
        ),

        const SizedBox(
          width: 12,
        ),

        Expanded(

          flex: 3,

          child: Text(

            value,

            textAlign:
                TextAlign.right,

            style:
                const TextStyle(

              fontWeight:
                  FontWeight.bold,

              fontSize:
                  14,
            ),
          ),
        ),
      ],
    );
  }
}