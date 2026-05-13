import 'package:flutter/material.dart';

class AdminDashboardHeader
    extends StatefulWidget {

  const AdminDashboardHeader({
    super.key,
  });

  @override
  State<AdminDashboardHeader>
      createState() =>
          _AdminDashboardHeaderState();
}

class _AdminDashboardHeaderState
    extends State<AdminDashboardHeader>
    with TickerProviderStateMixin {

  late AnimationController
      _animationController;

  late Animation<double>
      _fadeAnimation;

  late Animation<Offset>
      _slideAnimation;

  @override
  void initState() {

    super.initState();

    _animationController =
        AnimationController(

      vsync: this,

      duration:
          const Duration(
        milliseconds: 500,
      ),
    );

    _fadeAnimation =
        CurvedAnimation(

      parent:
          _animationController,

      curve:
          Curves.easeInOut,
    );

    _slideAnimation =
        Tween<Offset>(

      begin:
          const Offset(
        0,
        -0.08,
      ),

      end:
          Offset.zero,

    ).animate(

      CurvedAnimation(

        parent:
            _animationController,

        curve:
            Curves.easeOut,
      ),
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
  // GREETING
  // =====================================================

  String getGreeting() {

    final hour =
        DateTime.now().hour;

    if (hour < 12) {

      return 'Good Morning';
    }

    if (hour < 17) {

      return 'Good Afternoon';
    }

    return 'Good Evening';
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    final width =
        MediaQuery.of(
          context,
        ).size.width;

    final isMobile =
        width < 900;

    return FadeTransition(

      opacity:
          _fadeAnimation,

      child:
          SlideTransition(

        position:
            _slideAnimation,

        child: Container(

          padding:
              EdgeInsets.all(
            isMobile
                ? 16
                : 18,
          ),

          decoration:
              BoxDecoration(

            color:
                Colors.white,

            borderRadius:
                BorderRadius.circular(
              24,
            ),

            boxShadow: [

              BoxShadow(

                color:
                    Colors.black
                        .withOpacity(
                  0.03,
                ),

                blurRadius:
                    12,

                offset:
                    const Offset(
                  0,
                  6,
                ),
              ),
            ],
          ),

          child:

              isMobile

                  ? mobileHeader()

                  : desktopHeader(),
        ),
      ),
    );
  }

  // =====================================================
  // DESKTOP
  // =====================================================

  Widget desktopHeader() {

    return Row(
      children: [

        // ===============================================
        // GREETING
        // ===============================================

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [

              Text(

                '${getGreeting()}, Admin 👋',

                overflow:
                    TextOverflow
                        .ellipsis,

                style:
                    const TextStyle(

                  fontSize: 22,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 5,
              ),

              Text(

                'Manage your ecommerce system efficiently.',

                overflow:
                    TextOverflow
                        .ellipsis,

                style:
                    TextStyle(

                  color:
                      Colors.grey
                          .shade600,

                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(
          width: 18,
        ),

        // ===============================================
        // ACTIONS
        // ===============================================

        notificationButton(),

        const SizedBox(
          width: 12,
        ),

        profileCard(),
      ],
    );
  }

  // =====================================================
  // MOBILE
  // =====================================================

  Widget mobileHeader() {

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment
              .start,

      children: [

        Row(
          children: [

            Builder(
              builder: (
                context,
              ) {

                return GestureDetector(

                  onTap: () {

                    Scaffold.of(
                      context,
                    ).openDrawer();
                  },

                  child: Container(

                    width: 42,

                    height: 42,

                    decoration:
                        BoxDecoration(

                      color:
                          const Color(
                        0xffF8FAFC,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        14,
                      ),
                    ),

                    child:
                        const Icon(
                      Icons.menu_rounded,
                      size: 20,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(
              width: 14,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  Text(

                    '${getGreeting()} 👋',

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

                    'Admin Dashboard',

                    overflow:
                        TextOverflow
                            .ellipsis,

                    style:
                        TextStyle(

                      color:
                          Colors.grey
                              .shade600,

                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),

            notificationButton(),
          ],
        ),

        const SizedBox(
          height: 18,
        ),

        profileCard(
          mobile: true,
        ),
      ],
    );
  }

  // =====================================================
  // NOTIFICATION
  // =====================================================

  Widget notificationButton() {

    return Stack(
      children: [

        AnimatedContainer(

          duration:
              const Duration(
            milliseconds: 250,
          ),

          width: 48,

          height: 48,

          decoration:
              BoxDecoration(

            color:
                const Color(
              0xffF8FAFC,
            ),

            borderRadius:
                BorderRadius.circular(
              16,
            ),
          ),

          child: const Icon(
            Icons
                .notifications_rounded,
            size: 22,
          ),
        ),

        Positioned(

          top: 8,

          right: 8,

          child: Container(

            width: 10,

            height: 10,

            decoration:
                const BoxDecoration(

              color:
                  Colors.red,

              shape:
                  BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  // =====================================================
  // PROFILE CARD
  // =====================================================

  Widget profileCard({
    bool mobile = false,
  }) {

    return AnimatedContainer(

      duration:
          const Duration(
        milliseconds: 250,
      ),

      padding:
          EdgeInsets.symmetric(

        horizontal:
            mobile
                ? 14
                : 16,

        vertical:
            mobile
                ? 10
                : 12,
      ),

      decoration:
          BoxDecoration(

        gradient:
            LinearGradient(

          colors: [

            Colors.blue
                .withOpacity(
              0.08,
            ),

            Colors.purple
                .withOpacity(
              0.08,
            ),
          ],
        ),

        borderRadius:
            BorderRadius.circular(
          18,
        ),
      ),

      child:

          mobile

              ? Row(
                  children: [

                    avatar(),

                    const SizedBox(
                      width: 12,
                    ),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [

                          const Text(

                            'Administrator',

                            overflow:
                                TextOverflow
                                    .ellipsis,

                            style:
                                TextStyle(

                              fontWeight:
                                  FontWeight.bold,

                              fontSize:
                                  13,
                            ),
                          ),

                          const SizedBox(
                            height: 2,
                          ),

                          Text(

                            'System Manager',

                            overflow:
                                TextOverflow
                                    .ellipsis,

                            style:
                                TextStyle(

                              color:
                                  Colors.grey
                                      .shade600,

                              fontSize:
                                  10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )

              : Row(
                  children: [

                    avatar(),

                    const SizedBox(
                      width: 12,
                    ),

                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        const Text(

                          'Administrator',

                          overflow:
                              TextOverflow
                                  .ellipsis,

                          style:
                              TextStyle(

                            fontWeight:
                                FontWeight.bold,

                            fontSize: 13,
                          ),
                        ),

                        const SizedBox(
                          height: 2,
                        ),

                        Text(

                          'System Manager',

                          overflow:
                              TextOverflow
                                  .ellipsis,

                          style:
                              TextStyle(

                            color:
                                Colors.grey
                                    .shade600,

                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
    );
  }

  // =====================================================
  // AVATAR
  // =====================================================

  Widget avatar() {

    return Container(

      width: 42,

      height: 42,

      decoration:
          const BoxDecoration(

        gradient:
            LinearGradient(

          colors: [

            Color(
              0xff2563EB,
            ),

            Color(
              0xff7C3AED,
            ),
          ],
        ),

        shape:
            BoxShape.circle,
      ),

      child: const Icon(

        Icons
            .admin_panel_settings,

        color:
            Colors.white,

        size: 20,
      ),
    );
  }
}