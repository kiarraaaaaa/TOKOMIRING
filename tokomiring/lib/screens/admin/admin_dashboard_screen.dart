// =====================================================
// FULL FIXED VERSION
// lib/screens/admin/admin_dashboard_screen.dart
// NO CONST ERROR
// =====================================================

import 'package:flutter/material.dart';

import '../../widgets/admin/admin_sidebar.dart';

import 'admin_product_screen.dart';
import 'admin_order_screen.dart';
import 'admin_sales_report_screen.dart';
import 'admin_user_screen.dart';
import 'admin_notification_screen.dart';

class AdminDashboardScreen
    extends StatefulWidget {

  // ===================================================
  // FIXED
  // ===================================================

  AdminDashboardScreen({
    super.key,
  });

  @override
  State<AdminDashboardScreen>
      createState() =>
          _AdminDashboardScreenState();
}

class _AdminDashboardScreenState
    extends State<AdminDashboardScreen>
    with TickerProviderStateMixin {

  int selectedIndex = 0;

  late AnimationController
      _animationController;

  late Animation<double>
      _fadeAnimation;

  @override
  void initState() {

    super.initState();

    _animationController =
        AnimationController(

      vsync: this,

      duration:
          const Duration(
        milliseconds: 400,
      ),
    );

    _fadeAnimation =
        CurvedAnimation(

      parent:
          _animationController,

      curve:
          Curves.easeInOut,
    );

    _animationController
        .forward();
  }

  @override
  void dispose() {

    _animationController
        .dispose();

    super.dispose();
  }

  // =====================================================
  // SCREENS
  // =====================================================

  Widget currentScreen() {

    switch (selectedIndex) {

      // ===============================================
      // DASHBOARD
      // ===============================================

      case 0:

        return dashboardHome();

      // ===============================================
      // PRODUCTS
      // ===============================================

      case 1:

        return AdminProductScreen();

      // ===============================================
      // ORDERS
      // ===============================================

      case 2:

        return AdminOrderScreen();

      // ===============================================
      // REPORTS
      // ===============================================

      case 3:

        return AdminSalesReportScreen();

      // ===============================================
      // USERS
      // ===============================================

      case 4:

        return AdminUserScreen();

      // ===============================================
      // NOTIFICATIONS
      // ===============================================

      case 5:

        return AdminNotificationScreen();

      default:

        return dashboardHome();
    }
  }

  // =====================================================
  // DASHBOARD HOME
  // =====================================================

  Widget dashboardHome() {

    return FadeTransition(

      opacity:
          _fadeAnimation,

      child:
          SingleChildScrollView(

        padding:
            const EdgeInsets.all(
          30,
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment
                  .start,

          children: [

            // =========================================
            // HEADER
            // =========================================

            Row(
              children: [

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [

                      Text(

                        'Admin Dashboard',

                        style:
                            TextStyle(

                          fontSize:
                              MediaQuery.of(
                                            context,
                                          ).size.width <
                                          700

                                  ? 28

                                  : 38,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Text(

                        'Manage products, orders, reports, users and notifications.',

                        style:
                            TextStyle(

                          color:
                              Colors.grey
                                  .shade600,

                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(

                  padding:
                      const EdgeInsets.all(
                    18,
                  ),

                  decoration:
                      BoxDecoration(

                    color:
                        Colors.white,

                    borderRadius:
                        BorderRadius.circular(
                      24,
                    ),
                  ),

                  child: const Icon(

                    Icons
                        .admin_panel_settings,

                    size: 40,

                    color:
                        Colors.blue,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 35,
            ),

            // =========================================
            // QUICK MENU
            // =========================================

            GridView(

              shrinkWrap: true,

              physics:
                  const NeverScrollableScrollPhysics(),

              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(

                crossAxisCount:

                    MediaQuery.of(
                                  context,
                                ).size.width <
                                700

                        ? 1

                        : MediaQuery.of(
                                      context,
                                    ).size.width <
                                    1200

                            ? 2

                            : 3,

                crossAxisSpacing:
                    20,

                mainAxisSpacing:
                    20,

                childAspectRatio:
                    1.6,
              ),

              children: [

                dashboardCard(

                  title:
                      'Products',

                  subtitle:
                      'Manage product inventory',

                  icon:
                      Icons.inventory_2,

                  color:
                      Colors.blue,

                  onTap: () {

                    setState(() {

                      selectedIndex =
                          1;
                    });
                  },
                ),

                dashboardCard(

                  title:
                      'Orders',

                  subtitle:
                      'Monitor customer orders',

                  icon:
                      Icons.shopping_bag,

                  color:
                      Colors.orange,

                  onTap: () {

                    setState(() {

                      selectedIndex =
                          2;
                    });
                  },
                ),

                dashboardCard(

                  title:
                      'Reports',

                  subtitle:
                      'Sales analytics & revenue',

                  icon:
                      Icons.bar_chart,

                  color:
                      Colors.green,

                  onTap: () {

                    setState(() {

                      selectedIndex =
                          3;
                    });
                  },
                ),

                dashboardCard(

                  title:
                      'Users',

                  subtitle:
                      'User management system',

                  icon:
                      Icons.people,

                  color:
                      Colors.purple,

                  onTap: () {

                    setState(() {

                      selectedIndex =
                          4;
                    });
                  },
                ),

                dashboardCard(

                  title:
                      'Notifications',

                  subtitle:
                      'System activity & logs',

                  icon:
                      Icons.notifications,

                  color:
                      Colors.red,

                  onTap: () {

                    setState(() {

                      selectedIndex =
                          5;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // CARD
  // =====================================================

  Widget dashboardCard({

    required String title,

    required String subtitle,

    required IconData icon,

    required Color color,

    required VoidCallback onTap,
  }) {

    return GestureDetector(

      onTap: onTap,

      child:
          AnimatedContainer(

        duration:
            const Duration(
          milliseconds: 250,
        ),

        padding:
            const EdgeInsets.all(
          24,
        ),

        decoration:
            BoxDecoration(

          color:
              Colors.white,

          borderRadius:
              BorderRadius.circular(
            30,
          ),

          boxShadow: [

            BoxShadow(

              color:
                  Colors.black
                      .withOpacity(
                0.04,
              ),

              blurRadius:
                  14,

              offset:
                  const Offset(
                0,
                8,
              ),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment
                  .start,

          children: [

            Container(

              width: 65,

              height: 65,

              decoration:
                  BoxDecoration(

                color:
                    color.withOpacity(
                  0.12,
                ),

                borderRadius:
                    BorderRadius.circular(
                  22,
                ),
              ),

              child: Icon(

                icon,

                color: color,

                size: 34,
              ),
            ),

            const Spacer(),

            Text(

              title,

              style:
                  const TextStyle(

                fontSize: 22,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Text(

              subtitle,

              style:
                  TextStyle(

                color:
                    Colors.grey
                        .shade600,

                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    return Scaffold(

      backgroundColor:
          const Color(
        0xffF8FAFC,
      ),

      body: Row(
        children: [

          AdminSidebar(

            selectedIndex:
                selectedIndex,

            onSelected:
                (
                  index,
                ) {

              setState(() {

                selectedIndex =
                    index;
              });
            },

            onLogout: () {

              Navigator.pop(
                context,
              );
            },
          ),

          Expanded(
            child: currentScreen(),
          ),
        ],
      ),
    );
  }
}