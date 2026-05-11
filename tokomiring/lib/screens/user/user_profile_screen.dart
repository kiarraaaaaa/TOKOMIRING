// lib/screens/user/user_profile_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';

import '../../providers/auth_provider.dart';

import '../../routes/app_routes.dart';

class UserProfileScreen
    extends StatelessWidget {

  const UserProfileScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    final authProvider =
        Provider.of<AuthProvider>(
      context,
    );

    final user =
        authProvider.user;

    return Scaffold(

      backgroundColor:
          AppColors.background,

      // ===================================================
      // APP BAR
      // ===================================================

      appBar: AppBar(
        title:
            const Text(
          'My Profile',
        ),
      ),

      // ===================================================
      // BODY
      // ===================================================

      body:
          user == null

              ? const Center(
                  child:
                      Text(
                    'User not found',
                  ),
                )

              : SingleChildScrollView(
                  padding:
                      const EdgeInsets.all(
                    20,
                  ),

                  child: Column(
                    children: [

                      // =====================================
                      // PROFILE IMAGE
                      // =====================================

                      Container(
                        width: 120,

                        height: 120,

                        decoration:
                            BoxDecoration(
                          shape:
                              BoxShape.circle,

                          color:
                              Colors.white,

                          boxShadow: [

                            BoxShadow(
                              color:
                                  Colors.black
                                      .withOpacity(
                                0.05,
                              ),

                              blurRadius:
                                  20,
                            ),
                          ],
                        ),

                        child:
                            ClipOval(

                          child:
                              user.photoUrl
                                      .isNotEmpty

                                  ? Image.network(
                                      user.photoUrl,

                                      fit:
                                          BoxFit.cover,

                                      errorBuilder:
                                          (
                                            context,
                                            error,
                                            stackTrace,
                                          ) {

                                        return const Icon(
                                          Icons.person,

                                          size:
                                              60,
                                        );
                                      },
                                    )

                                  : const Icon(
                                      Icons.person,

                                      size: 60,

                                      color:
                                          Colors.grey,
                                    ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // =====================================
                      // NAME
                      // =====================================

                      Text(
                        user.name,

                        style:
                            const TextStyle(
                          fontSize: 26,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 6,
                      ),

                      // =====================================
                      // EMAIL
                      // =====================================

                      Text(
                        user.email,

                        style:
                            TextStyle(
                          color:
                              Colors.grey
                                  .shade600,

                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      // =====================================
                      // INFO CARD
                      // =====================================

                      Container(
                        width:
                            double.infinity,

                        padding:
                            const EdgeInsets.all(
                          20,
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

                        child: Column(
                          children: [

                            _buildItem(
                              title:
                                  'Username',

                              value:
                                  user.username,

                              icon:
                                  Icons.person_outline,
                            ),

                            const Divider(),

                            _buildItem(
                              title:
                                  'Phone',

                              value:
                                  user.phone
                                          .isEmpty
                                      ? '-'
                                      : user.phone,

                              icon:
                                  Icons.phone_outlined,
                            ),

                            const Divider(),

                            _buildItem(
                              title:
                                  'Address',

                              value:
                                  user.address
                                          .isEmpty
                                      ? '-'
                                      : user.address,

                              icon:
                                  Icons.location_on_outlined,
                            ),

                            const Divider(),

                            _buildItem(
                              title:
                                  'Role',

                              value:
                                  user.role,

                              icon:
                                  Icons.admin_panel_settings_outlined,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      // =====================================
                      // ORDER BUTTON
                      // =====================================

                      SizedBox(
                        width:
                            double.infinity,

                        child:
                            ElevatedButton.icon(

                          onPressed: () {

                            Navigator.pushNamed(
                              context,
                              AppRoutes.userOrders,
                            );
                          },

                          icon:
                              const Icon(
                            Icons.receipt_long,
                          ),

                          label:
                              const Text(
                            'My Orders',
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      // =====================================
                      // LOGOUT
                      // =====================================

                      SizedBox(
                        width:
                            double.infinity,

                        child:
                            OutlinedButton.icon(

                          onPressed: () async {

                            await authProvider
                                .logout();

                            if (!context.mounted) {
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
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  // =====================================================
  // ITEM
  // =====================================================

  Widget _buildItem({

    required String title,

    required String value,

    required IconData icon,

  }) {

    return Padding(
      padding:
          const EdgeInsets.symmetric(
        vertical: 10,
      ),

      child: Row(
        children: [

          Icon(
            icon,

            color:
                AppColors.primary,
          ),

          const SizedBox(
            width: 16,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style:
                      TextStyle(
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
      ),
    );
  }
}