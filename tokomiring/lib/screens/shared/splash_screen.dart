import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

import '../auth/welcome_screen.dart';

import '../admin/admin_dashboard_screen.dart';
import '../user/user_home_screen.dart';

class SplashScreen
    extends StatefulWidget {

  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen>
      createState() =>
          _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen> {

  @override
  void initState() {

    super.initState();

    startApp();
  }

  // =====================================================
  // START APP
  // =====================================================

  Future<void> startApp()
      async {

    await Future.delayed(

      const Duration(
        seconds: 3,
      ),
    );

    if (!mounted) {
      return;
    }

    final authProvider =
        Provider.of<AuthProvider>(

      context,

      listen: false,
    );

    // ===================================================
    // USER LOGGED IN
    // ===================================================

    if (authProvider
        .isLoggedIn) {

      // ================================================
      // ADMIN
      // ================================================

      if (authProvider
              .role ==
          'admin') {

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(

            builder: (_) =>
                const AdminDashboardScreen(),
          ),
        );
      }

      // ================================================
      // USER
      // ================================================

      else {

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(

            builder: (_) =>
                const UserHomeScreen(),
          ),
        );
      }
    }

    // ===================================================
    // NOT LOGIN
    // ===================================================

    else {

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (_) =>
              const WelcomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    final width =
        MediaQuery.of(context)
            .size
            .width;

    final height =
        MediaQuery.of(context)
            .size
            .height;

    final bool mobile =
        width < 700;

    return Scaffold(

      body: Container(

        width:
            double.infinity,

        height:
            double.infinity,

        decoration:
            const BoxDecoration(

          gradient:
              LinearGradient(

            colors: [

              Color(
                0xff2563EB,
              ),

              Color(
                0xff7C3AED,
              ),
            ],

            begin:
                Alignment.topLeft,

            end:
                Alignment.bottomRight,
          ),
        ),

        child: SafeArea(

          child:
              Center(

            child:
                SingleChildScrollView(

              physics:
                  const BouncingScrollPhysics(),

              padding:
                  const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),

              child: ConstrainedBox(

                constraints:
                    BoxConstraints(

                  minHeight:
                      height * 0.82,
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

                            mobile

                                ? 120

                                : 180,

                        fit:
                            BoxFit.contain,
                      ),
                    ),

                    SizedBox(
                      height:

                          mobile
                              ? 22
                              : 30,
                    ),

                    // =====================================
                    // TITLE
                    // =====================================

                    Text(

                      'TOKO MIRING',

                      textAlign:
                          TextAlign.center,

                      style:
                          TextStyle(

                        color:
                            Colors.white,

                        fontSize:

                            mobile
                                ? 26
                                : 38,

                        fontWeight:
                            FontWeight.bold,

                        letterSpacing:
                            1,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    // =====================================
                    // SUBTITLE
                    // =====================================

                    Padding(

                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),

                      child: Text(

                        'Realtime Ecommerce Management',

                        textAlign:
                            TextAlign.center,

                        style:
                            TextStyle(

                          color:
                              Colors.white70,

                          fontSize:

                              mobile
                                  ? 11
                                  : 15,
                        ),
                      ),
                    ),

                    SizedBox(
                      height:

                          mobile
                              ? 34
                              : 42,
                    ),

                    // =====================================
                    // LOADING
                    // =====================================

                    SizedBox(

                      width:

                          mobile
                              ? 30
                              : 38,

                      height:

                          mobile
                              ? 30
                              : 38,

                      child:
                          const CircularProgressIndicator(

                        color:
                            Colors.white,

                        strokeWidth:
                            3,
                      ),
                    ),

                    SizedBox(
                      height:

                          mobile
                              ? 18
                              : 24,
                    ),

                    // =====================================
                    // TEXT
                    // =====================================

                    Text(

                      'Loading System...',

                      textAlign:
                          TextAlign.center,

                      style:
                          TextStyle(

                        color:
                            Colors.white,

                        fontSize:

                            mobile
                                ? 13
                                : 17,

                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),

                    SizedBox(
                      height:

                          mobile
                              ? 40
                              : 60,
                    ),

                    // =====================================
                    // FOOTER
                    // =====================================

                    Text(

                      'Version 1.0.0',

                      textAlign:
                          TextAlign.center,

                      style:
                          TextStyle(

                        color:
                            Colors.white
                                .withOpacity(
                          0.7,
                        ),

                        fontSize:

                            mobile
                                ? 10
                                : 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}