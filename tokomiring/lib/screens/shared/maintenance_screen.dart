// lib/screens/shared/maintenance_screen.dart

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class MaintenanceScreen
    extends StatelessWidget {

  const MaintenanceScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    return Scaffold(

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
                  // ICON
                  // =====================================

                  Container(

                    width: 170,

                    height: 170,

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

                      Icons.build_circle,

                      size: 110,

                      color:
                          Colors.white,
                    ),
                  ),

                  const SizedBox(
                    height: 40,
                  ),

                  // =====================================
                  // TITLE
                  // =====================================

                  const Text(

                    'System Maintenance',

                    textAlign:
                        TextAlign.center,

                    style: TextStyle(

                      color:
                          Colors.white,

                      fontSize: 38,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  // =====================================
                  // DESCRIPTION
                  // =====================================

                  const Text(

                    'We are improving the system\nfor a better experience.',

                    textAlign:
                        TextAlign.center,

                    style: TextStyle(

                      color:
                          Colors.white70,

                      fontSize: 18,

                      height: 1.6,
                    ),
                  ),

                  const SizedBox(
                    height: 50,
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
                        Icons.refresh,
                      ),

                      label:
                          const Text(

                        'Refresh',

                        style: TextStyle(

                          fontSize: 16,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 40,
                  ),

                  // =====================================
                  // FOOTER
                  // =====================================

                  Text(

                    'Please check back later',

                    style: TextStyle(

                      color:
                          Colors.grey
                              .shade500,

                      fontSize: 14,
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