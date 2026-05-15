// =====================================================
// lib/widgets/user/user_dashboard_header.dart
// MODERN CLEAN RESPONSIVE VERSION
// =====================================================

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
    with SingleTickerProviderStateMixin {

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
        milliseconds: 450,
      ),
    );

    _fadeAnimation =
        CurvedAnimation(

      parent:
          _animationController,

      curve:
          Curves.easeOut,
    );

    _animationController.forward();
  }

  @override
  void dispose() {

    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    final authProvider =
        context.watch<AuthProvider>();

    final user =
        authProvider.user;

    final screenWidth =
        MediaQuery.of(context)
            .size
            .width;

    final isMobile =
        screenWidth < 700;

    final photoUrl =
        user?.photoUrl ?? '';

    final userName =
        user?.displayName
                    .trim()
                    .isNotEmpty ==
                true
            ? user!.displayName
            : 'Member';

    final subtitle =
        widget.subtitle ??
            'Premium realtime marketplace';

    return FadeTransition(

      opacity:
          _fadeAnimation,

      child: Container(

        width: double.infinity,

        padding: EdgeInsets.all(
          isMobile ? 18 : 24,
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

              Color(0xff2563EB),

              Color(0xff1D4ED8),

              Color(0xff312E81),
            ],
          ),

          borderRadius:
              BorderRadius.circular(
            30,
          ),

          boxShadow: [

            BoxShadow(

              color:
                  AppColors.primary
                      .withOpacity(0.20),

              blurRadius: 28,

              offset:
                  const Offset(
                0,
                14,
              ),
            ),
          ],
        ),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // =========================================
            // TOP SECTION
            // =========================================

            Row(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                // =====================================
                // USER INFO
                // =====================================

                Expanded(

                  child: Row(

                    children: [

                      // =================================
                      // AVATAR
                      // =================================

                      Hero(

                        tag:
                            'user_avatar',

                        child: Container(

                          width:
                              isMobile
                                  ? 54
                                  : 64,

                          height:
                              isMobile
                                  ? 54
                                  : 64,

                          decoration:
                              BoxDecoration(

                            shape:
                                BoxShape.circle,

                            border: Border.all(

                              color:
                                  Colors.white
                                      .withOpacity(
                                0.22,
                              ),

                              width: 2,
                            ),
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
                                          0.16,
                                        ),

                                        child: Icon(

                                          Icons.person,

                                          size:
                                              isMobile
                                                  ? 26
                                                  : 32,

                                          color:
                                              Colors.white,
                                        ),
                                      ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 14,
                      ),

                      // =================================
                      // TEXT
                      // =================================

                      Expanded(

                        child: Column(

                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            Container(

                              padding:
                                  const EdgeInsets.symmetric(

                                horizontal: 10,

                                vertical: 5,
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
                                  20,
                                ),
                              ),

                              child:
                                  const Text(

                                'Premium Member',

                                style:
                                    TextStyle(

                                  color:
                                      Colors.white,

                                  fontWeight:
                                      FontWeight.bold,

                                  fontSize: 10,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 10,
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
                                        ? 20
                                        : 28,

                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                              height: 5,
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
                                  0.84,
                                ),

                                fontSize:
                                    isMobile
                                        ? 12
                                        : 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // =====================================
                // ACTION BUTTONS
                // =====================================

                Row(

                  children: [

                    buildActionButton(

                      icon:
                          Icons.search_rounded,

                      onTap:
                          widget.onSearchTap,
                    ),

                    const SizedBox(
                      width: 8,
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

                            width: 9,

                            height: 9,

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
              height: 22,
            ),

            // =========================================
            // MINI CARDS
            // =========================================

            Wrap(

              spacing: 12,

              runSpacing: 12,

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
                      'Realtime sync',
                ),

                buildMiniCard(

                  icon:
                      Icons.verified_rounded,

                  title:
                      'Secure Payment',

                  subtitle:
                      'Protected system',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // =========================================
  // ACTION BUTTON
  // =========================================

  Widget buildActionButton({

    required IconData icon,

    VoidCallback? onTap,
  }) {

    return InkWell(

      borderRadius:
          BorderRadius.circular(16),

      onTap: onTap,

      child: Container(

        width: 46,

        height: 46,

        decoration:
            BoxDecoration(

          color:
              Colors.white
                  .withOpacity(0.14),

          borderRadius:
              BorderRadius.circular(16),

          border: Border.all(

            color:
                Colors.white
                    .withOpacity(0.12),
          ),
        ),

        child: Icon(

          icon,

          color:
              Colors.white,

          size: 21,
        ),
      ),
    );
  }

  // =========================================
  // MINI CARD
  // =========================================

  Widget buildMiniCard({

    required IconData icon,

    required String title,

    required String subtitle,
  }) {

    return Container(

      constraints:
          const BoxConstraints(
        minWidth: 150,
      ),

      padding:
          const EdgeInsets.all(14),

      decoration:
          BoxDecoration(

        color:
            Colors.white
                .withOpacity(0.10),

        borderRadius:
            BorderRadius.circular(22),

        border: Border.all(

          color:
              Colors.white
                  .withOpacity(0.10),
        ),
      ),

      child: Row(

        mainAxisSize:
            MainAxisSize.min,

        children: [

          Container(

            padding:
                const EdgeInsets.all(10),

            decoration:
                BoxDecoration(

              color:
                  Colors.white
                      .withOpacity(0.12),

              borderRadius:
                  BorderRadius.circular(
                16,
              ),
            ),

            child: Icon(

              icon,

              color:
                  Colors.white,

              size: 18,
            ),
          ),

          const SizedBox(
            width: 12,
          ),

          Flexible(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

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

                    fontSize: 13,
                  ),
                ),

                const SizedBox(
                  height: 3,
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
                            .withOpacity(0.78),

                    fontSize: 10,
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