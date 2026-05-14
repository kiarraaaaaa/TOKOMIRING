 // lib/screens/user/user_profile_screen.dart

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
                color: Colors.black,
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
                      ? 18
                      : 24,
                ),
                decoration:
                    BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(
                    30,
                  ),
                  gradient:
                      const LinearGradient(
                    begin:
                        Alignment
                            .topLeft,
                    end:
                        Alignment
                            .bottomRight,
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
                        0.22,
                      ),
                      blurRadius:
                          30,
                      offset:
                          const Offset(
                        0,
                        12,
                      ),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // ===================================================
                    // AVATAR
                    // ===================================================

                    Stack(
                      clipBehavior:
                          Clip.none,
                      children: [
                        Container(
                          width:
                              isMobile
                                  ? 105
                                  : 120,
                          height:
                              isMobile
                                  ? 105
                                  : 120,
                          decoration:
                              BoxDecoration(
                            shape:
                                BoxShape
                                    .circle,
                            border:
                                Border.all(
                              color:
                                  Colors
                                      .white,
                              width:
                                  4,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    Colors.black.withOpacity(
                                  0.12,
                                ),
                                blurRadius:
                                    20,
                              ),
                            ],
                          ),
                          child:
                              ClipOval(
                            child:
                                user.photoUrl.isNotEmpty
                                    ? Image.memory(
                                        base64Decode(
                                          user.photoUrl,
                                        ),
                                        fit:
                                            BoxFit.cover,
                                      )
                                    : Container(
                                        color:
                                            Colors.white.withOpacity(
                                          0.15,
                                        ),
                                        child:
                                            Icon(
                                          Icons.person,
                                          size:
                                              isMobile
                                                  ? 52
                                                  : 60,
                                          color:
                                              Colors.white,
                                        ),
                                      ),
                          ),
                        ),

                        // VERIFIED BADGE

                        Positioned(
                          bottom: 6,
                          right: -2,
                          child:
                              Container(
                            width:
                                32,
                            height:
                                32,
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
                                width:
                                    3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Colors.black.withOpacity(
                                    0.15,
                                  ),
                                  blurRadius:
                                      10,
                                ),
                              ],
                            ),
                            child:
                                const Icon(
                              Icons.check,
                              size: 18,
                              color:
                                  Colors.white,
                            ),
                          ),
                        ),

                        Positioned(
                          bottom: -6,
                          right: 24,
                          child:
                              Container(
                            padding:
                                const EdgeInsets.all(
                              10,
                            ),
                            decoration:
                                const BoxDecoration(
                              color:
                                  Colors.white,
                              shape:
                                  BoxShape.circle,
                            ),
                            child:
                                const Icon(
                              Icons.edit,
                              size: 18,
                              color:
                                  AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 22,
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
                                ? 24
                                : 28,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    Text(
                      user.email,
                      textAlign:
                          TextAlign.center,
                      style:
                          TextStyle(
                        color:
                            Colors.white.withOpacity(
                          0.9,
                        ),
                        fontSize:
                            isMobile
                                ? 13
                                : 15,
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal:
                            18,
                        vertical:
                            10,
                      ),
                      decoration:
                          BoxDecoration(
                        color:
                            Colors.white.withOpacity(
                          0.15,
                        ),
                        borderRadius:
                            BorderRadius.circular(
                          30,
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
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              // ===================================================
              // ANALYTICS
              // ===================================================

              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment:
                    WrapAlignment.center,
                children: [
                  _buildAnalyticsCard(
                    title: 'Role',
                    value: user.role,
                    icon: Icons
                        .workspace_premium,
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
                height: 28,
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
                      ? 18
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
                          Colors.black.withOpacity(
                        0.04,
                      ),
                      blurRadius:
                          15,
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
                      icon: Icons
                          .person_outline,
                    ),
                    const Divider(
                      height: 30,
                    ),
                    _buildProfileItem(
                      title:
                          'Phone Number',
                      value: user.phone
                              .isEmpty
                          ? '-'
                          : user.phone,
                      icon: Icons
                          .phone_outlined,
                    ),
                    const Divider(
                      height: 30,
                    ),
                    _buildProfileItem(
                      title:
                          'Address',
                      value: user.address
                              .isEmpty
                          ? '-'
                          : user.address,
                      icon: Icons
                          .location_on_outlined,
                    ),
                    const Divider(
                      height: 30,
                    ),
                    _buildProfileItem(
                      title:
                          'Email',
                      value:
                          user.email,
                      icon: Icons
                          .email_outlined,
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              // ===================================================
              // BUTTONS
              // ===================================================

              SizedBox(
                width:
                    double.infinity,
                height: 58,
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
                        20,
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
                  ),
                  label:
                      const Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              SizedBox(
                width:
                    double.infinity,
                height: 58,
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
                        20,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes
                          .userOrders,
                    );
                  },
                  icon:
                      const Icon(
                    Icons
                        .receipt_long,
                  ),
                  label:
                      const Text(
                    'Transaction History',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              SizedBox(
                width:
                    double.infinity,
                height: 58,
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
                        0.3,
                      ),
                    ),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        20,
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
                  ),
                  label:
                      const Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // EDIT PROFILE DIALOG
  // =====================================================

  void _showEditProfileDialog(
    BuildContext context,
  ) {
    final authProvider =
        context.read<
            AuthProvider>();

    final user =
        authProvider.user;

    if (user == null) {
      return;
    }

    final phoneController =
        TextEditingController(
      text: user.phone,
    );

    final addressController =
        TextEditingController(
      text: user.address,
    );

    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              30,
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.all(
              24,
            ),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  controller:
                      phoneController,
                  decoration:
                      InputDecoration(
                    labelText:
                        'Phone Number',
                    prefixIcon:
                        const Icon(
                      Icons.phone,
                    ),
                    filled: true,
                    fillColor:
                        const Color(
                      0xffF8FAFC,
                    ),
                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),
                      borderSide:
                          BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                TextField(
                  controller:
                      addressController,
                  maxLines: 4,
                  decoration:
                      InputDecoration(
                    labelText:
                        'Address',
                    prefixIcon:
                        const Icon(
                      Icons
                          .location_on,
                    ),
                    filled: true,
                    fillColor:
                        const Color(
                      0xffF8FAFC,
                    ),
                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),
                      borderSide:
                          BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                SizedBox(
                  width:
                      double.infinity,
                  height: 56,
                  child:
                      ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          AppColors
                              .primary,
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
                    onPressed:
                        () async {
                      await authProvider
                          .updatePhone(
                        phoneController
                            .text
                            .trim(),
                      );

                      await authProvider
                          .updateAddress(
                        addressController
                            .text
                            .trim(),
                      );

                      if (!context
                          .mounted) {
                        return;
                      }

                      Navigator.pop(
                        context,
                      );

                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        const SnackBar(
                          backgroundColor:
                              AppColors
                                  .success,
                          content: Text(
                            'Profile updated successfully',
                          ),
                        ),
                      );
                    },
                    child:
                        const Text(
                      'Save Changes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
          padding:
              const EdgeInsets.all(
            12,
          ),
          decoration:
              BoxDecoration(
            color:
                AppColors.primary
                    .withOpacity(
              0.08,
            ),
            borderRadius:
                BorderRadius.circular(
              16,
            ),
          ),
          child: Icon(
            icon,
            color:
                AppColors.primary,
            size: 22,
          ),
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
                title,
                style: TextStyle(
                  color:
                      Colors.grey
                          .shade600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                value,
                style:
                    const TextStyle(
                  fontSize: 16,
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
    required bool isMobile,
  }) {
    return Container(
      width:
          isMobile
              ? double.infinity
              : 170,
      constraints:
          const BoxConstraints(
        minHeight: 160,
      ),
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
        boxShadow: [
          BoxShadow(
            color:
                Colors.black
                    .withOpacity(
              0.04,
            ),
            blurRadius:
                15,
            offset:
                const Offset(
              0,
              8,
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
            padding:
                const EdgeInsets.all(
              12,
            ),
            decoration:
                BoxDecoration(
              color:
                  color.withOpacity(
                0.12,
              ),
              borderRadius:
                  BorderRadius.circular(
                18,
              ),
            ),
            child: Icon(
              icon,
              color:
                  color,
            ),
          ),
          const SizedBox(
            height: 18,
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
                      ? 20
                      : 22,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            title,
            overflow:
                TextOverflow
                    .ellipsis,
            style: TextStyle(
              color:
                  Colors.grey
                      .shade600,
            ),
          ),
        ],
      ),
    );
  }
}