// lib/widgets/cards/profile_card.dart

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

import '../../models/user_model.dart';

class ProfileCard
    extends StatelessWidget {

  final UserModel user;

  final VoidCallback? onTap;

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
          18,
        ),

        onTap:
            onTap,

        child: Container(

          padding:
              const EdgeInsets.all(
            16,
          ),

          decoration:
              BoxDecoration(

            color:
                Colors.white,

            borderRadius:
                BorderRadius.circular(
              18,
            ),

            boxShadow: [

              BoxShadow(

                color:
                    Colors.black
                        .withOpacity(
                  0.025,
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

          child: Row(

            crossAxisAlignment:
                CrossAxisAlignment
                    .center,

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
                        0.12,
                      ),

                      blurRadius:
                          8,

                      offset:
                          const Offset(
                        0,
                        3,
                      ),
                    ),
                  ],
                ),

                child: CircleAvatar(

                  radius: 30,

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

                              size: 28,

                              color:
                                  Colors.grey
                                      .shade600,
                            )

                          : null,
                ),
              ),

              const SizedBox(
                width: 14,
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

                        fontSize: 16,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 2,
                    ),

                    // ===============================
                    // USERNAME
                    // ===============================

                    Text(

                      '@${user.username}',

                      maxLines: 1,

                      overflow:
                          TextOverflow
                              .ellipsis,

                      style:
                          TextStyle(

                        color:
                            Colors.grey
                                .shade700,

                        fontSize: 11,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    // ===============================
                    // EMAIL
                    // ===============================

                    Row(

                      children: [

                        Icon(

                          Icons.email_outlined,

                          size: 14,

                          color:
                              Colors.grey
                                  .shade600,
                        ),

                        const SizedBox(
                          width: 5,
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

                              fontSize: 11,

                              color:
                                  Colors.grey
                                      .shade700,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    // ===============================
                    // BADGES
                    // ===============================

                    Wrap(

                      spacing: 8,

                      runSpacing: 8,

                      children: [

                        Container(

                          padding:
                              const EdgeInsets.symmetric(

                            horizontal: 10,

                            vertical: 6,
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
                              10,
                            ),
                          ),

                          child: Row(

                            mainAxisSize:
                                MainAxisSize.min,

                            children: [

                              Icon(

                                getRoleIcon(),

                                size: 13,

                                color:
                                    roleColor,
                              ),

                              const SizedBox(
                                width: 4,
                              ),

                              Text(

                                user.role
                                    .toUpperCase(),

                                style:
                                    TextStyle(

                                  fontSize: 10,

                                  fontWeight:
                                      FontWeight.bold,

                                  color:
                                      roleColor,
                                ),
                              ),
                            ],
                          ),
                        ),

                        if (user.isActive)

                          Container(

                            padding:
                                const EdgeInsets.symmetric(

                              horizontal: 10,

                              vertical: 6,
                            ),

                            decoration:
                                BoxDecoration(

                              color:
                                  AppColors
                                      .success
                                      .withOpacity(
                                0.1,
                              ),

                              borderRadius:
                                  BorderRadius.circular(
                                10,
                              ),
                            ),

                            child: const Row(

                              mainAxisSize:
                                  MainAxisSize.min,

                              children: [

                                Icon(

                                  Icons
                                      .check_circle,

                                  size: 13,

                                  color:
                                      AppColors
                                          .success,
                                ),

                                SizedBox(
                                  width: 4,
                                ),

                                Text(

                                  'ACTIVE',

                                  style:
                                      TextStyle(

                                    fontSize:
                                        10,

                                    fontWeight:
                                        FontWeight.bold,

                                    color:
                                        AppColors
                                            .success,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
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