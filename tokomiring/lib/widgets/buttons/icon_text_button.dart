// lib/widgets/buttons/icon_text_button.dart

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class IconTextButton
    extends StatelessWidget {

  final String text;

  final IconData icon;

  final VoidCallback? onPressed;

  final Color color;

  final Color foregroundColor;

  final double borderRadius;

  final double height;

  final bool isLoading;

  final bool isExpanded;

  final double iconSize;

  final EdgeInsetsGeometry padding;

  // =====================================================
  // CONSTRUCTOR
  // =====================================================

  const IconTextButton({

    super.key,

    required this.text,

    required this.icon,

    required this.onPressed,

    this.color =
        AppColors.primary,

    this.foregroundColor =
        Colors.white,

    this.borderRadius =
        18,

    this.height =
        56,

    this.isLoading =
        false,

    this.isExpanded =
        false,

    this.iconSize =
        20,

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
        ElevatedButton.icon(

      onPressed:
          isLoading

              ? null

              : onPressed,

      icon:
          isLoading

              ? SizedBox(

                  width: 18,

                  height: 18,

                  child:
                      CircularProgressIndicator(

                    color:
                        foregroundColor,

                    strokeWidth:
                        2,
                  ),
                )

              : Icon(

                  icon,

                  size:
                      iconSize,
                ),

      label:
          Text(

        text,

        style:
            const TextStyle(

          fontSize: 15,

          fontWeight:
              FontWeight.bold,
        ),
      ),

      style:
          ElevatedButton.styleFrom(

        elevation: 0,

        backgroundColor:
            color,

        foregroundColor:
            foregroundColor,

        disabledBackgroundColor:
            color.withOpacity(
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