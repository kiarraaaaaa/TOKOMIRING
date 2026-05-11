// lib/widgets/forms/image_picker_field.dart

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class ImagePickerField
    extends StatelessWidget {

  final PlatformFile? file;

  final VoidCallback onPick;

  final String title;

  final String? subtitle;

  final double height;

  final bool showChangeButton;

  // =====================================================
  // CONSTRUCTOR
  // =====================================================

  const ImagePickerField({

    super.key,

    required this.file,

    required this.onPick,

    required this.title,

    this.subtitle,

    this.height =
        220,

    this.showChangeButton =
        true,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    return GestureDetector(

      onTap:
          onPick,

      child: AnimatedContainer(

        duration:
            const Duration(
          milliseconds: 250,
        ),

        width:
            double.infinity,

        height:
            height,

        decoration:
            BoxDecoration(

          color:
              Colors.white,

          borderRadius:
              BorderRadius.circular(
            24,
          ),

          border:
              Border.all(

            color:
                file == null

                    ? Colors.grey
                        .shade300

                    : AppColors
                        .primary
                        .withOpacity(
                      0.3,
                    ),

            width:
                1.5,
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

        child:
            file == null

                // =====================================
                // EMPTY
                // =====================================

                ? Column(

                    mainAxisAlignment:
                        MainAxisAlignment
                            .center,

                    children: [

                      Container(

                        width: 90,

                        height: 90,

                        decoration:
                            BoxDecoration(

                          color:
                              AppColors.primary
                                  .withOpacity(
                            0.1,
                          ),

                          shape:
                              BoxShape.circle,
                        ),

                        child: const Icon(

                          Icons.image_rounded,

                          size: 48,

                          color:
                              AppColors.primary,
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      Text(

                        title,

                        textAlign:
                            TextAlign.center,

                        style:
                            const TextStyle(

                          fontSize: 17,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      if (subtitle !=
                          null) ...[

                        const SizedBox(
                          height: 8,
                        ),

                        Padding(

                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),

                          child: Text(

                            subtitle!,

                            textAlign:
                                TextAlign.center,

                            style:
                                TextStyle(

                              color:
                                  Colors.grey
                                      .shade600,

                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ],
                  )

                // =====================================
                // IMAGE
                // =====================================

                : Stack(

                    children: [

                      Positioned.fill(

                        child: ClipRRect(

                          borderRadius:
                              BorderRadius.circular(
                            24,
                          ),

                          child: Image.memory(

                            file!.bytes!,

                            fit:
                                BoxFit.cover,
                          ),
                        ),
                      ),

                      // =================================
                      // OVERLAY
                      // =================================

                      Positioned.fill(

                        child: Container(

                          decoration:
                              BoxDecoration(

                            borderRadius:
                                BorderRadius.circular(
                              24,
                            ),

                            gradient:
                                LinearGradient(

                              begin:
                                  Alignment
                                      .bottomCenter,

                              end:
                                  Alignment
                                      .topCenter,

                              colors: [

                                Colors.black
                                    .withOpacity(
                                  0.35,
                                ),

                                Colors
                                    .transparent,
                              ],
                            ),
                          ),
                        ),
                      ),

                      // =================================
                      // FILE NAME
                      // =================================

                      Positioned(

                        left: 16,

                        right: 16,

                        bottom: 16,

                        child: Column(

                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            Text(

                              file!.name,

                              maxLines: 1,

                              overflow:
                                  TextOverflow
                                      .ellipsis,

                              style:
                                  const TextStyle(

                                color:
                                    Colors.white,

                                fontWeight:
                                    FontWeight.bold,

                                fontSize: 15,
                              ),
                            ),

                            const SizedBox(
                              height: 4,
                            ),

                            Text(

                              '${(file!.size / 1024).toStringAsFixed(1)} KB',

                              style:
                                  const TextStyle(

                                color:
                                    Colors.white70,

                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // =================================
                      // CHANGE BUTTON
                      // =================================

                      if (showChangeButton)

                        Positioned(

                          top: 14,

                          right: 14,

                          child: Container(

                            decoration:
                                BoxDecoration(

                              color:
                                  Colors.black54,

                              borderRadius:
                                  BorderRadius.circular(
                                14,
                              ),
                            ),

                            child: IconButton(

                              onPressed:
                                  onPick,

                              icon:
                                  const Icon(

                                Icons.edit_rounded,

                                color:
                                    Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
      ),
    );
  }
}