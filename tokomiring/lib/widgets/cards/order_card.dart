// =====================================================
// lib/widgets/cards/order_card.dart
// ULTRA COMPACT MODERN TRANSACTION CARD
// PREMIUM AESTHETIC VERSION
// =====================================================

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
        return Icons.schedule_rounded;

      case 'Processing Delivery':
        return Icons.inventory_2_rounded;

      case 'Package On Delivery':
        return Icons.local_shipping_rounded;

      case 'Completed':
        return Icons.check_circle_rounded;

      case 'Cancelled':
      case 'Rejected':
        return Icons.cancel_rounded;

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

    final width =
        MediaQuery.of(context)
            .size
            .width;

    final isMobile =
        width < 700;

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
          AnimatedContainer(

        duration:
            const Duration(
          milliseconds: 220,
        ),

        transform:
            Matrix4.identity()
              ..translate(
                0.0,
                hovered ? -3 : 0,
              ),

        child: Material(

          color:
              Colors.transparent,

          child: InkWell(

            borderRadius:
                BorderRadius.circular(
              24,
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
                bottom: 14,
              ),

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
                  24,
                ),

                border: Border.all(

                  color:

                      hovered

                          ? statusColor
                              .withOpacity(
                            0.08,
                          )

                          : Colors.grey
                              .shade100,
                ),

                boxShadow: [

                  BoxShadow(

                    color:
                        Colors.black
                            .withOpacity(
                      hovered
                          ? 0.06
                          : 0.03,
                    ),

                    blurRadius:
                        hovered
                            ? 20
                            : 12,

                    offset:
                        Offset(
                      0,
                      hovered
                          ? 10
                          : 6,
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
                                    15,

                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                              height: 4,
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
                                    11,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        width: 8,
                      ),

                      Container(

                        padding:
                            const EdgeInsets.symmetric(

                          horizontal:
                              10,

                          vertical:
                              6,
                        ),

                        decoration:
                            BoxDecoration(

                          color:
                              statusColor
                                  .withOpacity(
                            0.10,
                          ),

                          borderRadius:
                              BorderRadius.circular(
                            12,
                          ),
                        ),

                        child: Row(

                          mainAxisSize:
                              MainAxisSize.min,

                          children: [

                            Icon(

                              getStatusIcon(),

                              size: 13,

                              color:
                                  statusColor,
                            ),

                            const SizedBox(
                              width: 5,
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
                                    10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  // =========================================
                  // CUSTOMER
                  // =========================================

                  Row(

                    children: [

                      Container(

                        width: 42,

                        height: 42,

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
                            14,
                          ),
                        ),

                        child:
                            const Icon(

                          Icons
                              .person_rounded,

                          color:
                              AppColors
                                  .primary,

                          size: 18,
                        ),
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
                                    13,
                              ),
                            ),

                            const SizedBox(
                              height: 2,
                            ),

                            Text(

                              '${widget.order.totalItems} items',

                              style:
                                  TextStyle(

                                color:
                                    Colors
                                        .grey
                                        .shade600,

                                fontSize:
                                    11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  // =========================================
                  // PAYMENT & VALIDATION
                  // =========================================

                  Row(

                    children: [

                      Expanded(

                        child: Container(

                          padding:
                              const EdgeInsets.all(
                            12,
                          ),

                          decoration:
                              BoxDecoration(

                            color:
                                paymentColor()
                                    .withOpacity(
                              0.08,
                            ),

                            borderRadius:
                                BorderRadius.circular(
                              18,
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

                                    size: 14,

                                    color:
                                        paymentColor(),
                                  ),

                                  const SizedBox(
                                    width:
                                        5,
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
                                          10,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 8,
                              ),

                              Container(

                                padding:
                                    const EdgeInsets.symmetric(

                                  horizontal:
                                      10,

                                  vertical:
                                      5,
                                ),

                                decoration:
                                    BoxDecoration(

                                  color:
                                      paymentColor(),

                                  borderRadius:
                                      BorderRadius.circular(
                                    20,
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

                                    fontSize:
                                        10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 10,
                      ),

                      Expanded(

                        child: Container(

                          padding:
                              const EdgeInsets.all(
                            12,
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

                                    size: 14,

                                    color:
                                        AppColors
                                            .success,
                                  ),

                                  const SizedBox(
                                    width:
                                        5,
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
                                          10,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 8,
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
                                      16,

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
                    height: 16,
                  ),

                  // =========================================
                  // ORDER DETAIL
                  // =========================================

                  Container(

                    width:
                        double.infinity,

                    padding:
                        const EdgeInsets.all(
                      14,
                    ),

                    decoration:
                        BoxDecoration(

                      gradient:
                          const LinearGradient(

                        begin:
                            Alignment.topLeft,

                        end:
                            Alignment.bottomRight,

                        colors: [

                          Color(
                            0xffFAFBFC,
                          ),

                          Colors.white,
                        ],
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),
                    ),

                    child: Column(

                      children: [

                        _buildDetailRow(

                          'Payment',

                          widget.order
                              .paymentMethod,
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        _buildDetailRow(

                          'Phone',

                          widget.order
                              .customerPhone,
                        ),

                        const SizedBox(
                          height: 10,
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

        SizedBox(

          width: 70,

          child: Text(

            title,

            style: TextStyle(

              color:
                  Colors
                      .grey
                      .shade600,

              fontSize:
                  11,
            ),
          ),
        ),

        Expanded(

          child: Text(

            value,

            textAlign:
                TextAlign.right,

            maxLines: 2,

            overflow:
                TextOverflow
                    .ellipsis,

            style:
                const TextStyle(

              fontWeight:
                  FontWeight.bold,

              fontSize:
                  12,
            ),
          ),
        ),
      ],
    );
  }
}