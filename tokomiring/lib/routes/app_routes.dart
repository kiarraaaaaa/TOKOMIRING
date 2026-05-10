// lib/routes/app_routes.dart

import 'package:flutter/material.dart';

import '../screens/auth/welcome_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';

import '../screens/user/user_home_screen.dart';

import '../screens/admin/admin_dashboard_screen.dart';

import '../screens/shared/not_found_screen.dart';
import '../screens/shared/maintenance_screen.dart';

class AppRoutes {
  // =====================================================
  // ROUTE NAMES
  // =====================================================

  static const String welcome =
      '/welcome';

  static const String login =
      '/login';

  static const String signup =
      '/signup';

  static const String userHome =
      '/user-home';

  static const String adminDashboard =
      '/admin-dashboard';

  static const String maintenance =
      '/maintenance';

  // =====================================================
  // ROUTE GENERATOR
  // =====================================================

  static Route<dynamic> generateRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      // =========================
      // AUTH
      // =========================

      case welcome:
        return MaterialPageRoute(
          builder: (_) =>
              const WelcomeScreen(),
        );

      case login:
        return MaterialPageRoute(
          builder: (_) =>
              const LoginScreen(),
        );

      case signup:
        return MaterialPageRoute(
          builder: (_) =>
              const SignupScreen(),
        );

      // =========================
      // USER
      // =========================

      case userHome:
        return MaterialPageRoute(
          builder: (_) =>
              const UserHomeScreen(),
        );

      // =========================
      // ADMIN
      // =========================

      case adminDashboard:
        return MaterialPageRoute(
          builder: (_) =>
              const AdminDashboardScreen(),
        );

      // =========================
      // MAINTENANCE
      // =========================

      case maintenance:
        return MaterialPageRoute(
          builder: (_) =>
              const MaintenanceScreen(),
        );

      // =========================
      // DEFAULT
      // =========================

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const NotFoundScreen(),
        );
    }
  }

  // =====================================================
  // NAVIGATION HELPERS
  // =====================================================

  static Future<dynamic> push(
    BuildContext context,
    String routeName,
  ) {
    return Navigator.pushNamed(
      context,
      routeName,
    );
  }

  static Future<dynamic> pushReplace(
    BuildContext context,
    String routeName,
  ) {
    return Navigator.pushReplacementNamed(
      context,
      routeName,
    );
  }

  static Future<dynamic> pushAndRemove(
    BuildContext context,
    String routeName,
  ) {
    return Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (route) => false,
    );
  }

  static void pop(
    BuildContext context,
  ) {
    Navigator.pop(context);
  }
}