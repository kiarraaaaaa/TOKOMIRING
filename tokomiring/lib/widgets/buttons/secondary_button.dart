// lib/widgets/buttons/secondary_button.dart

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class SecondaryButton
    extends StatelessWidget {

  final String text;

  final VoidCallback? onPressed;

  final IconData? icon;

  final bool isLoading;

  final bool isExpanded;

  final double height;

  final double borderRadius;

  final double fontSize;

  final Color borderColor;

  final Color foregroundColor;

  final Color backgroundColor;

  final double borderWidth;

  final EdgeInsetsGeometry padding;

  // =====================================================
  // CONSTRUCTOR
  // =====================================================

  const SecondaryButton({

    super.key,

    required this.text,

    required this.onPressed,

    this.icon,

    this.isLoading =
        false,

    this.isExpanded =
        true,

    this.height =
        56,

    this.borderRadius =
        18,

    this.fontSize =
        15,

    this.borderColor =
        AppColors.primary,

    this.foregroundColor =
        AppColors.primary,

    this.backgroundColor =
        Colors.transparent,

    this.borderWidth =
        1.5,

    this.padding =
        const EdgeInsets.symmetric(

      horizontal: 20,

      vertical: 16,
    ),
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    final button =
        OutlinedButton(

      onPressed:
          isLoading
              ? null
              : onPressed,

      style:
          OutlinedButton.styleFrom(

        backgroundColor:
            backgroundColor,

        foregroundColor:
            foregroundColor,

        disabledForegroundColor:
            foregroundColor
                .withOpacity(
          0.6,
        ),

        side:
            BorderSide(

          color:
              borderColor,

          width:
              borderWidth,
        ),

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

                    width: 22,

                    height: 22,

                    child:
                        CircularProgressIndicator(

                      strokeWidth:
                          2.2,

                      color:
                          foregroundColor,
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

                          size: 20,

                          color:
                              foregroundColor,
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

                            color:
                                foregroundColor,

                            fontWeight:
                                FontWeight.bold,

                            fontSize:
                                fontSize,
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