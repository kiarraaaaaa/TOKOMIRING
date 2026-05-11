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
                  // LOGO
                  // =====================================

                  Hero(

                    tag:
                        'app-logo',

                    child: Image.asset(

                      'assets/images/tokomiring.png',

                      height: 220,
                    ),
                  ),

                  const SizedBox(
                    height: 35,
                  ),

                  // =====================================
                  // TITLE
                  // =====================================

                  const Text(

                    'TOKO MIRING',

                    textAlign:
                        TextAlign.center,

                    style: TextStyle(

                      color:
                          Colors.white,

                      fontSize: 42,

                      fontWeight:
                          FontWeight.bold,

                      letterSpacing:
                          1.5,
                    ),
                  ),

                  const SizedBox(
                    height: 14,
                  ),

                  // =====================================
                  // SUBTITLE
                  // =====================================

                  const Text(

                    'Realtime Ecommerce Management System',

                    textAlign:
                        TextAlign.center,

                    style: TextStyle(

                      color:
                          Colors.white70,

                      fontSize: 16,

                      height: 1.5,
                    ),
                  ),

                  const SizedBox(
                    height: 60,
                  ),

                  // =====================================
                  // LOGIN BUTTON
                  // =====================================

                  SizedBox(

                    width: 280,

                    height: 58,

                    child:
                        ElevatedButton(

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

                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>
                                const LoginScreen(),
                          ),
                        );
                      },

                      child:
                          const Text(

                        'Login',

                        style: TextStyle(

                          fontSize: 17,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  // =====================================
                  // SIGNUP BUTTON
                  // =====================================

                  SizedBox(

                    width: 280,

                    height: 58,

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
                            18,
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
                          const Text(

                        'Create Account',

                        style: TextStyle(

                          fontSize: 16,

                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 45,
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