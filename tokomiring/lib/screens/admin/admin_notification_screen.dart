// =====================================================
// FULL FIXED VERSION
// lib/screens/admin/admin_notification_screen.dart
// =====================================================

import 'package:flutter/material.dart';

import '../../widgets/admin/admin_dashboard_header.dart';

class AdminNotificationScreen
    extends StatefulWidget {

  const AdminNotificationScreen({
    super.key,
  });

  @override
  State<AdminNotificationScreen>
      createState() =>
          _AdminNotificationScreenState();
}

class _AdminNotificationScreenState
    extends State<AdminNotificationScreen>
    with TickerProviderStateMixin {

  late AnimationController
      _animationController;

  late Animation<double>
      _fadeAnimation;

  String selectedTab =
      'Notifications';

  final List<String> tabs = [

    'Notifications',

    'Activity',

    'System Logs',
  ];

  final List<Map<String, dynamic>>
      notifications = [

    {
      'title':
          'New Order Received',

      'description':
          'Customer has successfully placed a new order.',

      'time':
          '2 minutes ago',

      'icon':
          Icons.shopping_bag_rounded,

      'color':
          Colors.blue,
    },

    {
      'title':
          'Payment Confirmed',

      'description':
          'Payment from customer has been confirmed.',

      'time':
          '15 minutes ago',

      'icon':
          Icons.payments_rounded,

      'color':
          Colors.green,
    },

    {
      'title':
          'Low Stock Warning',

      'description':
          'Several products are running low on stock.',

      'time':
          '40 minutes ago',

      'icon':
          Icons.warning_amber_rounded,

      'color':
          Colors.orange,
    },
  ];

  final List<Map<String, dynamic>>
      activities = [

    {
      'title':
          'Admin Updated Product',

      'description':
          'Product stock and price have been updated.',

      'time':
          '1 hour ago',

      'icon':
          Icons.edit_rounded,

      'color':
          Colors.purple,
    },

    {
      'title':
          'Order Validated',

      'description':
          'Customer order successfully validated.',

      'time':
          '2 hours ago',

      'icon':
          Icons.check_circle_rounded,

      'color':
          Colors.green,
    },

    {
      'title':
          'User Account Banned',

      'description':
          'Suspicious account has been disabled.',

      'time':
          '5 hours ago',

      'icon':
          Icons.block_rounded,

      'color':
          Colors.red,
    },
  ];

  final List<Map<String, dynamic>>
      systemLogs = [

    {
      'title':
          'Database Backup Completed',

      'description':
          'Realtime database backup completed successfully.',

      'time':
          'Today 01:40',

      'icon':
          Icons.storage_rounded,

      'color':
          Colors.blue,
    },

    {
      'title':
          'Server Restarted',

      'description':
          'System server restarted automatically.',

      'time':
          'Today 03:12',

      'icon':
          Icons.restart_alt_rounded,

      'color':
          Colors.orange,
    },

    {
      'title':
          'Firebase Connected',

      'description':
          'All Firebase services are online and active.',

      'time':
          'Today 04:10',

      'icon':
          Icons.cloud_done_rounded,

      'color':
          Colors.green,
    },
  ];

  @override
  void initState() {

    super.initState();

    _animationController =
        AnimationController(

      vsync: this,

      duration:
          const Duration(
        milliseconds: 450,
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

  @override
  Widget build(
    BuildContext context,
  ) {

    return FadeTransition(

      opacity:
          _fadeAnimation,

      child:
          Scaffold(

        backgroundColor:
            const Color(
          0xffF8FAFC,
        ),

        body:
            SingleChildScrollView(

          padding:
              const EdgeInsets.all(
            24,
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [

              const AdminDashboardHeader(),

              const SizedBox(
                height: 30,
              ),

              // =================================================
              // TITLE
              // =================================================

              Text(

                'Notifications Center',

                style: TextStyle(

                  fontSize:
                      MediaQuery.of(
                                context,
                              ).size.width <
                              700
                          ? 26
                          : 34,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Text(

                'Manage admin notifications, activities, and system logs.',

                style: TextStyle(

                  color:
                      Colors.grey
                          .shade600,

                  fontSize: 15,
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              // =================================================
              // TABS
              // =================================================

              SingleChildScrollView(

                scrollDirection:
                    Axis.horizontal,

                child: Row(

                  children:
                      tabs.map(
                    (
                      tab,
                    ) {

                      final isSelected =
                          selectedTab ==
                              tab;

                      return Padding(

                        padding:
                            const EdgeInsets.only(
                          right: 14,
                        ),

                        child:
                            GestureDetector(

                          onTap: () {

                            setState(() {

                              selectedTab =
                                  tab;
                            });
                          },

                          child:
                              AnimatedContainer(

                            duration:
                                const Duration(
                              milliseconds:
                                  250,
                            ),

                            padding:
                                const EdgeInsets.symmetric(

                              horizontal:
                                  22,

                              vertical:
                                  14,
                            ),

                            decoration:
                                BoxDecoration(

                              color:
                                  isSelected

                                      ? Colors
                                          .blue

                                      : Colors
                                          .white,

                              borderRadius:
                                  BorderRadius.circular(
                                18,
                              ),

                              boxShadow: [

                                if (isSelected)

                                  BoxShadow(

                                    color:
                                        Colors.blue
                                            .withOpacity(
                                      0.2,
                                    ),

                                    blurRadius:
                                        12,
                                  ),
                              ],
                            ),

                            child: Text(

                              tab,

                              style:
                                  TextStyle(

                                color:
                                    isSelected

                                        ? Colors
                                            .white

                                        : Colors
                                            .black,

                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              if (selectedTab ==
                  'Notifications')

                buildSection(
                  title:
                      'Admin Notifications',

                  items:
                      notifications,
                ),

              if (selectedTab ==
                  'Activity')

                buildSection(
                  title:
                      'Recent Activities',

                  items:
                      activities,
                ),

              if (selectedTab ==
                  'System Logs')

                buildSection(
                  title:
                      'System Logs',

                  items:
                      systemLogs,
                ),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // SECTION
  // =====================================================

  Widget buildSection({

    required String title,

    required List<
            Map<String, dynamic>>
        items,
  }) {

    return Container(

      width:
          double.infinity,

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
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment
                .start,

        children: [

          Text(

            title,

            style:
                const TextStyle(

              fontSize: 24,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 24,
          ),

          ListView.separated(

            shrinkWrap: true,

            physics:
                const NeverScrollableScrollPhysics(),

            itemCount:
                items.length,

            separatorBuilder:
                (
                  context,
                  index,
                ) {

              return const SizedBox(
                height: 18,
              );
            },

            itemBuilder:
                (
                  context,
                  index,
                ) {

              final item =
                  items[index];

              return AnimatedContainer(

                duration:
                    const Duration(
                  milliseconds:
                      250,
                ),

                padding:
                    const EdgeInsets.all(
                  22,
                ),

                decoration:
                    BoxDecoration(

                  color:
                      const Color(
                    0xffF8FAFC,
                  ),

                  borderRadius:
                      BorderRadius.circular(
                    24,
                  ),
                ),

                child:

                    MediaQuery.of(
                                  context,
                                ).size.width <
                            700

                        ? mobileTile(
                            item,
                          )

                        : desktopTile(
                            item,
                          ),
              );
            },
          ),
        ],
      ),
    );
  }

  // =====================================================
  // DESKTOP TILE
  // =====================================================

  Widget desktopTile(
    Map<String, dynamic>
        item,
  ) {

    return Row(
      children: [

        Container(

          width: 70,

          height: 70,

          decoration:
              BoxDecoration(

            color:
                item['color']
                    .withOpacity(
              0.12,
            ),

            borderRadius:
                BorderRadius.circular(
              22,
            ),
          ),

          child: Icon(

            item['icon'],

            color:
                item['color'],

            size: 34,
          ),
        ),

        const SizedBox(
          width: 20,
        ),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [

              Text(

                item['title'],

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
                height: 8,
              ),

              Text(

                item[
                    'description'],

                style:
                    TextStyle(

                  color:
                      Colors.grey
                          .shade700,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(
          width: 16,
        ),

        Text(

          item['time'],

          style: TextStyle(

            color:
                Colors.grey
                    .shade600,

            fontSize: 13,
          ),
        ),
      ],
    );
  }

  // =====================================================
  // MOBILE TILE
  // =====================================================

  Widget mobileTile(
    Map<String, dynamic>
        item,
  ) {

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment
              .start,

      children: [

        Row(
          children: [

            Container(

              width: 58,

              height: 58,

              decoration:
                  BoxDecoration(

                color:
                    item['color']
                        .withOpacity(
                  0.12,
                ),

                borderRadius:
                    BorderRadius.circular(
                  18,
                ),
              ),

              child: Icon(

                item['icon'],

                color:
                    item['color'],

                size: 30,
              ),
            ),

            const SizedBox(
              width: 16,
            ),

            Expanded(
              child: Text(

                item['title'],

                overflow:
                    TextOverflow
                        .ellipsis,

                style:
                    const TextStyle(

                  fontWeight:
                      FontWeight.bold,

                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(
          height: 16,
        ),

        Text(

          item['description'],

          style: TextStyle(

            color:
                Colors.grey
                    .shade700,
          ),
        ),

        const SizedBox(
          height: 14,
        ),

        Text(

          item['time'],

          style: TextStyle(

            color:
                Colors.grey
                    .shade600,

            fontSize: 13,
          ),
        ),
      ],
    );
  }
}