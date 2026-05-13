// lib/screens/auth/welcome_screen.dart

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

import 'login_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen
    extends StatelessWidget {

  const WelcomeScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    final width =
        MediaQuery.of(context)
            .size
            .width;

    final bool isMobile =
        width < 700;

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
                  EdgeInsets.all(
                isMobile
                    ? 20
                    : 28,
              ),

              child: Column(

                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  // =====================================
                  // LOGO
                  // =====================================

                  Hero(

                    tag:
                        'app-logo',

                    child: Image.asset(

                      'assets/images/tokomiring.png',

                      height:
                          isMobile
                              ? 150
                              : 190,
                    ),
                  ),

                  SizedBox(
                    height:
                        isMobile
                            ? 28
                            : 34,
                  ),

                  // =====================================
                  // TITLE
                  // =====================================

                  Text(

                    'TOKO MIRING',

                    textAlign:
                        TextAlign.center,

                    style: TextStyle(

                      color:
                          Colors.white,

                      fontSize:
                          isMobile
                              ? 30
                              : 40,

                      fontWeight:
                          FontWeight.bold,

                      letterSpacing:
                          1.2,
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  // =====================================
                  // SUBTITLE
                  // =====================================

                  Text(

                    'Realtime Ecommerce Management System',

                    textAlign:
                        TextAlign.center,

                    style: TextStyle(

                      color:
                          Colors.white70,

                      fontSize:
                          isMobile
                              ? 13
                              : 16,

                      height: 1.5,
                    ),
                  ),

                  SizedBox(
                    height:
                        isMobile
                            ? 42
                            : 54,
                  ),

                  // =====================================
                  // LOGIN BUTTON
                  // =====================================

                  SizedBox(

                    width:
                        isMobile
                            ? double.infinity
                            : 270,

                    height:
                        isMobile
                            ? 52
                            : 56,

                    child:
                        ElevatedButton(

                      style:
                          ElevatedButton.styleFrom(

                        backgroundColor:
                            AppColors.primary,

                        foregroundColor:
                            Colors.white,

                        elevation: 0,

                        shape:
                            RoundedRectangleBorder(

                          borderRadius:
                              BorderRadius.circular(
                            16,
                          ),
                        ),
                      ),

                      onPressed: () {

                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>
                                const LoginScreen(),
                          ),
                        );
                      },

                      child:
                          Text(

                        'Login',

                        style: TextStyle(

                          fontSize:
                              isMobile
                                  ? 15
                                  : 16,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  // =====================================
                  // SIGNUP BUTTON
                  // =====================================

                  SizedBox(

                    width:
                        isMobile
                            ? double.infinity
                            : 270,

                    height:
                        isMobile
                            ? 52
                            : 56,

                    child:
                        OutlinedButton(

                      style:
                          OutlinedButton.styleFrom(

                        foregroundColor:
                            Colors.white,

                        side:
                            const BorderSide(
                          color:
                              Colors.white24,
                        ),

                        shape:
                            RoundedRectangleBorder(

                          borderRadius:
                              BorderRadius.circular(
                            16,
                          ),
                        ),
                      ),

                      onPressed: () {

                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>
                                const SignupScreen(),
                          ),
                        );
                      },

                      child:
                          Text(

                        'Create Account',

                        style: TextStyle(

                          fontSize:
                              isMobile
                                  ? 14
                                  : 15,

                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height:
                        isMobile
                            ? 34
                            : 42,
                  ),

                  // =====================================
                  // FOOTER
                  // =====================================

                  Text(

                    'Fast • Modern • Realtime',

                    style: TextStyle(

                      color:
                          Colors.grey
                              .shade500,

                      letterSpacing:
                          1,

                      fontSize:
                          isMobile
                              ? 11
                              : 13,
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