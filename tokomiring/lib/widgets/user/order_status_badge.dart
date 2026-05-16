// =====================================================
// lib/widgets/user/order_status_badge.dart
// COMPACT PREMIUM VERSION
// =====================================================

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class OrderStatusBadge
    extends StatefulWidget {

  final String status;

  final bool isValidated;

  final bool animated;

  final double? fontSize;

  final EdgeInsetsGeometry?
      padding;

  const OrderStatusBadge({

    super.key,

    required this.status,

    this.isValidated = false,

    this.animated = true,

    this.fontSize,

    this.padding,
  });

  @override
  State<OrderStatusBadge>
      createState() =>
          _OrderStatusBadgeState();
}

class _OrderStatusBadgeState
    extends State<OrderStatusBadge>
    with
        SingleTickerProviderStateMixin {

  late AnimationController
      _animationController;

  late Animation<double>
      _scaleAnimation;

  @override
  void initState() {

    super.initState();

    _animationController =
        AnimationController(

      vsync: this,

      duration:
          const Duration(
        milliseconds: 300,
      ),
    );

    _scaleAnimation =
        CurvedAnimation(

      parent:
          _animationController,

      curve:
          Curves.easeOut,
    );

    if (widget.animated) {

      _animationController
          .forward();
    }
  }

  @override
  void dispose() {

    _animationController
        .dispose();

    super.dispose();
  }

  Color getStatusColor() {

    switch (
        widget.status
            .toLowerCase()) {

      case 'waiting admin validation':
        return AppColors.warning;

      case 'processing delivery':
        return AppColors.primary;

      case 'package on delivery':
        return Colors.purple;

      case 'completed':
        return AppColors.success;

      case 'rejected':
        return AppColors.danger;

      case 'cancelled':
        return AppColors.danger;

      default:
        return Colors.grey;
    }
  }

  IconData getStatusIcon() {

    switch (
        widget.status
            .toLowerCase()) {

      case 'waiting admin validation':
        return Icons
            .pending_actions_rounded;

      case 'processing delivery':
        return Icons
            .inventory_2_rounded;

      case 'package on delivery':
        return Icons
            .local_shipping_rounded;

      case 'completed':
        return Icons
            .check_circle_rounded;

      case 'rejected':
        return Icons
            .cancel_rounded;

      case 'cancelled':
        return Icons
            .close_rounded;

      default:
        return Icons.info_rounded;
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    final color =
        getStatusColor();

    final icon =
        getStatusIcon();

    final textSize =
        widget.fontSize ??
            10;

    final badgePadding =
        widget.padding ??

            const EdgeInsets.symmetric(

              horizontal: 10,

              vertical: 6,
            );

    return ScaleTransition(

      scale:
          widget.animated

              ? _scaleAnimation

              : const AlwaysStoppedAnimation(
                  1,
                ),

      child:
          AnimatedContainer(

        duration:
            const Duration(
          milliseconds: 180,
        ),

        padding:
            badgePadding,

        decoration:
            BoxDecoration(

          color:
              color.withOpacity(
            0.10,
          ),

          borderRadius:
              BorderRadius.circular(
            18,
          ),

          border: Border.all(

            color:
                color.withOpacity(
              0.16,
            ),

            width: 1,
          ),
        ),

        child: Row(

          mainAxisSize:
              MainAxisSize.min,

          children: [

            // ICON

            Container(

              width: 20,

              height: 20,

              decoration:
                  BoxDecoration(

                color:
                    color,

                shape:
                    BoxShape.circle,
              ),

              child: Icon(

                icon,

                color:
                    Colors.white,

                size: 11,
              ),
            ),

            const SizedBox(
              width: 7,
            ),

            // TEXT

            Flexible(

              child: Text(

                widget.status,

                overflow:
                    TextOverflow
                        .ellipsis,

                maxLines: 1,

                style:
                    TextStyle(

                  color:
                      color,

                  fontWeight:
                      FontWeight.w700,

                  fontSize:
                      textSize,
                ),
              ),
            ),

            // VALIDATED

            if (widget.isValidated)
              ...[

                const SizedBox(
                  width: 7,
                ),

                Container(

                  padding:
                      const EdgeInsets.symmetric(

                    horizontal: 7,

                    vertical: 4,
                  ),

                  decoration:
                      BoxDecoration(

                    color:
                        AppColors.success,

                    borderRadius:
                        BorderRadius.circular(
                      14,
                    ),
                  ),

                  child: Row(

                    mainAxisSize:
                        MainAxisSize.min,

                    children: const [

                      Icon(

                        Icons
                            .verified_rounded,

                        color:
                            Colors.white,

                        size: 10,
                      ),

                      SizedBox(
                        width: 4,
                      ),

                      Text(

                        'Validated',

                        style:
                            TextStyle(

                          color:
                              Colors.white,

                          fontWeight:
                              FontWeight.bold,

                          fontSize:
                              8,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
          ],
        ),
      ),
    );
  }
}