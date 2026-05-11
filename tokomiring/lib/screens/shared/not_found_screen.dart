// lib/screens/shared/not_found_screen.dart

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class NotFoundScreen
    extends StatelessWidget {

  const NotFoundScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    return Scaffold(

      backgroundColor:
          AppColors.background,

      body: Container(

        width: double.infinity,

        decoration:
            const BoxDecoration(

          gradient:
              LinearGradient(

            colors: [

              Color(0xff0F172A),

              Color(0xff1E293B),
            ],

            begin:
                Alignment.topLeft,

            end:
                Alignment.bottomRight,
          ),
        ),

        child: SafeArea(

          child: Center(

            child:
                SingleChildScrollView(

              padding:
                  const EdgeInsets.all(
                24,
              ),

              child: Column(

                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  // =====================================
                  // ICON CONTAINER
                  // =====================================

                  Container(

                    width: 180,

                    height: 180,

                    decoration:
                        BoxDecoration(

                      shape:
                          BoxShape.circle,

                      color:
                          Colors.white
                              .withOpacity(
                        0.08,
                      ),
                    ),

                    child:
                        const Icon(

                      Icons.error_outline,

                      size: 110,

                      color:
                          Colors.redAccent,
                    ),
                  ),

                  const SizedBox(
                    height: 40,
                  ),

                  // =====================================
                  // TITLE
                  // =====================================

                  const Text(

                    '404',

                    style: TextStyle(

                      color:
                          Colors.white,

                      fontSize: 64,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // =====================================
                  // SUBTITLE
                  // =====================================

                  const Text(

                    'Page Not Found',

                    textAlign:
                        TextAlign.center,

                    style: TextStyle(

                      color:
                          Colors.white,

                      fontSize: 32,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  // =====================================
                  // DESCRIPTION
                  // =====================================

                  Text(

                    'The page you are looking for\nmight have been removed or does not exist.',

                    textAlign:
                        TextAlign.center,

                    style: TextStyle(

                      color:
                          Colors.grey
                              .shade400,

                      fontSize: 17,

                      height: 1.6,
                    ),
                  ),

                  const SizedBox(
                    height: 45,
                  ),

                  // =====================================
                  // BUTTON
                  // =====================================

                  SizedBox(

                    width: 220,

                    height: 58,

                    child:
                        ElevatedButton.icon(

                      style:
                          ElevatedButton.styleFrom(

                        backgroundColor:
                            AppColors.primary,

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

                      icon:
                          const Icon(
                        Icons.arrow_back,
                      ),

                      label:
                          const Text(

                        'Go Back',

                        style: TextStyle(

                          fontSize: 16,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  // =====================================
                  // FOOTER
                  // =====================================

                  Text(

                    'Toko Miring Ecommerce',

                    style: TextStyle(

                      color:
                          Colors.grey
                              .shade600,

                      letterSpacing:
                          1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}