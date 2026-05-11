// lib/widgets/buttons/category_button.dart

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class CategoryButton
    extends StatelessWidget {

  final String title;

  final bool isSelected;

  final VoidCallback onTap;

  final IconData? icon;

  final EdgeInsetsGeometry? margin;

  // =====================================================
  // CONSTRUCTOR
  // =====================================================

  const CategoryButton({

    super.key,

    required this.title,

    required this.isSelected,

    required this.onTap,

    this.icon,

    this.margin,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    return Padding(

      padding:
          margin ??

              const EdgeInsets.only(
            right: 12,
          ),

      child: GestureDetector(

        onTap:
            onTap,

        child:
            AnimatedContainer(

          duration:
              const Duration(
            milliseconds: 250,
          ),

          curve:
              Curves.easeOut,

          padding:
              const EdgeInsets.symmetric(

            horizontal: 18,

            vertical: 12,
          ),

          decoration:
              BoxDecoration(

            gradient:
                isSelected

                    ? const LinearGradient(

                        colors: [

                          Color(0xff2563EB),

                          Color(0xff1D4ED8),
                        ],
                      )

                    : null,

            color:
                isSelected

                    ? null

                    : Colors.white,

            borderRadius:
                BorderRadius.circular(
              18,
            ),

            border:
                Border.all(

              color:
                  isSelected

                      ? AppColors.primary

                      : Colors.grey
                          .shade300,
            ),

            boxShadow: [

              BoxShadow(

                color:
                    isSelected

                        ? AppColors.primary
                            .withOpacity(
                          0.22,
                        )

                        : Colors.black
                            .withOpacity(
                          0.04,
                        ),

                blurRadius:
                    isSelected
                        ? 18
                        : 8,

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

              // =========================================
              // ICON
              // =========================================

              if (icon != null) ...[

                Icon(

                  icon,

                  size: 18,

                  color:
                      isSelected

                          ? Colors.white

                          : AppColors.dark,
                ),

                const SizedBox(
                  width: 8,
                ),
              ],

              // =========================================
              // TITLE
              // =========================================

              AnimatedDefaultTextStyle(

                duration:
                    const Duration(
                  milliseconds: 250,
                ),

                style: TextStyle(

                  color:
                      isSelected

                          ? Colors.white

                          : AppColors.dark,

                  fontWeight:
                      FontWeight.bold,

                  fontSize: 14,
                ),

                child: Text(
                  title,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}