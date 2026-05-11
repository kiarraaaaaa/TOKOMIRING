// lib/widgets/dialogs/image_preview_dialog.dart

import 'dart:convert';

import 'package:flutter/material.dart';

class ImagePreviewDialog {

  // =====================================================
  // SHOW NETWORK IMAGE
  // =====================================================

  static Future<void> show(

    BuildContext context, {

    required String imageUrl,

    String? heroTag,
  }) async {

    await showDialog(

      context: context,

      barrierColor:
          Colors.black87,

      builder: (_) {

        return Dialog(

          backgroundColor:
              Colors.transparent,

          insetPadding:
              const EdgeInsets.all(
            18,
          ),

          child: Stack(

            children: [

              // =====================================
              // IMAGE
              // =====================================

              InteractiveViewer(

                minScale: 0.8,

                maxScale: 4,

                child: ClipRRect(

                  borderRadius:
                      BorderRadius.circular(
                    26,
                  ),

                  child:
                      heroTag != null

                          ? Hero(

                              tag:
                                  heroTag,

                              child:
                                  Image.network(

                                imageUrl,

                                fit:
                                    BoxFit.contain,

                                loadingBuilder: (

                                  context,

                                  child,

                                  progress,

                                ) {

                                  if (progress ==
                                      null) {

                                    return child;
                                  }

                                  return Container(

                                    height: 300,

                                    alignment:
                                        Alignment
                                            .center,

                                    child:
                                        const CircularProgressIndicator(),
                                  );
                                },

                                errorBuilder: (

                                  context,

                                  error,

                                  stackTrace,

                                ) {

                                  return _errorWidget();
                                },
                              ),
                            )

                          : Image.network(

                              imageUrl,

                              fit:
                                  BoxFit.contain,

                              loadingBuilder: (

                                context,

                                child,

                                progress,

                              ) {

                                if (progress ==
                                    null) {

                                  return child;
                                }

                                return Container(

                                  height: 300,

                                  alignment:
                                      Alignment
                                          .center,

                                  child:
                                      const CircularProgressIndicator(),
                                );
                              },

                              errorBuilder: (

                                context,

                                error,

                                stackTrace,

                              ) {

                                return _errorWidget();
                              },
                            ),
                ),
              ),

              // =====================================
              // CLOSE BUTTON
              // =====================================

              Positioned(

                top: 14,

                right: 14,

                child: Material(

                  color:
                      Colors.transparent,

                  child: InkWell(

                    borderRadius:
                        BorderRadius.circular(
                      100,
                    ),

                    onTap: () {

                      Navigator.pop(
                        context,
                      );
                    },

                    child: Container(

                      padding:
                          const EdgeInsets.all(
                        10,
                      ),

                      decoration:
                          BoxDecoration(

                        color:
                            Colors.black54,

                        shape:
                            BoxShape.circle,
                      ),

                      child: const Icon(

                        Icons.close_rounded,

                        color:
                            Colors.white,

                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // =====================================================
  // SHOW BASE64 IMAGE
  // =====================================================

  static Future<void> showBase64(

    BuildContext context, {

    required String imageBase64,
  }) async {

    await showDialog(

      context: context,

      barrierColor:
          Colors.black87,

      builder: (_) {

        return Dialog(

          backgroundColor:
              Colors.transparent,

          insetPadding:
              const EdgeInsets.all(
            18,
          ),

          child: Stack(

            children: [

              // =====================================
              // IMAGE
              // =====================================

              InteractiveViewer(

                minScale: 0.8,

                maxScale: 4,

                child: ClipRRect(

                  borderRadius:
                      BorderRadius.circular(
                    26,
                  ),

                  child: Image.memory(

                    base64Decode(
                      imageBase64,
                    ),

                    fit:
                        BoxFit.contain,

                    errorBuilder: (

                      context,

                      error,

                      stackTrace,

                    ) {

                      return _errorWidget();
                    },
                  ),
                ),
              ),

              // =====================================
              // CLOSE
              // =====================================

              Positioned(

                top: 14,

                right: 14,

                child: Material(

                  color:
                      Colors.transparent,

                  child: InkWell(

                    borderRadius:
                        BorderRadius.circular(
                      100,
                    ),

                    onTap: () {

                      Navigator.pop(
                        context,
                      );
                    },

                    child: Container(

                      padding:
                          const EdgeInsets.all(
                        10,
                      ),

                      decoration:
                          BoxDecoration(

                        color:
                            Colors.black54,

                        shape:
                            BoxShape.circle,
                      ),

                      child: const Icon(

                        Icons.close_rounded,

                        color:
                            Colors.white,

                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // =====================================================
  // ERROR WIDGET
  // =====================================================

  static Widget _errorWidget() {

    return Container(

      height: 280,

      decoration:
          BoxDecoration(

        color:
            Colors.grey.shade200,

        borderRadius:
            BorderRadius.circular(
          26,
        ),
      ),

      child: Column(

        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [

          Icon(

            Icons.broken_image_rounded,

            size: 80,

            color:
                Colors.grey.shade500,
          ),

          const SizedBox(
            height: 14,
          ),

          Text(

            'Failed to load image',

            style: TextStyle(

              color:
                  Colors.grey.shade700,

              fontWeight:
                  FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}