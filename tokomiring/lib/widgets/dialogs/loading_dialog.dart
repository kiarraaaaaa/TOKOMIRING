// lib/widgets/dialogs/loading_dialog.dart

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class LoadingDialog {

  // =====================================================
  // SHOW
  // =====================================================

  static void show(

    BuildContext context, {

    String message =
        'Loading...',

    bool barrierDismissible =
        false,
  }) {

    showDialog(

      context: context,

      barrierDismissible:
          barrierDismissible,

      barrierColor:
          Colors.black45,

      builder: (_) {

        return WillPopScope(

          onWillPop: () async =>
              barrierDismissible,

          child: Dialog(

            backgroundColor:
                Colors.white,

            shape:
                RoundedRectangleBorder(

              borderRadius:
                  BorderRadius.circular(
                28,
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

                  // =================================
                  // LOADING ANIMATION
                  // =================================

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

                    child:
                        const Padding(

                      padding:
                          EdgeInsets.all(
                        24,
                      ),

                      child:
                          CircularProgressIndicator(

                        strokeWidth:
                            4,

                        color:
                            AppColors.primary,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 26,
                  ),

                  // =================================
                  // TITLE
                  // =================================

                  const Text(

                    'Please Wait',

                    style: TextStyle(

                      fontSize: 24,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  // =================================
                  // MESSAGE
                  // =================================

                  Text(

                    message,

                    textAlign:
                        TextAlign.center,

                    style:
                        TextStyle(

                      fontSize: 15,

                      color:
                          Colors.grey
                              .shade700,

                      height: 1.5,
                    ),
                  ),

                  const SizedBox(
                    height: 6,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // =====================================================
  // HIDE
  // =====================================================

  static void hide(
    BuildContext context,
  ) {

    if (Navigator.canPop(
      context,
    )) {

      Navigator.pop(
        context,
      );
    }
  }
}