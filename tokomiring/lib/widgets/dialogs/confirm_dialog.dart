// lib/widgets/dialogs/confirm_dialog.dart

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class ConfirmDialog {

  // =====================================================
  // SHOW
  // =====================================================

  static Future<bool> show(

    BuildContext context, {

    required String title,

    required String message,

    String confirmText =
        'Confirm',

    String cancelText =
        'Cancel',

    IconData icon =
        Icons.warning_rounded,

    Color confirmColor =
        AppColors.danger,

    bool barrierDismissible =
        true,
  }) async {

    final result =
        await showDialog<bool>(

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
              26,
            ),

            child: Column(

              mainAxisSize:
                  MainAxisSize.min,

              children: [

                // =====================================
                // ICON
                // =====================================

                Container(

                  width: 90,

                  height: 90,

                  decoration:
                      BoxDecoration(

                    color:
                        confirmColor
                            .withOpacity(
                      0.1,
                    ),

                    shape:
                        BoxShape.circle,
                  ),

                  child: Icon(

                    icon,

                    size: 46,

                    color:
                        confirmColor,
                  ),
                ),

                const SizedBox(
                  height: 24,
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
                  height: 28,
                ),

                // =====================================
                // BUTTONS
                // =====================================

                Row(

                  children: [

                    // =================================
                    // CANCEL
                    // =================================

                    Expanded(

                      child: OutlinedButton(

                        style:
                            OutlinedButton
                                .styleFrom(

                          foregroundColor:
                              Colors.black87,

                          side:
                              BorderSide(

                            color:
                                Colors.grey
                                    .shade300,
                          ),

                          padding:
                              const EdgeInsets.symmetric(
                            vertical: 16,
                          ),

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
                            false,
                          );
                        },

                        child:
                            Text(

                          cancelText,

                          style:
                              const TextStyle(

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 14,
                    ),

                    // =================================
                    // CONFIRM
                    // =================================

                    Expanded(

                      child: ElevatedButton(

                        style:
                            ElevatedButton
                                .styleFrom(

                          elevation: 0,

                          backgroundColor:
                              confirmColor,

                          foregroundColor:
                              Colors.white,

                          padding:
                              const EdgeInsets.symmetric(
                            vertical: 16,
                          ),

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
                            true,
                          );
                        },

                        child:
                            Text(

                          confirmText,

                          style:
                              const TextStyle(

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    return result ?? false;
  }
}