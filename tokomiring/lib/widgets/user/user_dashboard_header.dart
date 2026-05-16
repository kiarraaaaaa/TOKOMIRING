// =====================================================
// lib/widgets/user/user_dashboard_header.dart
// COMPACT PREMIUM VERSION
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
        milliseconds: 400,
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

        padding:
            EdgeInsets.all(
          isMobile ? 16 : 20,
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
            24,
          ),

          boxShadow: [

            BoxShadow(

              color:
                  AppColors.primary
                      .withOpacity(
                0.16,
              ),

              blurRadius: 20,

              offset:
                  const Offset(
                0,
                10,
              ),
            ),
          ],
        ),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Row(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Expanded(

                  child: Row(

                    children: [

                      // AVATAR

                      Hero(

                        tag:
                            'user_avatar',

                        child: Container(

                          width:
                              isMobile
                                  ? 48
                                  : 56,

                          height:
                              isMobile
                                  ? 48
                                  : 56,

                          decoration:
                              BoxDecoration(

                            shape:
                                BoxShape.circle,

                            border: Border.all(

                              color:
                                  Colors.white
                                      .withOpacity(
                                0.20,
                              ),

                              width: 1.5,
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
                                          0.14,
                                        ),

                                        child: Icon(

                                          Icons.person,

                                          size:
                                              isMobile
                                                  ? 22
                                                  : 26,

                                          color:
                                              Colors.white,
                                        ),
                                      ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 12,
                      ),

                      // TEXT

                      Expanded(

                        child: Column(

                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            Container(

                              padding:
                                  const EdgeInsets.symmetric(

                                horizontal: 9,

                                vertical: 4,
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
                                  18,
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

                                  fontSize: 9,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 8,
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
                                        ? 18
                                        : 24,

                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                              height: 3,
                            ),

                            Text(

                              subtitle,

                              maxLines: 1,

                              overflow:
                                  TextOverflow
                                      .ellipsis,

                              style:
                                  TextStyle(

                                color:
                                    Colors.white
                                        .withOpacity(
                                  0.82,
                                ),

                                fontSize:
                                    isMobile
                                        ? 11
                                        : 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Row(

                  children: [

                    buildActionButton(

                      icon:
                          Icons.search_rounded,

                      onTap:
                          widget.onSearchTap,
                    ),

                    const SizedBox(
                      width: 6,
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

                          top: 1,

                          right: 1,

                          child:
                              Container(

                            width: 8,

                            height: 8,

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
              height: 18,
            ),

            Wrap(

              spacing: 10,

              runSpacing: 10,

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

  Widget buildActionButton({

    required IconData icon,

    VoidCallback? onTap,
  }) {

    return InkWell(

      borderRadius:
          BorderRadius.circular(
        14,
      ),

      onTap: onTap,

      child: Container(

        width: 40,

        height: 40,

        decoration:
            BoxDecoration(

          color:
              Colors.white
                  .withOpacity(0.12),

          borderRadius:
              BorderRadius.circular(
            14,
          ),
        ),

        child: Icon(

          icon,

          color:
              Colors.white,

          size: 19,
        ),
      ),
    );
  }

  Widget buildMiniCard({

    required IconData icon,

    required String title,

    required String subtitle,
  }) {

    return Container(

      constraints:
          const BoxConstraints(
        minWidth: 130,
      ),

      padding:
          const EdgeInsets.all(
        12,
      ),

      decoration:
          BoxDecoration(

        color:
            Colors.white
                .withOpacity(0.10),

        borderRadius:
            BorderRadius.circular(
          18,
        ),
      ),

      child: Row(

        mainAxisSize:
            MainAxisSize.min,

        children: [

          Container(

            padding:
                const EdgeInsets.all(
              8,
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
                12,
              ),
            ),

            child: Icon(

              icon,

              color:
                  Colors.white,

              size: 16,
            ),
          ),

          const SizedBox(
            width: 10,
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

                    fontSize: 12,
                  ),
                ),

                const SizedBox(
                  height: 2,
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
                      0.75,
                    ),

                    fontSize: 9,
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