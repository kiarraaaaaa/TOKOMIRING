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
        milliseconds: 700,
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
        -0.15,
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
                ? 20
                : 24,
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
                    16,

                offset:
                    const Offset(
                  0,
                  8,
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

                  fontSize: 28,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 8,
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

                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(
          width: 24,
        ),

        // ===============================================
        // ACTIONS
        // ===============================================

        notificationButton(),

        const SizedBox(
          width: 16,
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

                    width: 50,

                    height: 50,

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

                    child:
                        const Icon(
                      Icons.menu_rounded,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(
              width: 16,
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

                      fontSize: 20,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 4,
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

                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            notificationButton(),
          ],
        ),

        const SizedBox(
          height: 22,
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

          width: 56,

          height: 56,

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

          child: const Icon(
            Icons
                .notifications_rounded,
          ),
        ),

        Positioned(

          top: 10,

          right: 10,

          child: Container(

            width: 12,

            height: 12,

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
                ? 16
                : 18,

        vertical:
            mobile
                ? 12
                : 14,
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
          22,
        ),
      ),

      child:

          mobile

              ? Row(
                  children: [

                    avatar(),

                    const SizedBox(
                      width: 14,
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
                                  15,
                            ),
                          ),

                          const SizedBox(
                            height: 4,
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
                                  12,
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
                      width: 14,
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

                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(
                          height: 4,
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

                            fontSize: 12,
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

      width: 50,

      height: 50,

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
      ),
    );
  }
}