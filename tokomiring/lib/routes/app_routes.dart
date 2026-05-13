// =====================================================
// FULL FIXED VERSION
// lib/routes/app_routes.dart
// =====================================================

import 'package:flutter/material.dart';

// =====================================================
// AUTH
// =====================================================

import '../screens/auth/welcome_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';

// =====================================================
// USER
// =====================================================

import '../screens/user/user_home_screen.dart';
import '../screens/user/cart_screen.dart';
import '../screens/user/checkout_screen.dart';
import '../screens/user/user_order_screen.dart';
import '../screens/user/user_profile_screen.dart';

// =====================================================
// ADMIN
// =====================================================

import '../screens/admin/admin_dashboard_screen.dart';
import '../screens/admin/admin_product_screen.dart';
import '../screens/admin/admin_order_screen.dart';
import '../screens/admin/admin_sales_report_screen.dart';
import '../screens/admin/admin_user_screen.dart';
import '../screens/admin/admin_notification_screen.dart';

// =====================================================
// SHARED
// =====================================================

import '../screens/shared/not_found_screen.dart';
import '../screens/shared/maintenance_screen.dart';

class AppRoutes {

  // =====================================================
  // AUTH
  // =====================================================

  static const String welcome =
      '/welcome';

  static const String login =
      '/login';

  static const String signup =
      '/signup';

  // =====================================================
  // USER
  // =====================================================

  static const String userHome =
      '/user-home';

  static const String cart =
      '/cart';

  static const String checkout =
      '/checkout';

  static const String userOrders =
      '/user-orders';

  static const String userProfile =
      '/user-profile';

  // =====================================================
  // ADMIN
  // =====================================================

  static const String adminDashboard =
      '/admin-dashboard';

  static const String adminProducts =
      '/admin-products';

  static const String adminOrders =
      '/admin-orders';

  static const String adminReports =
      '/admin-reports';

  static const String adminUsers =
      '/admin-users';

  static const String
      adminNotifications =
          '/admin-notifications';

  // =====================================================
  // SHARED
  // =====================================================

  static const String maintenance =
      '/maintenance';

  // =====================================================
  // ROUTE GENERATOR
  // =====================================================

  static Route<dynamic>
      generateRoute(
    RouteSettings settings,
  ) {

    switch (settings.name) {

      // =================================================
      // AUTH
      // =================================================

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

      // =================================================
      // USER
      // =================================================

      case userHome:

        return MaterialPageRoute(
          builder: (_) =>
              const UserHomeScreen(),
        );

      case cart:

        return MaterialPageRoute(
          builder: (_) =>
              const CartScreen(),
        );

      case checkout:

        return MaterialPageRoute(
          builder: (_) =>
              const CheckoutScreen(),
        );

      case userOrders:

        return MaterialPageRoute(
          builder: (_) =>
              const UserOrderScreen(),
        );

      case userProfile:

        return MaterialPageRoute(
          builder: (_) =>
              const UserProfileScreen(),
        );

      // =================================================
      // ADMIN
      // =================================================

      case adminDashboard:

        return MaterialPageRoute(
          builder: (_) =>
              const AdminDashboardScreen(),
        );

      case adminProducts:

        return MaterialPageRoute(
          builder: (_) =>
              const AdminProductScreen(),
        );

      case adminOrders:

        return MaterialPageRoute(
          builder: (_) =>
              const AdminOrderScreen(),
        );

      case adminReports:

        return MaterialPageRoute(
          builder: (_) =>
              const AdminSalesReportScreen(),
        );

      case adminUsers:

        return MaterialPageRoute(
          builder: (_) =>
              const AdminUserScreen(),
        );

      case adminNotifications:

        return MaterialPageRoute(
          builder: (_) =>
              const AdminNotificationScreen(),
        );

      // =================================================
      // SHARED
      // =================================================

      case maintenance:

        return MaterialPageRoute(
          builder: (_) =>
              const MaintenanceScreen(),
        );

      // =================================================
      // DEFAULT
      // =================================================

      default:

        return MaterialPageRoute(
          builder: (_) =>
              const NotFoundScreen(),
        );
    }
  }

  // =====================================================
  // PUSH
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

  // =====================================================
  // PUSH REPLACE
  // =====================================================

  static Future<dynamic>
      pushReplace(

    BuildContext context,

    String routeName,
  ) {

    return Navigator
        .pushReplacementNamed(

      context,

      routeName,
    );
  }

  // =====================================================
  // PUSH REMOVE
  // =====================================================

  static Future<dynamic>
      pushAndRemove(

    BuildContext context,

    String routeName,
  ) {

    return Navigator
        .pushNamedAndRemoveUntil(

      context,

      routeName,

      (route) => false,
    );
  }

  // =====================================================
  // POP
  // =====================================================

  static void pop(
    BuildContext context,
  ) {

    Navigator.pop(
      context,
    );
  }
}