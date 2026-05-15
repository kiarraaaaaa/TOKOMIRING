// =====================================================
// lib/screens/user/user_profile_screen.dart
// ULTRA PREMIUM COMPACT PROFILE SCREEN
// FULL REVISED VERSION
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

        titleSpacing: 20,

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
                        ? 20
                        : 24,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 2,
            ),

            Text(

              'Premium member dashboard',

              style: TextStyle(

                color:
                    Colors.grey,

                fontSize:
                    isMobile
                        ? 11
                        : 13,
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
                ? 14
                : 20,
          ),

          child: Column(

            children: [

              // ===================================================
              // HEADER CARD
              // ===================================================

              Container(

                width:
                    double.infinity,

                padding:
                    EdgeInsets.all(

                  isMobile
                      ? 16
                      : 20,
                ),

                decoration:
                    BoxDecoration(

                  borderRadius:
                      BorderRadius.circular(
                    28,
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

                      Color(
                        0xff1E40AF,
                      ),
                    ],
                  ),

                  boxShadow: [

                    BoxShadow(

                      color:
                          const Color(
                        0xff2563EB,
                      ).withOpacity(
                        0.18,
                      ),

                      blurRadius:
                          24,

                      offset:
                          const Offset(
                        0,
                        10,
                      ),
                    ),
                  ],
                ),

                child: Column(

                  children: [

                    // ===========================================
                    // AVATAR
                    // ===========================================

                    Stack(

                      clipBehavior:
                          Clip.none,

                      children: [

                        Container(

                          width:
                              isMobile
                                  ? 92
                                  : 100,

                          height:
                              isMobile
                                  ? 92
                                  : 100,

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

                            boxShadow: [

                              BoxShadow(

                                color:
                                    Colors.black
                                        .withOpacity(
                                  0.12,
                                ),

                                blurRadius:
                                    16,
                              ),
                            ],
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
                                                  ? 44
                                                  : 52,

                                          color:
                                              Colors
                                                  .white,
                                        ),
                                      ),
                          ),
                        ),

                        // VERIFIED

                        Positioned(

                          bottom: 4,

                          right: 0,

                          child:
                              Container(

                            width: 26,

                            height: 26,

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

                              size: 14,

                              color:
                                  Colors.white,
                            ),
                          ),
                        ),

                        // CAMERA BUTTON

                        Positioned(

                          bottom: -6,

                          right: 18,

                          child:
                              GestureDetector(

                            onTap: () async {

                              // image picker nanti sambung
                            },

                            child:
                                Container(

                              padding:
                                  const EdgeInsets.all(
                                8,
                              ),

                              decoration:
                                  BoxDecoration(

                                gradient:
                                    const LinearGradient(

                                  colors: [

                                    Color(
                                      0xff2563EB,
                                    ),

                                    Color(
                                      0xff4F46E5,
                                    ),
                                  ],
                                ),

                                shape:
                                    BoxShape.circle,

                                border:
                                    Border.all(

                                  color:
                                      Colors.white,

                                  width: 2,
                                ),

                                boxShadow: [

                                  BoxShadow(

                                    color:
                                        Colors.blue
                                            .withOpacity(
                                      0.24,
                                    ),

                                    blurRadius:
                                        12,

                                    offset:
                                        const Offset(
                                      0,
                                      4,
                                    ),
                                  ),
                                ],
                              ),

                              child:
                                  const Icon(

                                Icons
                                    .camera_alt_rounded,

                                size: 14,

                                color:
                                    Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 18,
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
                                ? 22
                                : 24,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 4,
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
                          0.88,
                        ),

                        fontSize:
                            isMobile
                                ? 12
                                : 13,
                      ),
                    ),

                    const SizedBox(
                      height: 14,
                    ),

                    Container(

                      padding:
                          const EdgeInsets.symmetric(

                        horizontal: 14,

                        vertical: 8,
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

                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 22,
              ),

              // ===================================================
              // ANALYTICS
              // ===================================================

              Wrap(

                spacing: 12,

                runSpacing: 12,

                alignment:
                    WrapAlignment.center,

                children: [

                  _buildAnalyticsCard(

                    title: 'Role',

                    value: user.role,

                    icon:
                        Icons.workspace_premium,

                    color:
                        Colors.orange,

                    isMobile:
                        isMobile,
                  ),

                  _buildAnalyticsCard(

                    title: 'Status',

                    value: 'Verified',

                    icon:
                        Icons.verified,

                    color:
                        Colors.green,

                    isMobile:
                        isMobile,
                  ),
                ],
              ),

              const SizedBox(
                height: 22,
              ),

              // ===================================================
              // PROFILE INFO
              // ===================================================

              Container(

                width:
                    double.infinity,

                padding:
                    EdgeInsets.all(

                  isMobile
                      ? 16
                      : 20,
                ),

                decoration:
                    BoxDecoration(

                  color:
                      Colors.white,

                  borderRadius:
                      BorderRadius.circular(
                    28,
                  ),

                  boxShadow: [

                    BoxShadow(

                      color:
                          Colors.black
                              .withOpacity(
                        0.03,
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
                      height: 26,
                    ),

                    _buildProfileItem(

                      title:
                          'Phone Number',

                      value:
                          user.phone.isEmpty

                              ? '-'

                              : user.phone,

                      icon:
                          Icons.phone_outlined,
                    ),

                    const Divider(
                      height: 26,
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
                      height: 26,
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
                height: 22,
              ),

              // ===================================================
              // BUTTONS
              // ===================================================

              Row(

                children: [

                  Expanded(

                    child: SizedBox(

                      height: 50,

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
                              18,
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

                          size: 16,
                        ),

                        label:
                            const Text(

                          'Edit',

                          style:
                              TextStyle(

                            fontSize: 13,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 12,
                  ),

                  Expanded(

                    child: SizedBox(

                      height: 50,

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
                              18,
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

                          size: 16,
                        ),

                        label:
                            const Text(

                          'History',

                          style:
                              TextStyle(

                            fontSize: 13,

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
                height: 14,
              ),

              SizedBox(

                width:
                    double.infinity,

                height: 50,

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
                        0.22,
                      ),
                    ),

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(
                        18,
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

                    size: 16,
                  ),

                  label:
                      const Text(

                    'Logout',

                    style:
                        TextStyle(

                      fontSize: 13,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // PROFILE ITEM
  // =====================================================

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

          width: 42,

          height: 42,

          decoration:
              BoxDecoration(

            color:
                AppColors.primary
                    .withOpacity(
              0.08,
            ),

            borderRadius:
                BorderRadius.circular(
              14,
            ),
          ),

          child: Icon(

            icon,

            color:
                AppColors.primary,

            size: 18,
          ),
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

                title,

                style:
                    TextStyle(

                  color:
                      Colors.grey
                          .shade600,

                  fontSize: 11,
                ),
              ),

              const SizedBox(
                height: 4,
              ),

              Text(

                value,

                style:
                    const TextStyle(

                  fontSize: 14,

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

  // =====================================================
  // ANALYTICS CARD
  // =====================================================

  Widget _buildAnalyticsCard({

    required String title,

    required String value,

    required IconData icon,

    required Color color,

    required bool isMobile,
  }) {

    return Container(

      width:
          isMobile
              ? double.infinity
              : 145,

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
          22,
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
                12,

            offset:
                const Offset(
              0,
              5,
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

            width: 42,

            height: 42,

            decoration:
                BoxDecoration(

              color:
                  color.withOpacity(
                0.10,
              ),

              borderRadius:
                  BorderRadius.circular(
                14,
              ),
            ),

            child: Icon(

              icon,

              size: 18,

              color:
                  color,
            ),
          ),

          const SizedBox(
            height: 14,
          ),

          Text(

            value,

            overflow:
                TextOverflow
                    .ellipsis,

            maxLines: 1,

            style:
                TextStyle(

              fontSize:
                  isMobile
                      ? 18
                      : 20,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 3,
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

              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // EDIT DIALOG
  // =====================================================

  void _showEditProfileDialog(
    BuildContext context,
  ) {}
}