// =====================================================
// lib/widgets/cards/profile_card.dart
// FINAL FULL REVISED VERSION
// PREMIUM + COMPACT + UPLOAD PHOTO READY
// =====================================================

import 'dart:convert';

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../models/user_model.dart';

class ProfileCard
    extends StatefulWidget {

  final UserModel user;

  final VoidCallback? onTap;

  final VoidCallback?
      onUploadPhoto;

  const ProfileCard({

    super.key,

    required this.user,

    this.onTap,

    this.onUploadPhoto,
  });

  @override
  State<ProfileCard>
      createState() =>
          _ProfileCardState();
}

class _ProfileCardState
    extends State<ProfileCard> {

  bool hovered = false;

  // =====================================================
  // ROLE COLOR
  // =====================================================

  Color getRoleColor() {

    switch (
        widget.user.role) {

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

    switch (
        widget.user.role) {

      case 'admin':
        return Icons
            .admin_panel_settings_rounded;

      case 'user':
        return Icons
            .person_rounded;

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

    final width =
        MediaQuery.of(context)
            .size
            .width;

    final isMobile =
        width < 700;

    return MouseRegion(

      onEnter: (_) {

        setState(() {

          hovered = true;
        });
      },

      onExit: (_) {

        setState(() {

          hovered = false;
        });
      },

      child:
          AnimatedContainer(

        duration:
            const Duration(
          milliseconds: 220,
        ),

        transform:
            Matrix4.identity()
              ..translate(
                0.0,
                hovered ? -3 : 0,
              ),

        child: Material(

          color:
              Colors.transparent,

          child: InkWell(

            borderRadius:
                BorderRadius.circular(
              28,
            ),

            onTap:
                widget.onTap,

            child:
                AnimatedContainer(

              duration:
                  const Duration(
                milliseconds:
                    220,
              ),

              padding:
                  EdgeInsets.all(

                isMobile
                    ? 16
                    : 18,
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

                    Colors.white,

                    Color(
                      0xffF8FAFC,
                    ),
                  ],
                ),

                borderRadius:
                    BorderRadius.circular(
                  28,
                ),

                border: Border.all(

                  color:

                      hovered

                          ? roleColor
                              .withOpacity(
                            0.10,
                          )

                          : Colors.grey
                              .shade100,
                ),

                boxShadow: [

                  BoxShadow(

                    color:
                        Colors.black
                            .withOpacity(

                      hovered
                          ? 0.05
                          : 0.03,
                    ),

                    blurRadius:

                        hovered
                            ? 22
                            : 16,

                    offset:
                        Offset(
                      0,
                      hovered
                          ? 12
                          : 8,
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

                  Stack(

                    clipBehavior:
                        Clip.none,

                    children: [

                      AnimatedContainer(

                        duration:
                            const Duration(
                          milliseconds:
                              220,
                        ),

                        decoration:
                            BoxDecoration(

                          shape:
                              BoxShape.circle,

                          boxShadow: [

                            BoxShadow(

                              color:
                                  roleColor
                                      .withOpacity(
                                hovered
                                    ? 0.22
                                    : 0.14,
                              ),

                              blurRadius:
                                  hovered
                                      ? 20
                                      : 14,

                              offset:
                                  const Offset(
                                0,
                                8,
                              ),
                            ),
                          ],
                        ),

                        child: Container(

                          padding:
                              const EdgeInsets.all(
                            2,
                          ),

                          decoration:
                              BoxDecoration(

                            shape:
                                BoxShape.circle,

                            gradient:
                                LinearGradient(

                              colors: [

                                roleColor,

                                roleColor
                                    .withOpacity(
                                  0.6,
                                ),
                              ],
                            ),
                          ),

                          child:
                              CircleAvatar(

                            radius:
                                isMobile
                                    ? 32
                                    : 36,

                            backgroundColor:
                                Colors
                                    .grey
                                    .shade200,

                            backgroundImage:

                                widget.user
                                        .photoUrl
                                        .isEmpty

                                    ? null

                                    : widget.user
                                            .photoUrl
                                            .startsWith(
                                          'http',
                                        )

                                        ? NetworkImage(
                                            widget.user.photoUrl,
                                          )

                                        : MemoryImage(

                                            base64Decode(
                                              widget.user.photoUrl,
                                            ),
                                          )
                                              as ImageProvider,

                            child:

                                widget.user
                                        .photoUrl
                                        .isEmpty

                                    ? Icon(

                                        Icons
                                            .person_rounded,

                                        size:
                                            isMobile
                                                ? 28
                                                : 32,

                                        color:
                                            Colors
                                                .grey
                                                .shade600,
                                      )

                                    : null,
                          ),
                        ),
                      ),

                      // =================================
                      // CAMERA BUTTON
                      // =================================

                      Positioned(

                        right: -2,

                        bottom: -2,

                        child:
                            GestureDetector(

                          onTap:
                              widget
                                  .onUploadPhoto,

                          child:
                              AnimatedContainer(

                            duration:
                                const Duration(
                              milliseconds:
                                  220,
                            ),

                            width:
                                hovered
                                    ? 32
                                    : 30,

                            height:
                                hovered
                                    ? 32
                                    : 30,

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

                      // VERIFIED

                      Positioned(

                        top: -2,

                        right: 0,

                        child:
                            Container(

                          width: 20,

                          height: 20,

                          decoration:
                              const BoxDecoration(

                            gradient:
                                LinearGradient(

                              colors: [

                                Color(
                                  0xff38BDF8,
                                ),

                                Color(
                                  0xff2563EB,
                                ),
                              ],
                            ),

                            shape:
                                BoxShape.circle,
                          ),

                          child:
                              const Icon(

                            Icons.check,

                            size: 11,

                            color:
                                Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    width:
                        isMobile
                            ? 14
                            : 18,
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

                        Row(

                          children: [

                            Expanded(

                              child: Text(

                                widget.user.name,

                                maxLines: 1,

                                overflow:
                                    TextOverflow
                                        .ellipsis,

                                style:
                                    TextStyle(

                                  fontSize:

                                      isMobile
                                          ? 16
                                          : 18,

                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),
                            ),

                            Container(

                              padding:
                                  const EdgeInsets.symmetric(

                                horizontal:
                                    8,

                                vertical:
                                    5,
                              ),

                              decoration:
                                  BoxDecoration(

                                color:
                                    AppColors
                                        .primary
                                        .withOpacity(
                                  0.08,
                                ),

                                borderRadius:
                                    BorderRadius.circular(
                                  12,
                                ),
                              ),

                              child: Row(

                                mainAxisSize:
                                    MainAxisSize
                                        .min,

                                children: const [

                                  Icon(

                                    Icons
                                        .verified_rounded,

                                    size: 12,

                                    color:
                                        AppColors
                                            .primary,
                                  ),

                                  SizedBox(
                                    width:
                                        4,
                                  ),

                                  Text(

                                    'Premium',

                                    style:
                                        TextStyle(

                                      fontSize:
                                          9,

                                      fontWeight:
                                          FontWeight
                                              .bold,

                                      color:
                                          AppColors
                                              .primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 4,
                        ),

                        Text(

                          '@${widget.user.username}',

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
                          height: 10,
                        ),

                        Row(

                          children: [

                            Container(

                              width: 24,

                              height: 24,

                              decoration:
                                  BoxDecoration(

                                color:
                                    Colors.grey
                                        .shade100,

                                borderRadius:
                                    BorderRadius.circular(
                                  8,
                                ),
                              ),

                              child: Icon(

                                Icons
                                    .email_outlined,

                                size: 13,

                                color:
                                    Colors.grey
                                        .shade700,
                              ),
                            ),

                            const SizedBox(
                              width: 8,
                            ),

                            Expanded(

                              child: Text(

                                widget.user.email,

                                maxLines: 1,

                                overflow:
                                    TextOverflow
                                        .ellipsis,

                                style:
                                    TextStyle(

                                  fontSize:
                                      11,

                                  color:
                                      Colors.grey
                                          .shade700,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 12,
                        ),

                        Wrap(

                          spacing: 8,

                          runSpacing: 8,

                          children: [

                            Container(

                              padding:
                                  const EdgeInsets.symmetric(

                                horizontal:
                                    10,

                                vertical:
                                    6,
                              ),

                              decoration:
                                  BoxDecoration(

                                color:
                                    roleColor
                                        .withOpacity(
                                  0.10,
                                ),

                                borderRadius:
                                    BorderRadius.circular(
                                  12,
                                ),
                              ),

                              child: Row(

                                mainAxisSize:
                                    MainAxisSize
                                        .min,

                                children: [

                                  Icon(

                                    getRoleIcon(),

                                    size: 13,

                                    color:
                                        roleColor,
                                  ),

                                  const SizedBox(
                                    width:
                                        5,
                                  ),

                                  Text(

                                    widget
                                        .user
                                        .role
                                        .toUpperCase(),

                                    style:
                                        TextStyle(

                                      fontSize:
                                          10,

                                      fontWeight:
                                          FontWeight
                                              .bold,

                                      color:
                                          roleColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            if (widget
                                .user
                                .isActive)

                              Container(

                                padding:
                                    const EdgeInsets.symmetric(

                                  horizontal:
                                      10,

                                  vertical:
                                      6,
                                ),

                                decoration:
                                    BoxDecoration(

                                  color:
                                      AppColors
                                          .success
                                          .withOpacity(
                                    0.10,
                                  ),

                                  borderRadius:
                                      BorderRadius.circular(
                                    12,
                                  ),
                                ),

                                child:
                                    const Row(

                                  mainAxisSize:
                                      MainAxisSize
                                          .min,

                                  children: [

                                    Icon(

                                      Icons
                                          .check_circle,

                                      size:
                                          13,

                                      color:
                                          AppColors
                                              .success,
                                    ),

                                    SizedBox(
                                      width:
                                          4,
                                    ),

                                    Text(

                                      'ACTIVE',

                                      style:
                                          TextStyle(

                                        fontSize:
                                            10,

                                        fontWeight:
                                            FontWeight
                                                .bold,

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
        ),
      ),
    );
  }
}