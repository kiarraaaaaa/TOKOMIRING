// =====================================================
// lib/widgets/forms/quantity_selector.dart
// COMPACT PREMIUM SMALL VERSION
// =====================================================

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class QuantitySelector
    extends StatelessWidget {

  final int quantity;

  final VoidCallback onIncrease;

  final VoidCallback onDecrease;

  final int? maxQuantity;

  final bool enabled;

  const QuantitySelector({

    super.key,

    required this.quantity,

    required this.onIncrease,

    required this.onDecrease,

    this.maxQuantity,

    this.enabled = true,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    final bool canDecrease =
        quantity > 1 &&
            enabled;

    final bool canIncrease =
        enabled &&
            (maxQuantity ==
                    null ||

                quantity <
                    maxQuantity!);

    return Container(

      padding:
          const EdgeInsets.symmetric(

        horizontal: 7,

        vertical: 6,
      ),

      decoration:
          BoxDecoration(

        color:
            Colors.white,

        borderRadius:
            BorderRadius.circular(
          16,
        ),

        border:
            Border.all(

          color:
              Colors.grey
                  .shade300,

          width: 1,
        ),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black
                    .withOpacity(
              0.025,
            ),

            blurRadius: 8,

            offset:
                const Offset(
              0,
              4,
            ),
          ),
        ],
      ),

      child: Row(

        mainAxisSize:
            MainAxisSize.min,

        children: [

          // =========================================
          // DECREASE
          // =========================================

          _actionButton(

            icon:
                Icons.remove_rounded,

            onTap:
                canDecrease

                    ? onDecrease

                    : null,

            enabled:
                canDecrease,
          ),

          // =========================================
          // QUANTITY TEXT
          // =========================================

          Container(

            constraints:
                const BoxConstraints(

              minWidth: 34,
            ),

            alignment:
                Alignment.center,

            child: Text(

              quantity.toString(),

              style:
                  const TextStyle(

                fontSize: 14,

                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),

          // =========================================
          // INCREASE
          // =========================================

          _actionButton(

            icon:
                Icons.add_rounded,

            onTap:
                canIncrease

                    ? onIncrease

                    : null,

            enabled:
                canIncrease,
          ),
        ],
      ),
    );
  }

  // =====================================================
  // ACTION BUTTON
  // =====================================================

  Widget _actionButton({

    required IconData icon,

    required VoidCallback? onTap,

    required bool enabled,
  }) {

    return Material(

      color:
          Colors.transparent,

      child: InkWell(

        borderRadius:
            BorderRadius.circular(
          10,
        ),

        onTap:
            onTap,

        child:
            AnimatedContainer(

          duration:
              const Duration(
            milliseconds: 180,
          ),

          width: 30,

          height: 30,

          decoration:
              BoxDecoration(

            color:

                enabled

                    ? AppColors
                        .primary
                        .withOpacity(
                      0.10,
                    )

                    : Colors.grey
                        .shade100,

            borderRadius:
                BorderRadius.circular(
              10,
            ),
          ),

          child: Icon(

            icon,

            size: 16,

            color:

                enabled

                    ? AppColors
                        .primary

                    : Colors.grey
                        .shade400,
          ),
        ),
      ),
    );
  }
}