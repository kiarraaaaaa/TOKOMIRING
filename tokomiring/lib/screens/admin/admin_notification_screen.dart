import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../services/notification_service.dart';

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

  final NotificationService
      _notificationService =
      NotificationService();

  String selectedTab =
      'Notifications';

  final List<String> tabs = [

    'Notifications',

    'Activity',

    'System Logs',
  ];

  // =====================================================
  // REALTIME CLOCK
  // =====================================================

  final ValueNotifier<String>
      realtimeClock =
      ValueNotifier<String>('');

  Timer? clockTimer;

  void startRealtimeClock() {

    realtimeClock.value =
        formattedRealtime();

    clockTimer = Timer.periodic(

      const Duration(
        seconds: 1,
      ),

      (_) {

        realtimeClock.value =
            formattedRealtime();
      },
    );
  }

  String formattedRealtime() {

    final now =
        DateTime.now();

    final date =
        DateFormat(
      'dd MMM yyyy',
    ).format(now);

    final time =
        DateFormat(
      'HH:mm:ss',
    ).format(now);

    return '$date • $time';
  }

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

    // ===============================================
    // START CLOCK
    // ===============================================

    startRealtimeClock();
  }

  @override
  void dispose() {

    clockTimer?.cancel();

    realtimeClock.dispose();

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
            18,
          ),

          child:
              Column(

            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [

              const AdminDashboardHeader(),

              const SizedBox(
                height: 20,
              ),

              // =================================================
              // TITLE
              // =================================================

              Text(

                'Notifications Center',

                style:
                    TextStyle(

                  fontSize:
                      MediaQuery.of(
                                context,
                              ).size.width <
                              700
                          ? 22
                          : 28,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 6,
              ),

              Text(

                'Realtime admin notifications and activities.',

                style:
                    TextStyle(

                  color:
                      Colors.grey
                          .shade600,

                  fontSize: 12,
                ),
              ),

              const SizedBox(
                height: 14,
              ),

              // =================================================
              // REALTIME CLOCK
              // =================================================

              ValueListenableBuilder<String>(

                valueListenable:
                    realtimeClock,

                builder: (

                  context,

                  value,

                  _,

                ) {

                  return Container(

                    padding:
                        const EdgeInsets.symmetric(

                      horizontal: 16,

                      vertical: 12,
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

                    child:
                        Row(

                      mainAxisSize:
                          MainAxisSize.min,

                      children: [

                        const Icon(

                          Icons.access_time,

                          size: 18,
                        ),

                        const SizedBox(
                          width: 10,
                        ),

                        Text(

                          value,

                          style:
                              const TextStyle(

                            fontWeight:
                                FontWeight.bold,

                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(
                height: 20,
              ),

              // =================================================
              // TABS
              // =================================================

              SingleChildScrollView(

                scrollDirection:
                    Axis.horizontal,

                child:
                    Row(

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
                          right: 10,
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
                                  18,

                              vertical:
                                  12,
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
                                14,
                              ),
                            ),

                            child:
                                Text(

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

                                fontSize: 12,
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
                height: 20,
              ),

              // =================================================
              // FIREBASE NOTIFICATIONS
              // =================================================

              StreamBuilder<List<Map<String, dynamic>>>(

                stream:
                    _notificationService
                        .getNotifications(

                  role: 'admin',
                ),

                builder: (

                  context,

                  snapshot,

                ) {

                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {

                    return const Center(

                      child:
                          Padding(

                        padding:
                            EdgeInsets.all(
                          30,
                        ),

                        child:
                            CircularProgressIndicator(),
                      ),
                    );
                  }

                  final notifications =
                      snapshot.data ?? [];

                  if (notifications
                      .isEmpty) {

                    return Container(

                      width:
                          double.infinity,

                      padding:
                          const EdgeInsets.all(
                        40,
                      ),

                      decoration:
                          BoxDecoration(

                        color:
                            Colors.white,

                        borderRadius:
                            BorderRadius.circular(
                          22,
                        ),
                      ),

                      child:
                          const Center(

                        child:
                            Text(
                          'No notifications yet',
                        ),
                      ),
                    );
                  }

                  return buildSection(

                    title:
                        'Realtime Notifications',

                    items:
                        notifications,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // ICON
  // =====================================================

  IconData notificationIcon(
    String type,
  ) {

    switch (type
        .toLowerCase()) {

      case 'order':

        return Icons
            .shopping_bag_rounded;

      case 'payment':

        return Icons
            .payments_rounded;

      case 'validation':

        return Icons
            .check_circle_rounded;

      case 'status':

        return Icons
            .local_shipping_rounded;

      case 'stock':

        return Icons
            .warning_amber_rounded;

      default:

        return Icons
            .notifications_rounded;
    }
  }

  // =====================================================
  // COLOR
  // =====================================================

  Color notificationColor(
    String type,
  ) {

    switch (type
        .toLowerCase()) {

      case 'order':

        return Colors.blue;

      case 'payment':

        return Colors.green;

      case 'validation':

        return Colors.orange;

      case 'status':

        return Colors.purple;

      case 'stock':

        return Colors.red;

      default:

        return Colors.grey;
    }
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

      child:
          Column(

        crossAxisAlignment:
            CrossAxisAlignment
                .start,

        children: [

          Row(

            mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,

            children: [

              Text(

                title,

                style:
                    const TextStyle(

                  fontSize: 20,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              Container(

                padding:
                    const EdgeInsets.symmetric(

                  horizontal: 12,

                  vertical: 7,
                ),

                decoration:
                    BoxDecoration(

                  color:
                      Colors.green
                          .withOpacity(
                    0.1,
                  ),

                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                ),

                child:
                    const Text(

                  'LIVE',

                  style:
                      TextStyle(
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 18,
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
                height: 12,
              );
            },

            itemBuilder:
                (
                  context,
                  index,
                ) {

              final item =
                  items[index];

              final type =
                  item['type']
                          ?.toString() ??
                      '';

              final color =
                  notificationColor(
                type,
              );

              final icon =
                  notificationIcon(
                type,
              );

              return Container(

                padding:
                    const EdgeInsets.all(
                  16,
                ),

                decoration:
                    BoxDecoration(

                  color:
                      const Color(
                    0xffF8FAFC,
                  ),

                  borderRadius:
                      BorderRadius.circular(
                    18,
                  ),
                ),

                child:
                    Row(
                  children: [

                    Container(

                      width: 54,

                      height: 54,

                      decoration:
                          BoxDecoration(

                        color:
                            color
                                .withOpacity(
                          0.12,
                        ),

                        borderRadius:
                            BorderRadius.circular(
                          16,
                        ),
                      ),

                      child:
                          Icon(

                        icon,

                        color:
                            color,

                        size: 24,
                      ),
                    ),

                    const SizedBox(
                      width: 14,
                    ),

                    Expanded(

                      child:
                          Column(

                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [

                          Text(

                            item['title']
                                    ?.toString() ??
                                '',

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
                            height: 5,
                          ),

                          Text(

                            item['message']
                                    ?.toString() ??
                                '',

                            style:
                                const TextStyle(
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    Column(

                      crossAxisAlignment:
                          CrossAxisAlignment
                              .end,

                      children: [

                        Text(

                          item['time']
                                  ?.toString() ??
                              '--:--',

                          style:
                              TextStyle(

                            color:
                                Colors.grey
                                    .shade700,

                            fontWeight:
                                FontWeight.bold,

                            fontSize: 11,
                          ),
                        ),

                        const SizedBox(
                          height: 2,
                        ),

                        Text(

                          item['date']
                                  ?.toString() ??
                              '-- --- ----',

                          style:
                              TextStyle(

                            color:
                                Colors.grey
                                    .shade500,

                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}