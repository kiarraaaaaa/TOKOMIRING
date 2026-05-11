// lib/screens/shared/splash_screen.dart

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

    return Scaffold(

      body: Container(

        width: double.infinity,

        decoration:
            const BoxDecoration(

          gradient:
              LinearGradient(

            colors: [

              Color(0xff2563EB),

              Color(0xff7C3AED),
            ],

            begin:
                Alignment.topLeft,

            end:
                Alignment.bottomRight,
          ),
        ),

        child: SafeArea(

          child: Column(

            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [

              // =========================================
              // LOGO
              // =========================================

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

              // =========================================
              // TITLE
              // =========================================

              const Text(

                'TOKO MIRING',

                style: TextStyle(

                  color:
                      Colors.white,

                  fontSize: 40,

                  fontWeight:
                      FontWeight.bold,

                  letterSpacing:
                      1.5,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              // =========================================
              // SUBTITLE
              // =========================================

              const Text(

                'Realtime Ecommerce Management',

                textAlign:
                    TextAlign.center,

                style: TextStyle(

                  color:
                      Colors.white70,

                  fontSize: 16,
                ),
              ),

              const SizedBox(
                height: 50,
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

                'Loading System...',

                style: TextStyle(

                  color:
                      Colors.white,

                  fontSize: 18,

                  fontWeight:
                      FontWeight.w600,
                ),
              ),

              const SizedBox(
                height: 80,
              ),

              // =========================================
              // FOOTER
              // =========================================

              Text(

                'Version 1.0.0',

                style: TextStyle(

                  color:
                      Colors.white
                          .withOpacity(
                    0.7,
                  ),

                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}