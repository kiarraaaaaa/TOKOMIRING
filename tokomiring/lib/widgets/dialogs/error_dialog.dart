// lib/widgets/dialogs/error_dialog.dart

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class ErrorDialog {

  // =====================================================
  // SHOW
  // =====================================================

  static Future<void> show(

    BuildContext context, {

    required String title,

    required String message,

    String buttonText =
        'Close',

    bool barrierDismissible =
        true,
  }) async {

    await showDialog(

      context: context,

      barrierDismissible:
          barrierDismissible,

      builder: (_) {

        return Dialog(

          backgroundColor:
              Colors.white,

          shape:
              RoundedRectangleBorder(

            borderRadius:
                BorderRadius.circular(
              30,
            ),
          ),

          child: Padding(

            padding:
                const EdgeInsets.all(
              28,
            ),

            child: Column(

              mainAxisSize:
                  MainAxisSize.min,

              children: [

                // =====================================
                // ICON
                // =====================================

                Container(

                  width: 100,

                  height: 100,

                  decoration:
                      BoxDecoration(

                    color:
                        AppColors.danger
                            .withOpacity(
                      0.1,
                    ),

                    shape:
                        BoxShape.circle,
                  ),

                  child: const Icon(

                    Icons.error_rounded,

                    color:
                        AppColors.danger,

                    size: 54,
                  ),
                ),

                const SizedBox(
                  height: 26,
                ),

                // =====================================
                // TITLE
                // =====================================

                Text(

                  title,

                  textAlign:
                      TextAlign.center,

                  style:
                      const TextStyle(

                    fontSize: 24,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 14,
                ),

                // =====================================
                // MESSAGE
                // =====================================

                Text(

                  message,

                  textAlign:
                      TextAlign.center,

                  style:
                      TextStyle(

                    color:
                        Colors.grey
                            .shade700,

                    fontSize: 15,

                    height: 1.5,
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                // =====================================
                // BUTTON
                // =====================================

                SizedBox(

                  width:
                      double.infinity,

                  height: 56,

                  child:
                      ElevatedButton(

                    style:
                        ElevatedButton
                            .styleFrom(

                      elevation: 0,

                      backgroundColor:
                          AppColors.danger,

                      foregroundColor:
                          Colors.white,

                      shape:
                          RoundedRectangleBorder(

                        borderRadius:
                            BorderRadius.circular(
                          18,
                        ),
                      ),
                    ),

                    onPressed: () {

                      Navigator.pop(
                        context,
                      );
                    },

                    child:
                        Text(

                      buttonText,

                      style:
                          const TextStyle(

                        fontWeight:
                            FontWeight.bold,

                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}