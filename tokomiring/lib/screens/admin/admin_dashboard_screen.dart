import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/order_provider.dart';
import '../../providers/product_provider.dart';

import '../../widgets/admin/admin_sidebar.dart';

import 'admin_product_screen.dart';
import 'admin_order_screen.dart';
import 'admin_sales_report_screen.dart';
import 'admin_user_screen.dart';
import 'admin_notification_screen.dart';
import 'admin_profile_screen.dart';

class AdminDashboardScreen
    extends StatefulWidget {

  const AdminDashboardScreen({
    super.key,
  });

  @override
  State<AdminDashboardScreen>
      createState() =>
          _AdminDashboardScreenState();
}

class _AdminDashboardScreenState
    extends State<AdminDashboardScreen> {

  int selectedIndex = 0;

  // =====================================================
  // SCREEN
  // =====================================================

  Widget currentScreen() {

    switch (selectedIndex) {

      case 1:
        return const AdminProductScreen();

      case 2:
        return const AdminOrderScreen();

      case 3:
        return const AdminSalesReportScreen();

      case 4:
        return const AdminUserScreen();

      case 5:
        return const AdminNotificationScreen();

      case 6:
        return const AdminProfileScreen();

      default:
        return dashboardHome();
    }
  }

  // =====================================================
  // DASHBOARD HOME
  // =====================================================

  Widget dashboardHome() {

    final orderProvider =
        context.watch<OrderProvider>();

    final productProvider =
        context.watch<ProductProvider>();

    final orders =
        orderProvider.orders;

    final products =
        productProvider.allProducts;

    double revenue = 0;

    int completedOrders = 0;

    int pendingOrders = 0;

    for (final order in orders) {

      if (order.status
              .toLowerCase() ==
          'completed') {

        revenue +=
            order.totalPrice;

        completedOrders++;
      }

      if (order.status
              .toLowerCase() !=
          'completed') {

        pendingOrders++;
      }
    }

    return SingleChildScrollView(

      padding:
          const EdgeInsets.all(
        16,
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment
                .start,

        children: [

          Text(

            'Admin Dashboard',

            style: TextStyle(

              fontSize:
                  MediaQuery.of(context)
                              .size
                              .width <
                          700

                      ? 20

                      : 26,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 4,
          ),

          Text(

            'Realtime ecommerce analytics.',

            style: TextStyle(

              fontSize: 11,

              color:
                  Colors.grey.shade600,
            ),
          ),

          const SizedBox(
            height: 18,
          ),

          // =================================================
          // STATS
          // =================================================

          LayoutBuilder(

            builder:
                (
                  context,
                  constraints,
                ) {

              int count = 4;

              if (constraints
                      .maxWidth <
                  700) {

                count = 1;

              } else if (constraints
                      .maxWidth <
                  1100) {

                count = 2;
              }

              return GridView.count(

                crossAxisCount:
                    count,

                shrinkWrap: true,

                physics:
                    const NeverScrollableScrollPhysics(),

                crossAxisSpacing:
                    10,

                mainAxisSpacing:
                    10,

                childAspectRatio:
                    2.7,

                children: [

                  statsCard(

                    title:
                        'Revenue',

                    value:
                        'Rp ${revenue.toStringAsFixed(0)}',

                    icon:
                        Icons.payments_rounded,

                    color:
                        Colors.green,
                  ),

                  statsCard(

                    title:
                        'Transactions',

                    value:
                        completedOrders
                            .toString(),

                    icon:
                        Icons.receipt_long_rounded,

                    color:
                        Colors.blue,
                  ),

                  statsCard(

                    title:
                        'Products',

                    value:
                        products.length
                            .toString(),

                    icon:
                        Icons.inventory_2_rounded,

                    color:
                        Colors.orange,
                  ),

                  statsCard(

                    title:
                        'Pending',

                    value:
                        pendingOrders
                            .toString(),

                    icon:
                        Icons.access_time_rounded,

                    color:
                        Colors.red,
                  ),
                ],
              );
            },
          ),

          const SizedBox(
            height: 18,
          ),

          // =================================================
          // MENU GRID
          // =================================================

          LayoutBuilder(

            builder:
                (
                  context,
                  constraints,
                ) {

              int count = 3;

              if (constraints
                      .maxWidth <
                  700) {

                count = 1;

              } else if (constraints
                      .maxWidth <
                  1050) {

                count = 2;
              }

              return GridView.count(

                crossAxisCount:
                    count,

                shrinkWrap: true,

                physics:
                    const NeverScrollableScrollPhysics(),

                crossAxisSpacing:
                    10,

                mainAxisSpacing:
                    10,

                childAspectRatio:
                    2.05,

                children: [

                  dashboardCard(
                    title: 'Products',
                    subtitle:
                        'Manage inventory',
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
                    title: 'Orders',
                    subtitle:
                        'Customer orders',
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
                    title: 'Reports',
                    subtitle:
                        'Sales analytics',
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
                    title: 'Users',
                    subtitle:
                        'Manage users',
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
                        'Realtime activity',
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

                  dashboardCard(
                    title:
                        'Profile',
                    subtitle:
                        'Manage account',
                    icon:
                        Icons.person,
                    color:
                        Colors.indigo,
                    onTap: () {

                      setState(() {

                        selectedIndex =
                            6;
                      });
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // =====================================================
  // STATS CARD
  // =====================================================

  Widget statsCard({

    required String title,

    required String value,

    required IconData icon,

    required Color color,
  }) {

    return Container(

      padding:
          const EdgeInsets.all(
        12,
      ),

      decoration:
          BoxDecoration(

        color:
            Colors.white,

        borderRadius:
            BorderRadius.circular(
          18,
        ),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black
                    .withOpacity(
              0.02,
            ),

            blurRadius:
                8,

            offset:
                const Offset(
              0,
              3,
            ),
          ),
        ],
      ),

      child: Row(
        children: [

          Container(

            width: 42,

            height: 42,

            decoration:
                BoxDecoration(

              color:
                  color.withOpacity(
                0.12,
              ),

              borderRadius:
                  BorderRadius.circular(
                12,
              ),
            ),

            child: Icon(

              icon,

              color: color,

              size: 20,
            ),
          ),

          const SizedBox(
            width: 10,
          ),

          Expanded(
            child: Column(

              mainAxisAlignment:
                  MainAxisAlignment
                      .center,

              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                Text(

                  value,

                  maxLines: 1,

                  overflow:
                      TextOverflow
                          .ellipsis,

                  style:
                      const TextStyle(

                    fontSize: 18,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 2,
                ),

                Text(

                  title,

                  style: TextStyle(

                    fontSize: 10,

                    color:
                        Colors.grey
                            .shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // MENU CARD
  // =====================================================

  Widget dashboardCard({

    required String title,

    required String subtitle,

    required IconData icon,

    required Color color,

    required VoidCallback onTap,
  }) {

    return InkWell(

      borderRadius:
          BorderRadius.circular(
        18,
      ),

      onTap: onTap,

      child: Container(

        padding:
            const EdgeInsets.all(
          14,
        ),

        decoration:
            BoxDecoration(

          color:
              Colors.white,

          borderRadius:
              BorderRadius.circular(
            18,
          ),

          boxShadow: [

            BoxShadow(

              color:
                  Colors.black
                      .withOpacity(
                0.02,
              ),

              blurRadius:
                  8,

              offset:
                  const Offset(
                0,
                3,
              ),
            ),
          ],
        ),

        child: Row(
          children: [

            Container(

              width: 46,

              height: 46,

              decoration:
                  BoxDecoration(

                color:
                    color.withOpacity(
                  0.12,
                ),

                borderRadius:
                    BorderRadius.circular(
                  14,
                ),
              ),

              child: Icon(

                icon,

                color: color,

                size: 22,
              ),
            ),

            const SizedBox(
              width: 12,
            ),

            Expanded(
              child: Column(

                mainAxisAlignment:
                    MainAxisAlignment
                        .center,

                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  Text(

                    title,

                    maxLines: 1,

                    overflow:
                        TextOverflow
                            .ellipsis,

                    style:
                        const TextStyle(

                      fontSize: 14,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 2,
                  ),

                  Text(

                    subtitle,

                    maxLines: 1,

                    overflow:
                        TextOverflow
                            .ellipsis,

                    style: TextStyle(

                      fontSize: 10,

                      color:
                          Colors.grey
                              .shade600,
                    ),
                  ),
                ],
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

      body: SafeArea(

        child: Row(
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

              onLogout: () async {

                await context
                    .read<AuthProvider>()
                    .logout();

                if (!context.mounted) {
                  return;
                }

                Navigator.pushNamedAndRemoveUntil(

                  context,

                  '/welcome',

                  (route) => false,
                );
              },
            ),

            Expanded(

              child: Container(

                color:
                    const Color(
                  0xffF8FAFC,
                ),

                child:
                    currentScreen(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}