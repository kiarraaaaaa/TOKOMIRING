// lib/widgets/user/order_status_badge.dart

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
        milliseconds: 450,
      ),
    );

    _scaleAnimation =
        CurvedAnimation(

      parent:
          _animationController,

      curve:
          Curves.easeOutBack,
    );

    if (widget.animated) {

      _animationController
          .forward();
    }
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
  // STATUS COLOR
  // =====================================================

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

  // =====================================================
  // STATUS ICON
  // =====================================================

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

  // =====================================================
  // BUILD
  // =====================================================

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
            12;

    final badgePadding =
        widget.padding ??

            const EdgeInsets.symmetric(

              horizontal: 14,

              vertical: 9,
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
          milliseconds: 250,
        ),

        padding:
            badgePadding,

        decoration:
            BoxDecoration(

          color:
              color.withOpacity(
            0.12,
          ),

          borderRadius:
              BorderRadius.circular(
            30,
          ),

          border: Border.all(

            color:
                color.withOpacity(
              0.22,
            ),
          ),

          boxShadow: [

            BoxShadow(

              color:
                  color.withOpacity(
                0.12,
              ),

              blurRadius:
                  12,
            ),
          ],
        ),

        child: Row(

          mainAxisSize:
              MainAxisSize.min,

          children: [

            // =============================================
            // ICON
            // =============================================

            AnimatedContainer(

              duration:
                  const Duration(
                milliseconds:
                    250,
              ),

              width: 26,

              height: 26,

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

                size: 15,
              ),
            ),

            const SizedBox(
              width: 10,
            ),

            // =============================================
            // TEXT
            // =============================================

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
                      FontWeight.bold,

                  fontSize:
                      textSize,
                ),
              ),
            ),

            // =============================================
            // VALIDATED
            // =============================================

            if (widget.isValidated)
              ...[

                const SizedBox(
                  width: 10,
                ),

                Container(

                  padding:
                      const EdgeInsets.symmetric(

                    horizontal: 10,

                    vertical: 6,
                  ),

                  decoration:
                      BoxDecoration(

                    color:
                        AppColors.success,

                    borderRadius:
                        BorderRadius.circular(
                      20,
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

                        size: 14,
                      ),

                      SizedBox(
                        width: 5,
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
                              10,
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