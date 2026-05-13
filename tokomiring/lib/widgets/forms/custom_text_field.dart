// lib/widgets/forms/custom_text_field.dart

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class CustomTextField
    extends StatefulWidget {

  final TextEditingController
      controller;

  final String hintText;

  final String? labelText;

  final IconData? prefixIcon;

  final IconData? suffixIcon;

  final bool obscureText;

  final TextInputType keyboardType;

  final String? Function(
    String?,
  )? validator;

  final int maxLines;

  final bool enabled;

  final bool readOnly;

  final VoidCallback? onTap;

  final void Function(String)?
      onChanged;

  final TextInputAction
      textInputAction;

  final FocusNode? focusNode;

  final EdgeInsetsGeometry?
      contentPadding;

  // =====================================================
  // CONSTRUCTOR
  // =====================================================

  const CustomTextField({

    super.key,

    required this.controller,

    required this.hintText,

    this.labelText,

    this.prefixIcon,

    this.suffixIcon,

    this.obscureText =
        false,

    this.keyboardType =
        TextInputType.text,

    this.validator,

    this.maxLines =
        1,

    this.enabled =
        true,

    this.readOnly =
        false,

    this.onTap,

    this.onChanged,

    this.textInputAction =
        TextInputAction.next,

    this.focusNode,

    this.contentPadding,
  });

  @override
  State<CustomTextField>
      createState() =>
          _CustomTextFieldState();
}

class _CustomTextFieldState
    extends State<
        CustomTextField> {

  late bool isObscure;

  // =====================================================
  // INIT
  // =====================================================

  @override
  void initState() {

    super.initState();

    isObscure =
        widget.obscureText;
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(
    BuildContext context,
  ) {

    return TextFormField(

      controller:
          widget.controller,

      obscureText:
          isObscure,

      keyboardType:
          widget.keyboardType,

      validator:
          widget.validator,

      maxLines:
          widget.obscureText
              ? 1
              : widget.maxLines,

      enabled:
          widget.enabled,

      readOnly:
          widget.readOnly,

      onTap:
          widget.onTap,

      onChanged:
          widget.onChanged,

      textInputAction:
          widget.textInputAction,

      focusNode:
          widget.focusNode,

      style:
          const TextStyle(

        fontSize: 12,
      ),

      decoration:
          InputDecoration(

        hintText:
            widget.hintText,

        labelText:
            widget.labelText,

        hintStyle:
            TextStyle(

          fontSize: 11,

          color:
              Colors.grey
                  .shade500,
        ),

        labelStyle:
            TextStyle(

          fontSize: 11,

          color:
              Colors.grey
                  .shade600,
        ),

        filled: true,

        fillColor:
            widget.enabled

                ? Colors.white

                : Colors.grey
                    .shade100,

        contentPadding:
            widget.contentPadding ??

                const EdgeInsets.symmetric(

              horizontal: 14,

              vertical: 14,
            ),

        // ===============================================
        // PREFIX
        // ===============================================

        prefixIcon:
            widget.prefixIcon !=
                    null

                ? Padding(

                    padding:
                        const EdgeInsets.all(
                      10,
                    ),

                    child: Icon(

                      widget.prefixIcon,

                      size: 18,

                      color:
                          AppColors
                              .primary,
                    ),
                  )

                : null,

        // ===============================================
        // SUFFIX
        // ===============================================

        suffixIcon:
            widget.obscureText

                ? IconButton(

                    onPressed: () {

                      setState(() {

                        isObscure =
                            !isObscure;
                      });
                    },

                    icon: Icon(

                      isObscure

                          ? Icons
                              .visibility_off_rounded

                          : Icons
                              .visibility_rounded,

                      size: 18,

                      color:
                          Colors.grey
                              .shade600,
                    ),
                  )

                : widget.suffixIcon !=
                        null

                    ? Padding(

                        padding:
                            const EdgeInsets.all(
                          10,
                        ),

                        child: Icon(

                          widget
                              .suffixIcon,

                          size: 18,

                          color:
                              Colors.grey
                                  .shade600,
                        ),
                      )

                    : null,

        // ===============================================
        // BORDER
        // ===============================================

        border:
            OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(
            14,
          ),

          borderSide:
              BorderSide.none,
        ),

        enabledBorder:
            OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(
            14,
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
            14,
          ),

          borderSide:
              const BorderSide(

            color:
                AppColors.primary,

            width: 1.5,
          ),
        ),

        errorBorder:
            OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(
            14,
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
            14,
          ),

          borderSide:
              const BorderSide(

            color:
                AppColors.danger,

            width: 1.5,
          ),
        ),

        errorStyle:
            const TextStyle(

          fontSize: 10,

          color:
              AppColors.danger,

          fontWeight:
              FontWeight.w500,
        ),
      ),
    );
  }
}