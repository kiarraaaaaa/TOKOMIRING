// =====================================================
// lib/screens/user/user_profile_screen.dart
// FINAL ULTRA COMPACT PREMIUM PROFILE
// =====================================================

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../routes/app_routes.dart';

class UserProfileScreen
    extends StatefulWidget {

  const UserProfileScreen({
    super.key,
  });

  @override
  State<UserProfileScreen>
      createState() =>
          _UserProfileScreenState();
}

class _UserProfileScreenState
    extends State<UserProfileScreen>
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
        milliseconds: 420,
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

    if (user == null) {

      return const Scaffold(

        body: Center(

          child: Text(
            'User not found',
          ),
        ),
      );
    }

    final width =
        MediaQuery.of(context)
            .size
            .width;

    final bool isMobile =
        width < 700;

    return Scaffold(

      backgroundColor:
          const Color(
        0xffF5F7FB,
      ),

      appBar: AppBar(

        elevation: 0,

        backgroundColor:
            Colors.transparent,

        surfaceTintColor:
            Colors.transparent,

        titleSpacing: 18,

        title: Column(

          crossAxisAlignment:
              CrossAxisAlignment
                  .start,

          children: [

            Text(

              'Member Profile',

              style: TextStyle(

                color:
                    Colors.black,

                fontSize:
                    isMobile
                        ? 19
                        : 22,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 1,
            ),

            Text(

              'Compact premium dashboard',

              style: TextStyle(

                color:
                    Colors.grey,

                fontSize:
                    isMobile
                        ? 10
                        : 11,
              ),
            ),
          ],
        ),
      ),

      body: FadeTransition(

        opacity:
            _fadeAnimation,

        child:
            SingleChildScrollView(

          physics:
              const BouncingScrollPhysics(),

          padding:
              EdgeInsets.all(

            isMobile
                ? 12
                : 18,
          ),

          child: Column(

            children: [

              // ===================================================
              // HEADER
              // ===================================================

              Container(

                width:
                    double.infinity,

                padding:
                    EdgeInsets.all(

                  isMobile
                      ? 16
                      : 18,
                ),

                decoration:
                    BoxDecoration(

                  borderRadius:
                      BorderRadius.circular(
                    24,
                  ),

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
                    ],
                  ),

                  boxShadow: [

                    BoxShadow(

                      color:
                          const Color(
                        0xff2563EB,
                      ).withOpacity(
                        0.16,
                      ),

                      blurRadius:
                          18,

                      offset:
                          const Offset(
                        0,
                        8,
                      ),
                    ),
                  ],
                ),

                child: Column(

                  children: [

                    // =====================================
                    // AVATAR
                    // =====================================

                    Stack(

                      clipBehavior:
                          Clip.none,

                      children: [

                        Container(

                          width:
                              isMobile
                                  ? 84
                                  : 92,

                          height:
                              isMobile
                                  ? 84
                                  : 92,

                          decoration:
                              BoxDecoration(

                            shape:
                                BoxShape.circle,

                            border:
                                Border.all(

                              color:
                                  Colors.white,

                              width: 3,
                            ),
                          ),

                          child:
                              ClipOval(

                            child:
                                user.photoUrl
                                        .isNotEmpty

                                    ? Image.memory(

                                        base64Decode(
                                          user.photoUrl,
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

                                        child:
                                            Icon(

                                          Icons.person,

                                          size:
                                              isMobile
                                                  ? 40
                                                  : 44,

                                          color:
                                              Colors
                                                  .white,
                                        ),
                                      ),
                          ),
                        ),

                        Positioned(

                          bottom: 0,

                          right: 0,

                          child:
                              Container(

                            width: 24,

                            height: 24,

                            decoration:
                                BoxDecoration(

                              color:
                                  const Color(
                                0xff3B82F6,
                              ),

                              shape:
                                  BoxShape.circle,

                              border:
                                  Border.all(

                                color:
                                    Colors.white,

                                width: 2,
                              ),
                            ),

                            child:
                                const Icon(

                              Icons.check,

                              size: 12,

                              color:
                                  Colors.white,
                            ),
                          ),
                        ),

                        Positioned(

                          bottom: -4,

                          right: 16,

                          child:
                              GestureDetector(

                            onTap: () {},

                            child:
                                Container(

                              padding:
                                  const EdgeInsets.all(
                                7,
                              ),

                              decoration:
                                  BoxDecoration(

                                color:
                                    Colors.white,

                                shape:
                                    BoxShape.circle,

                                boxShadow: [

                                  BoxShadow(

                                    color:
                                        Colors.black
                                            .withOpacity(
                                      0.10,
                                    ),

                                    blurRadius:
                                        10,
                                  ),
                                ],
                              ),

                              child:
                                  const Icon(

                                Icons
                                    .camera_alt_rounded,

                                size: 13,

                                color:
                                    AppColors
                                        .primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    Text(

                      user.name,

                      textAlign:
                          TextAlign.center,

                      style:
                          TextStyle(

                        color:
                            Colors.white,

                        fontSize:
                            isMobile
                                ? 20
                                : 22,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 3,
                    ),

                    Text(

                      user.email,

                      textAlign:
                          TextAlign.center,

                      style:
                          TextStyle(

                        color:
                            Colors.white
                                .withOpacity(
                          0.86,
                        ),

                        fontSize:
                            isMobile
                                ? 11
                                : 12,
                      ),
                    ),

                    const SizedBox(
                      height: 12,
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
                            Colors.white
                                .withOpacity(
                          0.12,
                        ),

                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),
                      ),

                      child: Text(

                        user.role
                                    .toLowerCase() ==
                                'admin'

                            ? 'System Manager'

                            : 'Premium Member',

                        style:
                            const TextStyle(

                          color:
                              Colors.white,

                          fontWeight:
                              FontWeight.bold,

                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 18,
              ),

              // ===================================================
              // ANALYTICS
              // ===================================================

              Row(

                children: [

                  Expanded(

                    child:
                        _buildAnalyticsCard(

                      title: 'Role',

                      value:
                          user.role,

                      icon:
                          Icons.workspace_premium,

                      color:
                          Colors.orange,
                    ),
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  Expanded(

                    child:
                        _buildAnalyticsCard(

                      title: 'Status',

                      value:
                          'Verified',

                      icon:
                          Icons.verified,

                      color:
                          Colors.green,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 18,
              ),

              // ===================================================
              // INFO
              // ===================================================

              Container(

                width:
                    double.infinity,

                padding:
                    EdgeInsets.all(

                  isMobile
                      ? 15
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
                          14,

                      offset:
                          const Offset(
                        0,
                        6,
                      ),
                    ),
                  ],
                ),

                child: Column(

                  children: [

                    _buildProfileItem(

                      title:
                          'Username',

                      value:
                          user.username,

                      icon:
                          Icons.person_outline,
                    ),

                    const Divider(
                      height: 24,
                    ),

                    _buildProfileItem(

                      title:
                          'Phone',

                      value:
                          user.phone.isEmpty

                              ? '-'

                              : user.phone,

                      icon:
                          Icons.phone_outlined,
                    ),

                    const Divider(
                      height: 24,
                    ),

                    _buildProfileItem(

                      title:
                          'Address',

                      value:
                          user.address.isEmpty

                              ? '-'

                              : user.address,

                      icon:
                          Icons.location_on_outlined,
                    ),

                    const Divider(
                      height: 24,
                    ),

                    _buildProfileItem(

                      title:
                          'Email',

                      value:
                          user.email,

                      icon:
                          Icons.email_outlined,
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 18,
              ),

              // ===================================================
              // BUTTONS
              // ===================================================

              Row(

                children: [

                  Expanded(

                    child: SizedBox(

                      height: 46,

                      child:
                          ElevatedButton.icon(

                        style:
                            ElevatedButton.styleFrom(

                          backgroundColor:
                              AppColors.primary,

                          foregroundColor:
                              Colors.white,

                          elevation: 0,

                          shape:
                              RoundedRectangleBorder(

                            borderRadius:
                                BorderRadius.circular(
                              16,
                            ),
                          ),
                        ),

                        onPressed: () {

                          _showEditProfileDialog(
                            context,
                          );
                        },

                        icon:
                            const Icon(

                          Icons.edit,

                          size: 15,
                        ),

                        label:
                            const Text(

                          'Edit',

                          style:
                              TextStyle(

                            fontSize: 12,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  Expanded(

                    child: SizedBox(

                      height: 46,

                      child:
                          ElevatedButton.icon(

                        style:
                            ElevatedButton.styleFrom(

                          backgroundColor:
                              Colors.white,

                          foregroundColor:
                              AppColors.primary,

                          elevation: 0,

                          shape:
                              RoundedRectangleBorder(

                            borderRadius:
                                BorderRadius.circular(
                              16,
                            ),
                          ),
                        ),

                        onPressed: () {

                          Navigator.pushNamed(

                            context,

                            AppRoutes.userOrders,
                          );
                        },

                        icon:
                            const Icon(

                          Icons.receipt_long,

                          size: 15,
                        ),

                        label:
                            const Text(

                          'History',

                          style:
                              TextStyle(

                            fontSize: 12,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 12,
              ),

              SizedBox(

                width:
                    double.infinity,

                height: 46,

                child:
                    OutlinedButton.icon(

                  style:
                      OutlinedButton.styleFrom(

                    foregroundColor:
                        Colors.red,

                    side:
                        BorderSide(

                      color:
                          Colors.red
                              .withOpacity(
                        0.20,
                      ),
                    ),

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(
                        16,
                      ),
                    ),
                  ),

                  onPressed:
                      () async {

                    await authProvider
                        .logout();

                    if (!context
                        .mounted) {

                      return;
                    }

                    Navigator.pushNamedAndRemoveUntil(

                      context,

                      AppRoutes.login,

                      (
                        route,
                      ) =>
                          false,
                    );
                  },

                  icon:
                      const Icon(

                    Icons.logout,

                    size: 15,
                  ),

                  label:
                      const Text(

                    'Logout',

                    style:
                        TextStyle(

                      fontSize: 12,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem({

    required String title,

    required String value,

    required IconData icon,
  }) {

    return Row(

      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Container(

          width: 38,

          height: 38,

          decoration:
              BoxDecoration(

            color:
                AppColors.primary
                    .withOpacity(
              0.08,
            ),

            borderRadius:
                BorderRadius.circular(
              12,
            ),
          ),

          child: Icon(

            icon,

            color:
                AppColors.primary,

            size: 16,
          ),
        ),

        const SizedBox(
          width: 12,
        ),

        Expanded(

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [

              Text(

                title,

                style:
                    TextStyle(

                  color:
                      Colors.grey
                          .shade600,

                  fontSize: 10,
                ),
              ),

              const SizedBox(
                height: 3,
              ),

              Text(

                value,

                style:
                    const TextStyle(

                  fontSize: 13,

                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAnalyticsCard({

    required String title,

    required String value,

    required IconData icon,

    required Color color,
  }) {

    return Container(

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
          20,
        ),

        border: Border.all(

          color:
              color.withOpacity(
            0.08,
          ),
        ),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black
                    .withOpacity(
              0.03,
            ),

            blurRadius:
                10,

            offset:
                const Offset(
              0,
              4,
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

            width: 38,

            height: 38,

            decoration:
                BoxDecoration(

              color:
                  color.withOpacity(
                0.10,
              ),

              borderRadius:
                  BorderRadius.circular(
                12,
              ),
            ),

            child: Icon(

              icon,

              size: 16,

              color:
                  color,
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          Text(

            value,

            overflow:
                TextOverflow
                    .ellipsis,

            maxLines: 1,

            style:
                const TextStyle(

              fontSize: 15,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 2,
          ),

          Text(

            title,

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
    );
  }

  void _showEditProfileDialog(
    BuildContext context,
  ) {}
}