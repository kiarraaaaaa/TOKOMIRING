// lib/widgets/forms/payment_method_selector.dart

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class PaymentMethodSelector
    extends StatelessWidget {

  final String selectedMethod;

  final Function(String)
      onChanged;

  // =====================================================
  // CONSTRUCTOR
  // =====================================================

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

        // ===============================================
        // CASH
        // ===============================================

        paymentTile(

          title:
              'Cash',

          subtitle:
              'Pay directly when the order arrives',

          icon:
              Icons.payments_rounded,

          value:
              'Cash',

          color:
              AppColors.success,
        ),

        const SizedBox(
          height: 16,
        ),

        // ===============================================
        // QRIS
        // ===============================================

        paymentTile(

          title:
              'QRIS',

          subtitle:
              'Scan QR code for instant payment',

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

      child: AnimatedContainer(

        duration:
            const Duration(
          milliseconds: 250,
        ),

        padding:
            const EdgeInsets.all(
          18,
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
            24,
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
                    ? 2
                    : 1.2,
          ),

          boxShadow: [

            BoxShadow(

              color:
                  Colors.black
                      .withOpacity(
                0.04,
              ),

              blurRadius:
                  14,

              offset:
                  const Offset(
                0,
                8,
              ),
            ),
          ],
        ),

        child: Row(

          children: [

            // =========================================
            // ICON
            // =========================================

            Container(

              width: 56,

              height: 56,

              decoration:
                  BoxDecoration(

                color:
                    color.withOpacity(
                  0.12,
                ),

                borderRadius:
                    BorderRadius.circular(
                  18,
                ),
              ),

              child: Icon(

                icon,

                color:
                    color,

                size: 30,
              ),
            ),

            const SizedBox(
              width: 18,
            ),

            // =========================================
            // TEXT
            // =========================================

            Expanded(

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  Text(

                    title,

                    style:
                        const TextStyle(

                      fontSize: 17,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 6,
                  ),

                  Text(

                    subtitle,

                    style:
                        TextStyle(

                      color:
                          Colors.grey
                              .shade600,

                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              width: 12,
            ),

            // =========================================
            // RADIO
            // =========================================

            AnimatedContainer(

              duration:
                  const Duration(
                milliseconds: 220,
              ),

              width: 26,

              height: 26,

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

                  width: 2,
                ),
              ),

              child:
                  isSelected

                      ? const Icon(

                          Icons.check,

                          color:
                              Colors.white,

                          size: 16,
                        )

                      : null,
            ),
          ],
        ),
      ),
    );
  }
}