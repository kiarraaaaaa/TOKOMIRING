// lib/main.dart

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'firebase_options.dart';

import 'core/theme/app_theme.dart';

import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/product_provider.dart';

import 'routes/app_routes.dart';

import 'screens/shared/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // =====================================================
  // FIREBASE INIT
  // =====================================================

  await Firebase.initializeApp(
    options:
        DefaultFirebaseOptions
            .currentPlatform,
  );

  runApp(
    const TokoMiringApp(),
  );
}

class TokoMiringApp
    extends StatelessWidget {

  const TokoMiringApp({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    return MultiProvider(
      providers: [

        // =============================================
        // AUTH PROVIDER
        // =============================================

        ChangeNotifierProvider(
          create: (_) =>
              AuthProvider()
                ..initializeAuth(),
        ),

        // =============================================
        // CART PROVIDER
        // =============================================

        ChangeNotifierProvider(
          create: (_) =>
              CartProvider(),
        ),

        // =============================================
        // PRODUCT PROVIDER
        // FIX DOUBLE PRODUCT
        // =============================================

        ChangeNotifierProvider(
          create: (_) =>
              ProductProvider(),
        ),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner:
            false,

        title: 'Toko Miring',

        theme:
            AppTheme.lightTheme,

        // =============================================
        // SPLASH SCREEN
        // =============================================

        home:
            const SplashScreen(),

        // =============================================
        // ROUTES
        // =============================================

        onGenerateRoute:
            AppRoutes
                .generateRoute,

        // =============================================
        // BUILDER
        // =============================================

        builder: (
          context,
          child,
        ) {

          return MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(
              textScaler:
                  const TextScaler
                      .linear(
                1.0,
              ),
            ),

            child:
                child ??
                const SizedBox(),
          );
        },
      ),
    );
  }
}