// =====================================================
// lib/widgets/forms/payment_method_selector.dart
// FINAL COMPACT PREMIUM VERSION
// =====================================================

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class PaymentMethodSelector
    extends StatelessWidget {

  final String selectedMethod;

  final Function(String)
      onChanged;

  const PaymentMethodSelector({

    super.key,

    required this.selectedMethod,

    required this.onChanged,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    return Column(

      children: [

        paymentTile(

          title:
              'Cash',

          subtitle:
              'Pay when order arrives',

          icon:
              Icons.payments_rounded,

          value:
              'Cash',

          color:
              AppColors.success,
        ),

        const SizedBox(
          height: 12,
        ),

        paymentTile(

          title:
              'QRIS',

          subtitle:
              'Instant QR payment',

          icon:
              Icons.qr_code_rounded,

          value:
              'QRIS',

          color:
              AppColors.primary,
        ),
      ],
    );
  }

  // =====================================================
  // PAYMENT TILE
  // =====================================================

  Widget paymentTile({

    required String title,

    required String subtitle,

    required IconData icon,

    required String value,

    required Color color,
  }) {

    final isSelected =
        selectedMethod ==
            value;

    return GestureDetector(

      onTap: () {

        onChanged(
          value,
        );
      },

      child:
          AnimatedContainer(

        duration:
            const Duration(
          milliseconds:
              220,
        ),

        padding:
            const EdgeInsets.symmetric(

          horizontal: 14,

          vertical: 14,
        ),

        decoration:
            BoxDecoration(

          color:

              isSelected

                  ? color.withOpacity(
                      0.08,
                    )

                  : Colors.white,

          borderRadius:
              BorderRadius.circular(
            18,
          ),

          border:
              Border.all(

            color:

                isSelected

                    ? color

                    : Colors.grey
                        .shade300,

            width:
                isSelected
                    ? 1.6
                    : 1,
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

        child: Row(

          children: [

            // =====================================
            // ICON
            // =====================================

            Container(

              width: 46,

              height: 46,

              decoration:
                  BoxDecoration(

                color:
                    color.withOpacity(
                  0.12,
                ),

                borderRadius:
                    BorderRadius.circular(
                  14,
                ),
              ),

              child: Icon(

                icon,

                color:
                    color,

                size: 24,
              ),
            ),

            const SizedBox(
              width: 14,
            ),

            // =====================================
            // TEXT
            // =====================================

            Expanded(

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  Text(

                    title,

                    overflow:
                        TextOverflow
                            .ellipsis,

                    style:
                        const TextStyle(

                      fontSize: 14,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 3,
                  ),

                  Text(

                    subtitle,

                    maxLines: 1,

                    overflow:
                        TextOverflow
                            .ellipsis,

                    style:
                        TextStyle(

                      fontSize: 11,

                      color:
                          Colors.grey
                              .shade600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              width: 10,
            ),

            // =====================================
            // RADIO
            // =====================================

            AnimatedContainer(

              duration:
                  const Duration(
                milliseconds:
                    220,
              ),

              width: 22,

              height: 22,

              decoration:
                  BoxDecoration(

                shape:
                    BoxShape.circle,

                color:

                    isSelected

                        ? color

                        : Colors
                            .transparent,

                border:
                    Border.all(

                  color:

                      isSelected

                          ? color

                          : Colors.grey
                              .shade400,

                  width: 1.8,
                ),
              ),

              child:

                  isSelected

                      ? const Icon(

                          Icons.check,

                          color:
                              Colors.white,

                          size: 13,
                        )

                      : null,
            ),
          ],
        ),
      ),
    );
  }
}