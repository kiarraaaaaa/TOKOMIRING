// =====================================================
// PREMIUM FULL VERSION
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
  // INITIAL ROUTE
  // =====================================================

  static const String initialRoute =
      welcome;

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

        return _buildRoute(
          const WelcomeScreen(),
        );

      case login:

        return _buildRoute(
          const LoginScreen(),
        );

      case signup:

        return _buildRoute(
          const SignupScreen(),
        );

      // =================================================
      // USER
      // =================================================

      case userHome:

        return _buildRoute(
          const UserHomeScreen(),
        );

      case cart:

        return _buildRoute(
          const CartScreen(),
        );

      case checkout:

        return _buildRoute(
          const CheckoutScreen(),
        );

      case userOrders:

        return _buildRoute(
          const UserOrderScreen(),
        );

      case userProfile:

        return _buildRoute(
          const UserProfileScreen(),
        );

      // =================================================
      // ADMIN
      // =================================================

      case adminDashboard:

        return _buildRoute(
          const AdminDashboardScreen(),
        );

      case adminProducts:

        return _buildRoute(
          const AdminProductScreen(),
        );

      case adminOrders:

        return _buildRoute(
          const AdminOrderScreen(),
        );

      case adminReports:

        return _buildRoute(
          const AdminSalesReportScreen(),
        );

      case adminUsers:

        return _buildRoute(
          const AdminUserScreen(),
        );

      case adminNotifications:

        return _buildRoute(
          const AdminNotificationScreen(),
        );

      // =================================================
      // SHARED
      // =================================================

      case maintenance:

        return _buildRoute(
          const MaintenanceScreen(),
        );

      // =================================================
      // DEFAULT
      // =================================================

      default:

        return _buildRoute(
          const NotFoundScreen(),
        );
    }
  }

  // =====================================================
  // ROUTE BUILDER
  // =====================================================

  static MaterialPageRoute
      _buildRoute(
    Widget page,
  ) {

    return MaterialPageRoute(

      builder: (_) => page,
    );
  }

  // =====================================================
  // PUSH
  // =====================================================

  static Future<dynamic> push(

    BuildContext context,

    String routeName, {

    Object? arguments,
  }) {

    return Navigator.pushNamed(

      context,

      routeName,

      arguments:
          arguments,
    );
  }

  // =====================================================
  // PUSH REPLACE
  // =====================================================

  static Future<dynamic>
      pushReplace(

    BuildContext context,

    String routeName, {

    Object? arguments,
  }) {

    return Navigator
        .pushReplacementNamed(

      context,

      routeName,

      arguments:
          arguments,
    );
  }

  // =====================================================
  // PUSH REMOVE
  // =====================================================

  static Future<dynamic>
      pushAndRemove(

    BuildContext context,

    String routeName, {

    Object? arguments,
  }) {

    return Navigator
        .pushNamedAndRemoveUntil(

      context,

      routeName,

      (route) => false,

      arguments:
          arguments,
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

  // =====================================================
  // ROLE REDIRECT
  // =====================================================

  static Future<void>
      redirectByRole({

    required BuildContext
        context,

    required String role,
  }) async {

    if (role
            .toLowerCase() ==
        'admin') {

      await pushAndRemove(

        context,

        adminDashboard,
      );
    }

    else {

      await pushAndRemove(

        context,

        userHome,
      );
    }
  }

  // =====================================================
  // AUTH REDIRECT
  // =====================================================

  static Future<void>
      logoutRedirect(
    BuildContext context,
  ) async {

    await pushAndRemove(

      context,

      login,
    );
  }

  // =====================================================
  // SAFE NAVIGATION
  // =====================================================

  static bool canPop(
    BuildContext context,
  ) {

    return Navigator.canPop(
      context,
    );
  }

  // =====================================================
  // MAYBE POP
  // =====================================================

  static void maybePop(
    BuildContext context,
  ) {

    if (canPop(context)) {

      Navigator.maybePop(
        context,
      );
    }
  }
}