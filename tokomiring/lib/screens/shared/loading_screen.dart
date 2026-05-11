// lib/screens/shared/loading_screen.dart

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class LoadingScreen
    extends StatelessWidget {

  const LoadingScreen({
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

        child: Center(

          child: Column(

            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [

              // =========================================
              // LOGO
              // =========================================

              Image.asset(

                'assets/images/tokomiring.png',

                height: 140,
              ),

              const SizedBox(
                height: 35,
              ),

              // =========================================
              // LOADING
              // =========================================

              const SizedBox(

                width: 38,

                height: 38,

                child:
                    CircularProgressIndicator(

                  color:
                      Colors.white,

                  strokeWidth: 3,
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              // =========================================
              // TEXT
              // =========================================

              const Text(

                'Loading...',

                style: TextStyle(

                  color:
                      Colors.white,

                  fontSize: 20,

                  fontWeight:
                      FontWeight.w600,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              // =========================================
              // SUBTEXT
              // =========================================

              Text(

                'Please wait a moment',

                style: TextStyle(

                  color:
                      Colors.grey
                          .shade400,

                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}