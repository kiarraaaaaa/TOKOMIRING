// lib/widgets/cards/profile_card.dart

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

import '../../models/user_model.dart';

class ProfileCard
    extends StatelessWidget {

  final UserModel user;

  final VoidCallback? onTap;

  // =====================================================
  // CONSTRUCTOR
  // =====================================================

  const ProfileCard({

    super.key,

    required this.user,

    this.onTap,
  });

  // =====================================================
  // ROLE COLOR
  // =====================================================

  Color getRoleColor() {

    switch (user.role) {

      case 'admin':
        return AppColors.danger;

      case 'user':
        return AppColors.primary;

      default:
        return Colors.grey;
    }
  }

  // =====================================================
  // ROLE ICON
  // =====================================================

  IconData getRoleIcon() {

    switch (user.role) {

      case 'admin':
        return Icons.admin_panel_settings_rounded;

      case 'user':
        return Icons.person_rounded;

      default:
        return Icons.info_rounded;
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    final roleColor =
        getRoleColor();

    return Material(

      color:
          Colors.transparent,

      child: InkWell(

        borderRadius:
            BorderRadius.circular(
          30,
        ),

        onTap:
            onTap,

        child: Container(

          padding:
              const EdgeInsets.all(
            24,
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
                  0.05,
                ),

                blurRadius:
                    20,

                offset:
                    const Offset(
                  0,
                  10,
                ),
              ),
            ],
          ),

          child: Row(

            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [

              // =====================================
              // AVATAR
              // =====================================

              Container(

                decoration:
                    BoxDecoration(

                  shape:
                      BoxShape.circle,

                  boxShadow: [

                    BoxShadow(

                      color:
                          roleColor
                              .withOpacity(
                        0.25,
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

                child: CircleAvatar(

                  radius: 46,

                  backgroundColor:
                      Colors.grey
                          .shade200,

                  backgroundImage:
                      user.photoUrl
                              .isEmpty

                          ? null

                          : NetworkImage(
                              user.photoUrl,
                            ),

                  child:
                      user.photoUrl
                              .isEmpty

                          ? Icon(

                              Icons.person_rounded,

                              size: 42,

                              color:
                                  Colors.grey
                                      .shade600,
                            )

                          : null,
                ),
              ),

              const SizedBox(
                width: 22,
              ),

              // =====================================
              // USER INFO
              // =====================================

              Expanded(

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    // ===============================
                    // NAME
                    // ===============================

                    Text(

                      user.name,

                      maxLines: 1,

                      overflow:
                          TextOverflow
                              .ellipsis,

                      style:
                          const TextStyle(

                        fontSize: 24,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    // ===============================
                    // USERNAME
                    // ===============================

                    Text(

                      '@${user.username}',

                      style:
                          TextStyle(

                        color:
                            Colors.grey
                                .shade700,

                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    // ===============================
                    // EMAIL
                    // ===============================

                    Row(

                      children: [

                        Icon(

                          Icons.email_outlined,

                          size: 18,

                          color:
                              Colors.grey
                                  .shade600,
                        ),

                        const SizedBox(
                          width: 8,
                        ),

                        Expanded(

                          child: Text(

                            user.email,

                            maxLines: 1,

                            overflow:
                                TextOverflow
                                    .ellipsis,

                            style:
                                TextStyle(

                              color:
                                  Colors.grey
                                      .shade700,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 18,
                    ),

                    // ===============================
                    // ROLE BADGE
                    // ===============================

                    Container(

                      padding:
                          const EdgeInsets.symmetric(

                        horizontal: 14,

                        vertical: 10,
                      ),

                      decoration:
                          BoxDecoration(

                        color:
                            roleColor
                                .withOpacity(
                          0.1,
                        ),

                        borderRadius:
                            BorderRadius.circular(
                          16,
                        ),
                      ),

                      child: Row(

                        mainAxisSize:
                            MainAxisSize.min,

                        children: [

                          Icon(

                            getRoleIcon(),

                            size: 18,

                            color:
                                roleColor,
                          ),

                          const SizedBox(
                            width: 8,
                          ),

                          Text(

                            user.role
                                .toUpperCase(),

                            style:
                                TextStyle(

                              fontWeight:
                                  FontWeight.bold,

                              color:
                                  roleColor,

                              letterSpacing:
                                  0.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ===============================
                    // STATUS
                    // ===============================

                    if (user.isActive) ...[

                      const SizedBox(
                        height: 14,
                      ),

                      Row(

                        children: [

                          Container(

                            width: 10,

                            height: 10,

                            decoration:
                                const BoxDecoration(

                              color:
                                  AppColors.success,

                              shape:
                                  BoxShape.circle,
                            ),
                          ),

                          const SizedBox(
                            width: 8,
                          ),

                          const Text(

                            'Active Account',

                            style: TextStyle(

                              color:
                                  AppColors.success,

                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}