// lib/widgets/forms/dropdown_field.dart

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class DropdownField
    extends StatelessWidget {

  final String? value;

  final List<String> items;

  final Function(String?)
      onChanged;

  final String hint;

  final String? labelText;

  final IconData? prefixIcon;

  final bool enabled;

  final String? Function(
    String?,
  )? validator;

  // =====================================================
  // CONSTRUCTOR
  // =====================================================

  const DropdownField({

    super.key,

    required this.value,

    required this.items,

    required this.onChanged,

    required this.hint,

    this.labelText,

    this.prefixIcon,

    this.enabled =
        true,

    this.validator,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    return DropdownButtonFormField<
        String>(

      value:
          value != null &&
                  value!.isNotEmpty

              ? value

              : null,

      validator:
          validator,

      decoration:
          InputDecoration(

        hintText:
            hint,

        labelText:
            labelText,

        filled: true,

        fillColor:
            enabled

                ? Colors.white

                : Colors.grey
                    .shade100,

        contentPadding:
            const EdgeInsets.symmetric(

          horizontal: 20,

          vertical: 18,
        ),

        prefixIcon:
            prefixIcon != null

                ? Icon(

                    prefixIcon,

                    color:
                        AppColors
                            .primary,
                  )

                : null,

        border:
            OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(
            20,
          ),

          borderSide:
              BorderSide.none,
        ),

        enabledBorder:
            OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(
            20,
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
            20,
          ),

          borderSide:
              const BorderSide(

            color:
                AppColors.primary,

            width: 2,
          ),
        ),

        errorBorder:
            OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(
            20,
          ),

          borderSide:
              const BorderSide(

            color:
                AppColors.danger,
          ),
        ),

        focusedErrorBorder:
            OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(
            20,
          ),

          borderSide:
              const BorderSide(

            color:
                AppColors.danger,

            width: 2,
          ),
        ),
      ),

      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
      ),

      borderRadius:
          BorderRadius.circular(
        20,
      ),

      dropdownColor:
          Colors.white,

      isExpanded:
          true,

      style:
          const TextStyle(

        color:
            Colors.black87,

        fontSize: 15,
      ),

      items:
          items.map(

        (item) {

          return DropdownMenuItem<
              String>(

            value:
                item,

            child: Text(
              item,
            ),
          );
        },
      ).toList(),

      onChanged:
          enabled
              ? onChanged
              : null,
    );
  }
}