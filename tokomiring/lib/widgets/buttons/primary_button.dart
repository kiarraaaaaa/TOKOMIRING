// lib/widgets/buttons/primary_button.dart

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class PrimaryButton
    extends StatelessWidget {

  final String text;

  final VoidCallback? onPressed;

  final bool isLoading;

  final IconData? icon;

  final double height;

  final double borderRadius;

  final Color backgroundColor;

  final Color foregroundColor;

  final bool isExpanded;

  final EdgeInsetsGeometry padding;

  final double elevation;

  final double fontSize;

  // =====================================================
  // CONSTRUCTOR
  // =====================================================

  const PrimaryButton({

    super.key,

    required this.text,

    required this.onPressed,

    this.isLoading =
        false,

    this.icon,

    this.height =
        56,

    this.borderRadius =
        18,

    this.backgroundColor =
        AppColors.primary,

    this.foregroundColor =
        Colors.white,

    this.isExpanded =
        true,

    this.padding =
        const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 16,
    ),

    this.elevation =
        0,

    this.fontSize =
        16,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    final button =
        ElevatedButton(

      onPressed:
          isLoading
              ? null
              : onPressed,

      style:
          ElevatedButton.styleFrom(

        elevation:
            elevation,

        backgroundColor:
            backgroundColor,

        foregroundColor:
            foregroundColor,

        disabledBackgroundColor:
            backgroundColor
                .withOpacity(
          0.7,
        ),

        disabledForegroundColor:
            foregroundColor,

        padding:
            padding,

        minimumSize:
            Size(
          0,
          height,
        ),

        shape:
            RoundedRectangleBorder(

          borderRadius:
              BorderRadius.circular(
            borderRadius,
          ),
        ),
      ),

      child:
          AnimatedSwitcher(

        duration:
            const Duration(
          milliseconds: 250,
        ),

        child:
            isLoading

                ? SizedBox(

                    key:
                        const ValueKey(
                      'loading',
                    ),

                    height: 24,

                    width: 24,

                    child:
                        CircularProgressIndicator(

                      color:
                          foregroundColor,

                      strokeWidth:
                          2.5,
                    ),
                  )

                : Row(

                    key:
                        const ValueKey(
                      'content',
                    ),

                    mainAxisAlignment:
                        MainAxisAlignment
                            .center,

                    mainAxisSize:
                        MainAxisSize.min,

                    children: [

                      // ===============================
                      // ICON
                      // ===============================

                      if (icon != null) ...[

                        Icon(
                          icon,
                        ),

                        const SizedBox(
                          width: 10,
                        ),
                      ],

                      // ===============================
                      // TEXT
                      // ===============================

                      Flexible(

                        child: Text(

                          text,

                          overflow:
                              TextOverflow
                                  .ellipsis,

                          style:
                              TextStyle(

                            fontSize:
                                fontSize,

                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );

    // ===================================================
    // EXPANDED
    // ===================================================

    if (isExpanded) {

      return SizedBox(

        width:
            double.infinity,

        height:
            height,

        child:
            button,
      );
    }

    return SizedBox(

      height:
          height,

      child:
          button,
    );
  }
}