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

    final width =
        MediaQuery.of(context)
            .size
            .width;

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

    int statsCount = 4;

    if (width < 650) {

      statsCount = 1;

    } else if (width < 1050) {

      statsCount = 2;
    }

    int menuCount = 3;

    if (width < 650) {

      menuCount = 1;

    } else if (width < 1100) {

      menuCount = 2;
    }

    return SingleChildScrollView(

      physics:
          const BouncingScrollPhysics(),

      padding:
          const EdgeInsets.all(
        14,
      ),

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

                  width < 700
                      ? 22
                      : 30,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 3,
          ),

          Text(

            'Realtime ecommerce analytics.',

            style:
                TextStyle(

              fontSize: 10,

              color:
                  Colors.grey
                      .shade600,
            ),
          ),

          const SizedBox(
            height: 14,
          ),

          // =================================================
          // STATS GRID
          // =================================================

          GridView.builder(

            shrinkWrap:
                true,

            physics:
                const NeverScrollableScrollPhysics(),

            itemCount: 4,

            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(

              crossAxisCount:
                  statsCount,

              crossAxisSpacing:
                  10,

              mainAxisSpacing:
                  10,

              mainAxisExtent:
                  90,
            ),

            itemBuilder:
                (
                  context,
                  index,
                ) {

              final stats = [

                {
                  'title':
                      'Revenue',

                  'value':
                      'Rp ${revenue.toStringAsFixed(0)}',

                  'icon':
                      Icons.payments_rounded,

                  'color':
                      Colors.green,
                },

                {
                  'title':
                      'Transactions',

                  'value':
                      completedOrders
                          .toString(),

                  'icon':
                      Icons.receipt_long_rounded,

                  'color':
                      Colors.blue,
                },

                {
                  'title':
                      'Products',

                  'value':
                      products.length
                          .toString(),

                  'icon':
                      Icons.inventory_2_rounded,

                  'color':
                      Colors.orange,
                },

                {
                  'title':
                      'Pending',

                  'value':
                      pendingOrders
                          .toString(),

                  'icon':
                      Icons.access_time_rounded,

                  'color':
                      Colors.red,
                },
              ];

              final item =
                  stats[index];

              return statsCard(

                title:
                    item['title']
                        as String,

                value:
                    item['value']
                        as String,

                icon:
                    item['icon']
                        as IconData,

                color:
                    item['color']
                        as Color,
              );
            },
          ),

          const SizedBox(
            height: 14,
          ),

          // =================================================
          // MENU GRID
          // =================================================

          GridView.builder(

            shrinkWrap:
                true,

            physics:
                const NeverScrollableScrollPhysics(),

            itemCount: 6,

            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(

              crossAxisCount:
                  menuCount,

              crossAxisSpacing:
                  10,

              mainAxisSpacing:
                  10,

              mainAxisExtent:
                  96,
            ),

            itemBuilder:
                (
                  context,
                  index,
                ) {

              final menus = [

                {
                  'title':
                      'Products',

                  'subtitle':
                      'Manage inventory',

                  'icon':
                      Icons.inventory_2,

                  'color':
                      Colors.blue,

                  'page':
                      1,
                },

                {
                  'title':
                      'Orders',

                  'subtitle':
                      'Customer orders',

                  'icon':
                      Icons.shopping_bag,

                  'color':
                      Colors.orange,

                  'page':
                      2,
                },

                {
                  'title':
                      'Reports',

                  'subtitle':
                      'Sales analytics',

                  'icon':
                      Icons.bar_chart,

                  'color':
                      Colors.green,

                  'page':
                      3,
                },

                {
                  'title':
                      'Users',

                  'subtitle':
                      'Manage users',

                  'icon':
                      Icons.people,

                  'color':
                      Colors.purple,

                  'page':
                      4,
                },

                {
                  'title':
                      'Notifications',

                  'subtitle':
                      'Realtime activity',

                  'icon':
                      Icons.notifications,

                  'color':
                      Colors.red,

                  'page':
                      5,
                },

                {
                  'title':
                      'Profile',

                  'subtitle':
                      'Manage account',

                  'icon':
                      Icons.person,

                  'color':
                      Colors.indigo,

                  'page':
                      6,
                },
              ];

              final item =
                  menus[index];

              return dashboardCard(

                title:
                    item['title']
                        as String,

                subtitle:
                    item['subtitle']
                        as String,

                icon:
                    item['icon']
                        as IconData,

                color:
                    item['color']
                        as Color,

                onTap: () {

                  setState(() {

                    selectedIndex =
                        item['page']
                            as int;
                  });
                },
              );
            },
          ),

          const SizedBox(
            height: 60,
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
          16,
        ),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black
                    .withOpacity(
              0.02,
            ),

            blurRadius: 8,

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

            width: 36,

            height: 36,

            decoration:
                BoxDecoration(

              color:
                  color.withOpacity(
                0.12,
              ),

              borderRadius:
                  BorderRadius.circular(
                10,
              ),
            ),

            child: Icon(

              icon,

              color: color,

              size: 17,
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

                    fontSize: 14,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 1,
                ),

                Text(

                  title,

                  overflow:
                      TextOverflow
                          .ellipsis,

                  style:
                      TextStyle(

                    fontSize: 9.5,

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
        16,
      ),

      onTap: onTap,

      child: Container(

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
            16,
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

              width: 40,

              height: 40,

              decoration:
                  BoxDecoration(

                color:
                    color.withOpacity(
                  0.12,
                ),

                borderRadius:
                    BorderRadius.circular(
                  11,
                ),
              ),

              child: Icon(

                icon,

                color: color,

                size: 18,
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

                    title,

                    maxLines: 1,

                    overflow:
                        TextOverflow
                            .ellipsis,

                    style:
                        const TextStyle(

                      fontSize: 12,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 1,
                  ),

                  Text(

                    subtitle,

                    maxLines: 1,

                    overflow:
                        TextOverflow
                            .ellipsis,

                    style:
                        TextStyle(

                      fontSize: 9,

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

  // =====================================================
  // BUILD
  // =====================================================

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