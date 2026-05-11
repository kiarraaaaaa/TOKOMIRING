// lib/screens/shared/no_data_screen.dart

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class NoDataScreen
    extends StatelessWidget {

  final String message;

  const NoDataScreen({

    super.key,

    required this.message,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    return Center(

      child: Padding(

        padding:
            const EdgeInsets.all(
          24,
        ),

        child: Column(

          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            // =========================================
            // ICON CONTAINER
            // =========================================

            Container(

              width: 150,

              height: 150,

              decoration:
                  BoxDecoration(

                shape:
                    BoxShape.circle,

                color:
                    AppColors.primary
                        .withOpacity(
                  0.08,
                ),
              ),

              child:
                  Icon(

                Icons.inbox_outlined,

                size: 90,

                color:
                    AppColors.primary,
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            // =========================================
            // TITLE
            // =========================================

            const Text(

              'No Data Found',

              textAlign:
                  TextAlign.center,

              style: TextStyle(

                fontSize: 28,

                fontWeight:
                    FontWeight.bold,

                color:
                    AppColors.dark,
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            // =========================================
            // MESSAGE
            // =========================================

            Text(

              message,

              textAlign:
                  TextAlign.center,

              style: TextStyle(

                fontSize: 16,

                color:
                    Colors.grey
                        .shade600,

                height: 1.6,
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            // =========================================
            // OPTIONAL BUTTON
            // =========================================

            ElevatedButton.icon(

              onPressed: () {

                Navigator.pop(
                  context,
                );
              },

              icon:
                  const Icon(
                Icons.refresh,
              ),

              label:
                  const Text(
                'Refresh',
              ),

              style:
                  ElevatedButton.styleFrom(

                backgroundColor:
                    AppColors.primary,

                foregroundColor:
                    Colors.white,

                padding:
                    const EdgeInsets.symmetric(

                  horizontal: 24,

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
            ),
          ],
        ),
      ),
    );
  }
}