// lib/main.dart

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/product_provider.dart';

import 'routes/app_routes.dart';

import 'core/theme/app_theme.dart';

import 'screens/shared/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options:
        DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const TokoMiringApp());
}

class TokoMiringApp extends StatelessWidget {
  const TokoMiringApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider()
            ..initializeAuth(),
        ),

        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) =>
              ProductProvider()
                ..initializeProducts(),
        ),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        title: 'Toko Miring',

        theme: AppTheme.lightTheme,

        home: const SplashScreen(),

        onGenerateRoute:
            AppRoutes.generateRoute,
      ),
    );
  }
}