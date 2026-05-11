// lib/widgets/forms/quantity_selector.dart

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class QuantitySelector
    extends StatelessWidget {

  final int quantity;

  final VoidCallback onIncrease;

  final VoidCallback onDecrease;

  final int? maxQuantity;

  final bool enabled;

  // =====================================================
  // CONSTRUCTOR
  // =====================================================

  const QuantitySelector({

    super.key,

    required this.quantity,

    required this.onIncrease,

    required this.onDecrease,

    this.maxQuantity,

    this.enabled =
        true,
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

        horizontal: 10,

        vertical: 8,
      ),

      decoration:
          BoxDecoration(

        color:
            Colors.white,

        borderRadius:
            BorderRadius.circular(
          20,
        ),

        border:
            Border.all(

          color:
              Colors.grey
                  .shade300,
        ),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black
                    .withOpacity(
              0.04,
            ),

            blurRadius:
                12,

            offset:
                const Offset(
              0,
              6,
            ),
          ),
        ],
      ),

      child: Row(

        mainAxisSize:
            MainAxisSize.min,

        children: [

          // =============================================
          // DECREASE BUTTON
          // =============================================

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

          // =============================================
          // QUANTITY
          // =============================================

          Container(

            constraints:
                const BoxConstraints(

              minWidth: 52,
            ),

            alignment:
                Alignment.center,

            child: Text(

              quantity.toString(),

              style:
                  const TextStyle(

                fontSize: 20,

                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),

          // =============================================
          // INCREASE BUTTON
          // =============================================

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
          14,
        ),

        onTap:
            onTap,

        child: AnimatedContainer(

          duration:
              const Duration(
            milliseconds: 200,
          ),

          width: 42,

          height: 42,

          decoration:
              BoxDecoration(

            color:
                enabled

                    ? AppColors.primary
                        .withOpacity(
                      0.1,
                    )

                    : Colors.grey
                        .shade100,

            borderRadius:
                BorderRadius.circular(
              14,
            ),
          ),

          child: Icon(

            icon,

            color:
                enabled

                    ? AppColors.primary

                    : Colors.grey
                        .shade400,
          ),
        ),
      ),
    );
  }
}