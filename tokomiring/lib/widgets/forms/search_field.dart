// lib/widgets/forms/search_field.dart

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class SearchField
    extends StatelessWidget {

  final Function(String)
      onChanged;

  final TextEditingController?
      controller;

  final String hintText;

  final VoidCallback? onFilterTap;

  final VoidCallback? onClear;

  final bool autofocus;

  final bool enabled;

  // =====================================================
  // CONSTRUCTOR
  // =====================================================

  const SearchField({

    super.key,

    required this.onChanged,

    this.controller,

    this.hintText =
        'Search products...',

    this.onFilterTap,

    this.onClear,

    this.autofocus =
        false,

    this.enabled =
        true,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    return Container(

      decoration:
          BoxDecoration(

        borderRadius:
            BorderRadius.circular(
          22,
        ),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black
                    .withOpacity(
              0.04,
            ),

            blurRadius:
                16,

            offset:
                const Offset(
              0,
              8,
            ),
          ),
        ],
      ),

      child: TextField(

        controller:
            controller,

        onChanged:
            onChanged,

        autofocus:
            autofocus,

        enabled:
            enabled,

        style:
            const TextStyle(

          fontSize: 15,
        ),

        decoration:
            InputDecoration(

          hintText:
              hintText,

          hintStyle:
              TextStyle(

            color:
                Colors.grey
                    .shade500,
          ),

          filled: true,

          fillColor:
              Colors.white,

          contentPadding:
              const EdgeInsets.symmetric(

            horizontal: 20,

            vertical: 18,
          ),

          // ===========================================
          // PREFIX ICON
          // ===========================================

          prefixIcon:
              const Padding(

            padding:
                EdgeInsets.only(
              left: 10,
            ),

            child: Icon(

              Icons.search_rounded,

              color:
                  AppColors.primary,

              size: 26,
            ),
          ),

          // ===========================================
          // SUFFIX ICON
          // ===========================================

          suffixIcon:
              Row(

            mainAxisSize:
                MainAxisSize.min,

            children: [

              // =====================================
              // CLEAR BUTTON
              // =====================================

              if (controller !=
                      null &&
                  controller!
                      .text
                      .isNotEmpty)

                IconButton(

                  onPressed: () {

                    controller!
                        .clear();

                    onChanged('');

                    if (onClear !=
                        null) {

                      onClear!();
                    }
                  },

                  icon:
                      Icon(

                    Icons
                        .close_rounded,

                    color:
                        Colors.grey
                            .shade500,
                  ),
                ),

              // =====================================
              // FILTER BUTTON
              // =====================================

              if (onFilterTap !=
                  null)

                Padding(

                  padding:
                      const EdgeInsets.only(
                    right: 10,
                  ),

                  child: Material(

                    color:
                        Colors.transparent,

                    child: InkWell(

                      borderRadius:
                          BorderRadius.circular(
                        14,
                      ),

                      onTap:
                          onFilterTap,

                      child: Container(

                        width: 42,

                        height: 42,

                        decoration:
                            BoxDecoration(

                          color:
                              AppColors
                                  .primary
                                  .withOpacity(
                            0.1,
                          ),

                          borderRadius:
                              BorderRadius.circular(
                            14,
                          ),
                        ),

                        child:
                            const Icon(

                          Icons
                              .tune_rounded,

                          color:
                              AppColors
                                  .primary,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),

          // ===========================================
          // BORDER
          // ===========================================

          border:
              OutlineInputBorder(

            borderRadius:
                BorderRadius.circular(
              22,
            ),

            borderSide:
                BorderSide.none,
          ),

          enabledBorder:
              OutlineInputBorder(

            borderRadius:
                BorderRadius.circular(
              22,
            ),

            borderSide:
                BorderSide(

              color:
                  Colors.grey
                      .shade200,
            ),
          ),

          focusedBorder:
              OutlineInputBorder(

            borderRadius:
                BorderRadius.circular(
              22,
            ),

            borderSide:
                const BorderSide(

              color:
                  AppColors.primary,

              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}