// =====================================================
// lib/widgets/user/user_sidebar.dart
// ULTRA AESTHETIC GLASS PREMIUM SIDEBAR
// FINAL COMPACT MODERN VERSION
// =====================================================

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class UserSidebar
    extends StatefulWidget {

  final int selectedIndex;

  final Function(int)
      onSelected;

  final VoidCallback?
      onLogout;

  const UserSidebar({

    super.key,

    required this.selectedIndex,

    required this.onSelected,

    this.onLogout,
  });

  @override
  State<UserSidebar>
      createState() =>
          _UserSidebarState();
}

class _UserSidebarState
    extends State<UserSidebar> {

  bool collapsed = false;

  @override
  Widget build(
    BuildContext context,
  ) {

    final authProvider =
        context.watch<AuthProvider>();

    final currentUser =
        authProvider.user;

    final memberName =
        currentUser?.displayName
                    ?.trim()
                    .isNotEmpty ==
                true

            ? currentUser!.displayName!

            : currentUser?.name
                        .trim()
                        .isNotEmpty ==
                    true

                ? currentUser!.name

                : 'Member';

    final photoUrl =
        currentUser?.safePhotoUrl ??
            '';

    final width =
        MediaQuery.of(context)
            .size
            .width;

    final isTablet =
        width < 1200;

    final isMobile =
        width < 820;

    double sidebarWidth = 215;

    if (collapsed &&
        !isMobile) {

      sidebarWidth = 84;

    } else if (isTablet) {

      sidebarWidth = 188;
    }

    return AnimatedContainer(

      duration:
          const Duration(
        milliseconds: 240,
      ),

      width:
          sidebarWidth,

      decoration:
          const BoxDecoration(

        gradient:
            LinearGradient(

          begin:
              Alignment.topLeft,

          end:
              Alignment.bottomRight,

          colors: [

            Color(
              0xff0B1120,
            ),

            Color(
              0xff172554,
            ),

            Color(
              0xff1E293B,
            ),
          ],
        ),
      ),

      child: Stack(

        children: [

          // =====================================
          // GLOW EFFECT
          // =====================================

          Positioned(

            top: -80,

            left: -60,

            child: Container(

              width: 220,

              height: 220,

              decoration:
                  BoxDecoration(

                shape:
                    BoxShape.circle,

                gradient:
                    RadialGradient(

                  colors: [

                    Colors.blue
                        .withOpacity(
                      0.22,
                    ),

                    Colors
                        .transparent,
                  ],
                ),
              ),
            ),
          ),

          Positioned(

            bottom: -100,

            right: -80,

            child: Container(

              width: 240,

              height: 240,

              decoration:
                  BoxDecoration(

                shape:
                    BoxShape.circle,

                gradient:
                    RadialGradient(

                  colors: [

                    Colors.purple
                        .withOpacity(
                      0.16,
                    ),

                    Colors
                        .transparent,
                  ],
                ),
              ),
            ),
          ),

          // =====================================
          // MAIN CONTENT
          // =====================================

          SafeArea(

            child: Column(

              children: [

                // =================================
                // HEADER
                // =================================

                Padding(

                  padding:
                      const EdgeInsets.fromLTRB(
                    14,
                    16,
                    14,
                    10,
                  ),

                  child: ClipRRect(

                    borderRadius:
                        BorderRadius.circular(
                      22,
                    ),

                    child: BackdropFilter(

                      filter:
                          ImageFilter.blur(

                        sigmaX: 12,

                        sigmaY: 12,
                      ),

                      child: Container(

                        padding:
                            const EdgeInsets.all(
                          12,
                        ),

                        decoration:
                            BoxDecoration(

                          color:
                              Colors.white
                                  .withOpacity(
                            0.06,
                          ),

                          borderRadius:
                              BorderRadius.circular(
                            22,
                          ),

                          border:
                              Border.all(

                            color:
                                Colors.white
                                    .withOpacity(
                              0.05,
                            ),
                          ),
                        ),

                        child: Row(

                          children: [

                            AnimatedContainer(

                              duration:
                                  const Duration(
                                milliseconds:
                                    220,
                              ),

                              width:
                                  collapsed
                                      ? 42
                                      : 46,

                              height:
                                  collapsed
                                      ? 42
                                      : 46,

                              padding:
                                  const EdgeInsets.all(
                                7,
                              ),

                              decoration:
                                  BoxDecoration(

                                gradient:
                                    LinearGradient(

                                  colors: [

                                    Colors.white
                                        .withOpacity(
                                      0.16,
                                    ),

                                    Colors.white
                                        .withOpacity(
                                      0.06,
                                    ),
                                  ],
                                ),

                                borderRadius:
                                    BorderRadius.circular(
                                  16,
                                ),
                              ),

                              child:
                                  ClipRRect(

                                borderRadius:
                                    BorderRadius.circular(
                                  12,
                                ),

                                child: Image.asset(

                                  'assets/images/tokomiring.png',

                                  fit:
                                      BoxFit.cover,
                                ),
                              ),
                            ),

                            if (!collapsed ||
                                isMobile)
                              ...[

                                const SizedBox(
                                  width: 12,
                                ),

                                Expanded(

                                  child: Column(

                                    crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,

                                    children: const [

                                      Text(

                                        'TOKO MIRING',

                                        overflow:
                                            TextOverflow
                                                .ellipsis,

                                        style:
                                            TextStyle(

                                          color:
                                              Colors
                                                  .white,

                                          fontWeight:
                                              FontWeight
                                                  .bold,

                                          fontSize:
                                              13,
                                        ),
                                      ),

                                      SizedBox(
                                        height:
                                            2,
                                      ),

                                      Text(

                                        'Modern Marketplace',

                                        overflow:
                                            TextOverflow
                                                .ellipsis,

                                        style:
                                            TextStyle(

                                          color:
                                              Colors
                                                  .white70,

                                          fontSize:
                                              10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],

                            if (!isMobile)

                              GestureDetector(

                                onTap: () {

                                  setState(() {

                                    collapsed =
                                        !collapsed;
                                  });
                                },

                                child: AnimatedContainer(

                                  duration:
                                      const Duration(
                                    milliseconds:
                                        220,
                                  ),

                                  width: 34,

                                  height: 34,

                                  decoration:
                                      BoxDecoration(

                                    color:
                                        Colors.white
                                            .withOpacity(
                                      0.08,
                                    ),

                                    borderRadius:
                                        BorderRadius.circular(
                                      12,
                                    ),
                                  ),

                                  child: Icon(

                                    collapsed

                                        ? Icons
                                            .menu_rounded

                                        : Icons
                                            .menu_open_rounded,

                                    size: 18,

                                    color:
                                        Colors
                                            .white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // =================================
                // MENU
                // =================================

                Expanded(

                  child: ListView(

                    physics:
                        const BouncingScrollPhysics(),

                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),

                    children: [

                      buildSidebarItem(
                        icon:
                            Icons.dashboard_rounded,
                        title:
                            'Dashboard',
                        index: 0,
                      ),

                      buildSidebarItem(
                        icon:
                            Icons.shopping_bag_rounded,
                        title:
                            'Marketplace',
                        index: 1,
                      ),

                      buildSidebarItem(
                        icon:
                            Icons.shopping_cart_rounded,
                        title:
                            'Cart',
                        index: 2,
                      ),

                      buildSidebarItem(
                        icon:
                            Icons.receipt_long_rounded,
                        title:
                            'History',
                        index: 3,
                      ),

                      buildSidebarItem(
                        icon:
                            Icons.favorite_rounded,
                        title:
                            'Wishlist',
                        index: 4,
                      ),

                      buildSidebarItem(
                        icon:
                            Icons.notifications_rounded,
                        title:
                            'Notifications',
                        index: 5,
                      ),

                      buildSidebarItem(
                        icon:
                            Icons.person_rounded,
                        title:
                            'Profile',
                        index: 6,
                      ),
                    ],
                  ),
                ),

                // =================================
                // PROFILE
                // =================================

                Padding(

                  padding:
                      const EdgeInsets.fromLTRB(
                    12,
                    10,
                    12,
                    16,
                  ),

                  child: Column(

                    children: [

                      ClipRRect(

                        borderRadius:
                            BorderRadius.circular(
                          22,
                        ),

                        child:
                            BackdropFilter(

                          filter:
                              ImageFilter.blur(

                            sigmaX: 10,

                            sigmaY: 10,
                          ),

                          child:
                              InkWell(

                            borderRadius:
                                BorderRadius.circular(
                              22,
                            ),

                            onTap: () {

                              widget.onSelected(
                                6,
                              );
                            },

                            child: Container(

                              padding:
                                  const EdgeInsets.all(
                                12,
                              ),

                              decoration:
                                  BoxDecoration(

                                color:
                                    Colors.white
                                        .withOpacity(
                                  0.05,
                                ),

                                borderRadius:
                                    BorderRadius.circular(
                                  22,
                                ),

                                border:
                                    Border.all(

                                  color:
                                      Colors.white
                                          .withOpacity(
                                    0.05,
                                  ),
                                ),
                              ),

                              child:

                                  collapsed &&
                                          !isMobile

                                      ? Center(

                                          child:
                                              buildAvatar(
                                            photoUrl,
                                          ),
                                        )

                                      : Row(

                                          children: [

                                            buildAvatar(
                                              photoUrl,
                                            ),

                                            const SizedBox(
                                              width:
                                                  12,
                                            ),

                                            Expanded(

                                              child:
                                                  Column(

                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,

                                                children: [

                                                  Row(

                                                    children: [

                                                      Expanded(

                                                        child: Text(

                                                          memberName,

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
                                                                12,
                                                          ),
                                                        ),
                                                      ),

                                                      premiumBadge(),
                                                    ],
                                                  ),

                                                  const SizedBox(
                                                    height:
                                                        4,
                                                  ),

                                                  const Text(

                                                    'Premium Member',

                                                    overflow:
                                                        TextOverflow.ellipsis,

                                                    style:
                                                        TextStyle(

                                                      color:
                                                          Colors.white70,

                                                      fontSize:
                                                          10,
                                                    ),
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

                      const SizedBox(
                        height: 12,
                      ),

                      buildLogoutButton(
                        isMobile,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // SIDEBAR ITEM
  // =====================================================

  Widget buildSidebarItem({

    required IconData icon,

    required String title,

    required int index,
  }) {

    final active =
        widget.selectedIndex ==
            index;

    return Padding(

      padding:
          const EdgeInsets.only(
        bottom: 8,
      ),

      child: AnimatedContainer(

        duration:
            const Duration(
          milliseconds: 220,
        ),

        child: Material(

          color:
              Colors.transparent,

          child: InkWell(

            borderRadius:
                BorderRadius.circular(
              18,
            ),

            onTap: () {

              widget.onSelected(
                index,
              );
            },

            child:
                AnimatedContainer(

              duration:
                  const Duration(
                milliseconds:
                    220,
              ),

              height:
                  collapsed
                      ? 54
                      : 50,

              padding:
                  EdgeInsets.symmetric(

                horizontal:
                    collapsed
                        ? 0
                        : 14,
              ),

              decoration:
                  BoxDecoration(

                gradient:

                    active

                        ? const LinearGradient(

                            begin:
                                Alignment.topLeft,

                            end:
                                Alignment.bottomRight,

                            colors: [

                              Color(
                                0xff2563EB,
                              ),

                              Color(
                                0xff7C3AED,
                              ),
                            ],
                          )

                        : null,

                color:

                    active

                        ? null

                        : Colors.white
                            .withOpacity(
                          0.04,
                        ),

                borderRadius:
                    BorderRadius.circular(
                  18,
                ),

                border: Border.all(

                  color:

                      active

                          ? Colors.white
                              .withOpacity(
                            0.10,
                          )

                          : Colors
                              .transparent,
                ),

                boxShadow:

                    active

                        ? [

                            BoxShadow(

                              color:
                                  Colors.blue
                                      .withOpacity(
                                0.20,
                              ),

                              blurRadius:
                                  18,

                              offset:
                                  const Offset(
                                0,
                                8,
                              ),
                            ),
                          ]

                        : [],
              ),

              child:

                  collapsed

                      ? Center(

                          child: Icon(

                            icon,

                            size: 19,

                            color:
                                Colors
                                    .white,
                          ),
                        )

                      : Row(

                          children: [

                            Icon(

                              icon,

                              size: 19,

                              color:
                                  Colors
                                      .white,
                            ),

                            const SizedBox(
                              width:
                                  12,
                            ),

                            Expanded(

                              child: Text(

                                title,

                                overflow:
                                    TextOverflow
                                        .ellipsis,

                                style:
                                    const TextStyle(

                                  color:
                                      Colors
                                          .white,

                                  fontWeight:
                                      FontWeight.w600,

                                  fontSize:
                                      12,
                                ),
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

  // =====================================================
  // PREMIUM BADGE
  // =====================================================

  Widget premiumBadge() {

    return Container(

      width: 16,

      height: 16,

      decoration:
          const BoxDecoration(

        shape:
            BoxShape.circle,

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
      ),

      child:
          const Center(

        child: Icon(

          Icons.check,

          size: 9,

          color:
              Colors.white,
        ),
      ),
    );
  }

  // =====================================================
  // AVATAR
  // =====================================================

  Widget buildAvatar(
    String base64Photo,
  ) {

    try {

      if (base64Photo
          .isNotEmpty) {

        return Container(

          decoration:
              BoxDecoration(

            shape:
                BoxShape.circle,

            border: Border.all(

              color:
                  Colors.white
                      .withOpacity(
                0.14,
              ),

              width: 1.5,
            ),
          ),

          child: CircleAvatar(

            radius: 19,

            backgroundImage:
                MemoryImage(

              base64Decode(
                base64Photo,
              ),
            ),
          ),
        );
      }

    } catch (_) {}

    return Container(

      decoration:
          BoxDecoration(

        shape:
            BoxShape.circle,

        border: Border.all(

          color:
              Colors.white
                  .withOpacity(
            0.12,
          ),

          width: 1.5,
        ),
      ),

      child:
          const CircleAvatar(

        radius: 19,

        backgroundColor:
            Color(
          0xffE2E8F0,
        ),

        child: Icon(

          Icons.person_rounded,

          size: 18,

          color:
              Color(
            0xff475569,
          ),
        ),
      ),
    );
  }

  // =====================================================
  // LOGOUT
  // =====================================================

  Widget buildLogoutButton(
    bool isMobile,
  ) {

    return InkWell(

      borderRadius:
          BorderRadius.circular(
        18,
      ),

      onTap:
          widget.onLogout,

      child: Container(

        height:
            collapsed &&
                    !isMobile

                ? 50

                : 48,

        padding:
            EdgeInsets.symmetric(

          horizontal:
              collapsed
                  ? 0
                  : 14,
        ),

        decoration:
            BoxDecoration(

          color:
              Colors.red
                  .withOpacity(
            0.10,
          ),

          borderRadius:
              BorderRadius.circular(
            18,
          ),

          border: Border.all(

            color:
                Colors.red
                    .withOpacity(
              0.08,
            ),
          ),
        ),

        child:

            collapsed &&
                    !isMobile

                ? const Center(

                    child: Icon(

                      Icons.logout_rounded,

                      size: 18,

                      color:
                          Colors.red,
                    ),
                  )

                : const Row(

                    children: [

                      Icon(

                        Icons.logout_rounded,

                        size: 18,

                        color:
                            Colors.red,
                      ),

                      SizedBox(
                        width: 10,
                      ),

                      Expanded(

                        child: Text(

                          'Logout',

                          overflow:
                              TextOverflow
                                  .ellipsis,

                          style:
                              TextStyle(

                            color:
                                Colors.red,

                            fontWeight:
                                FontWeight.bold,

                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}