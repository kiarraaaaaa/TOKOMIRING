// lib/widgets/user/user_dashboard_header.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';

import '../../providers/auth_provider.dart';

class UserDashboardHeader
    extends StatefulWidget {

  final VoidCallback?
      onNotificationTap;

  final VoidCallback?
      onProfileTap;

  final VoidCallback?
      onSearchTap;

  final String? title;

  final String? subtitle;

  const UserDashboardHeader({

    super.key,

    this.onNotificationTap,

    this.onProfileTap,

    this.onSearchTap,

    this.title,

    this.subtitle,
  });

  @override
  State<UserDashboardHeader>
      createState() =>
          _UserDashboardHeaderState();
}

class _UserDashboardHeaderState
    extends State<UserDashboardHeader>
    with
        SingleTickerProviderStateMixin {

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
        milliseconds: 500,
      ),
    );

    _fadeAnimation =
        CurvedAnimation(

      parent:
          _animationController,

      curve:
          Curves.easeOut,
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

    final authProvider =
        context.watch<
            AuthProvider>();

    final user =
        authProvider.user;

    final screenWidth =
        MediaQuery.of(context)
            .size
            .width;

    final isMobile =
        screenWidth < 700;

    final title =
        widget.title ??
            'Member Dashboard';

    final subtitle =
        widget.subtitle ??
            'Premium realtime marketplace';

    final photoUrl =
        user?.photoUrl ??
            '';

    final userName =

        user
                    ?.displayName
                    .trim()
                    .isNotEmpty ==
                true

            ? user!
                .displayName

            : 'Member';

    return FadeTransition(

      opacity:
          _fadeAnimation,

      child: Container(

        width:
            double.infinity,

        padding:
            EdgeInsets.all(
          isMobile
              ? 18
              : 24,
        ),

        decoration:
            BoxDecoration(

          gradient:
              const LinearGradient(

            begin:
                Alignment.topLeft,

            end:
                Alignment.bottomRight,

            colors: [

              Color(
                0xff2563EB,
              ),

              Color(
                0xff1D4ED8,
              ),

              Color(
                0xff312E81,
              ),
            ],
          ),

          borderRadius:
              BorderRadius.circular(
            32,
          ),

          boxShadow: [

            BoxShadow(

              color:
                  AppColors.primary
                      .withOpacity(
                0.25,
              ),

              blurRadius:
                  30,

              offset:
                  const Offset(
                0,
                16,
              ),
            ),
          ],
        ),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment
                  .start,

          children: [

            // =============================================
            // TOP
            // =============================================

            Row(

              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                // =========================================
                // USER INFO
                // =========================================

                Expanded(

                  child: Row(

                    children: [

                      // =====================================
                      // AVATAR
                      // =====================================

                      Hero(

                        tag:
                            'user_avatar',

                        child: Container(

                          width:
                              isMobile
                                  ? 58
                                  : 70,

                          height:
                              isMobile
                                  ? 58
                                  : 70,

                          decoration:
                              BoxDecoration(

                            shape:
                                BoxShape.circle,

                            border: Border.all(

                              color:
                                  Colors.white
                                      .withOpacity(
                                0.25,
                              ),

                              width: 2,
                            ),

                            boxShadow: [

                              BoxShadow(

                                color:
                                    Colors.black
                                        .withOpacity(
                                  0.15,
                                ),

                                blurRadius:
                                    16,
                              ),
                            ],
                          ),

                          child:
                              ClipOval(

                            child:
                                photoUrl
                                        .isNotEmpty

                                    ? Image.memory(

                                        base64Decode(
                                          photoUrl,
                                        ),

                                        fit:
                                            BoxFit.cover,
                                      )

                                    : Container(

                                        color:
                                            Colors.white
                                                .withOpacity(
                                          0.18,
                                        ),

                                        child:
                                            Icon(

                                          Icons.person,

                                          size:
                                              isMobile
                                                  ? 28
                                                  : 34,

                                          color:
                                              Colors
                                                  .white,
                                        ),
                                      ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 16,
                      ),

                      // =====================================
                      // TEXT
                      // =====================================

                      Expanded(

                        child: Column(

                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            Container(

                              padding:
                                  const EdgeInsets.symmetric(

                                horizontal:
                                    12,

                                vertical:
                                    6,
                              ),

                              decoration:
                                  BoxDecoration(

                                color:
                                    Colors.white
                                        .withOpacity(
                                  0.15,
                                ),

                                borderRadius:
                                    BorderRadius.circular(
                                  30,
                                ),
                              ),

                              child: const Text(

                                'Premium Member',

                                style:
                                    TextStyle(

                                  color:
                                      Colors.white,

                                  fontWeight:
                                      FontWeight.bold,

                                  fontSize:
                                      11,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 12,
                            ),

                            Text(

                              'Hello, $userName 👋',

                              maxLines: 1,

                              overflow:
                                  TextOverflow
                                      .ellipsis,

                              style:
                                  TextStyle(

                                color:
                                    Colors.white,

                                fontSize:
                                    isMobile
                                        ? 22
                                        : 30,

                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                              height: 6,
                            ),

                            Text(

                              subtitle,

                              maxLines: 2,

                              overflow:
                                  TextOverflow
                                      .ellipsis,

                              style:
                                  TextStyle(

                                color:
                                    Colors.white
                                        .withOpacity(
                                  0.88,
                                ),

                                fontSize:
                                    isMobile
                                        ? 13
                                        : 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // =========================================
                // ACTIONS
                // =========================================

                Row(

                  children: [

                    buildActionButton(

                      icon:
                          Icons.search_rounded,

                      onTap:
                          widget.onSearchTap,
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    Stack(

                      children: [

                        buildActionButton(

                          icon:
                              Icons
                                  .notifications_rounded,

                          onTap:
                              widget
                                  .onNotificationTap,
                        ),

                        Positioned(

                          top: 0,

                          right: 0,

                          child:
                              Container(

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
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(
              height: 28,
            ),

            // =============================================
            // BOTTOM
            // =============================================

            Wrap(

              spacing: 16,

              runSpacing: 16,

              children: [

                buildMiniCard(

                  icon:
                      Icons.shopping_bag_rounded,

                  title:
                      'Marketplace',

                  subtitle:
                      'Realtime products',
                ),

                buildMiniCard(

                  icon:
                      Icons.flash_on_rounded,

                  title:
                      'Fast Checkout',

                  subtitle:
                      'Auto realtime sync',
                ),

                buildMiniCard(

                  icon:
                      Icons.verified_rounded,

                  title:
                      'Secure Payment',

                  subtitle:
                      'Admin validated',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // ACTION BUTTON
  // =====================================================

  Widget buildActionButton({

    required IconData icon,

    VoidCallback? onTap,
  }) {

    return InkWell(

      borderRadius:
          BorderRadius.circular(
        18,
      ),

      onTap: onTap,

      child: Container(

        width: 52,

        height: 52,

        decoration:
            BoxDecoration(

          color:
              Colors.white
                  .withOpacity(
            0.14,
          ),

          borderRadius:
              BorderRadius.circular(
            18,
          ),

          border: Border.all(

            color:
                Colors.white
                    .withOpacity(
              0.15,
            ),
          ),
        ),

        child: Icon(

          icon,

          color:
              Colors.white,

          size: 24,
        ),
      ),
    );
  }

  // =====================================================
  // MINI CARD
  // =====================================================

  Widget buildMiniCard({

    required IconData icon,

    required String title,

    required String subtitle,
  }) {

    return Container(

      constraints:
          const BoxConstraints(
        minWidth: 160,
      ),

      padding:
          const EdgeInsets.all(
        16,
      ),

      decoration:
          BoxDecoration(

        color:
            Colors.white
                .withOpacity(
          0.12,
        ),

        borderRadius:
            BorderRadius.circular(
          24,
        ),

        border: Border.all(

          color:
              Colors.white
                  .withOpacity(
            0.12,
          ),
        ),
      ),

      child: Row(

        mainAxisSize:
            MainAxisSize.min,

        children: [

          Container(

            padding:
                const EdgeInsets.all(
              12,
            ),

            decoration:
                BoxDecoration(

              color:
                  Colors.white
                      .withOpacity(
                0.14,
              ),

              borderRadius:
                  BorderRadius.circular(
                18,
              ),
            ),

            child: Icon(

              icon,

              color:
                  Colors.white,

              size: 22,
            ),
          ),

          const SizedBox(
            width: 14,
          ),

          Flexible(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                Text(

                  title,

                  overflow:
                      TextOverflow
                          .ellipsis,

                  style:
                      const TextStyle(

                    color:
                        Colors.white,

                    fontWeight:
                        FontWeight.bold,

                    fontSize:
                        14,
                  ),
                ),

                const SizedBox(
                  height: 4,
                ),

                Text(

                  subtitle,

                  overflow:
                      TextOverflow
                          .ellipsis,

                  style:
                      TextStyle(

                    color:
                        Colors.white
                            .withOpacity(
                      0.8,
                    ),

                    fontSize:
                        11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}