// =====================================================
// lib/widgets/user/user_sidebar.dart
// FINAL FIXED MOBILE RESPONSIVE VERSION
// =====================================================

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class UserSidebar extends StatefulWidget {

  final int selectedIndex;

  final Function(int) onSelected;

  final VoidCallback? onLogout;

  const UserSidebar({

    super.key,

    required this.selectedIndex,

    required this.onSelected,

    this.onLogout,
  });

  @override
  State<UserSidebar> createState() =>
      _UserSidebarState();
}

class _UserSidebarState
    extends State<UserSidebar> {

  bool collapsed = false;

  @override
  Widget build(BuildContext context) {

    final authProvider =
        context.watch<AuthProvider>();

    final currentUser =
        authProvider.user;

    final memberName =
        currentUser?.displayName?.trim().isNotEmpty == true
            ? currentUser!.displayName!
            : currentUser?.name.trim().isNotEmpty == true
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
        width < 900;

    if (isMobile) {
      collapsed = true;
    }

    double sidebarWidth = 168;

    if (collapsed) {

      sidebarWidth = 64;

    } else if (isTablet) {

      sidebarWidth = 150;
    }

    return AnimatedContainer(

      duration:
          const Duration(
        milliseconds: 220,
      ),

      width: sidebarWidth,

      decoration:
          const BoxDecoration(

        gradient:
            LinearGradient(

          begin:
              Alignment.topLeft,

          end:
              Alignment.bottomRight,

          colors: [

            Color(0xff0B1120),

            Color(0xff172554),

            Color(0xff1E293B),
          ],
        ),
      ),

      child: SafeArea(

        child: Column(

          children: [

            // =================================
            // HEADER
            // =================================

            Padding(

              padding:
                  const EdgeInsets.fromLTRB(
                8,
                10,
                8,
                6,
              ),

              child: Container(

                padding:
                    const EdgeInsets.all(
                  6,
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
                    14,
                  ),
                ),

                child: Row(

                  mainAxisAlignment:

                      collapsed ||
                              isMobile

                          ? MainAxisAlignment
                              .center

                          : MainAxisAlignment
                              .start,

                  children: [

                    Container(

                      width: 34,

                      height: 34,

                      padding:
                          const EdgeInsets.all(
                        4,
                      ),

                      decoration:
                          BoxDecoration(

                        color:
                            Colors.white
                                .withOpacity(
                          0.08,
                        ),

                        borderRadius:
                            BorderRadius.circular(
                          10,
                        ),
                      ),

                      child: ClipRRect(

                        borderRadius:
                            BorderRadius.circular(
                          8,
                        ),

                        child: Image.asset(

                          'assets/images/tokomiring.png',

                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    if (!collapsed &&
                        !isMobile)
                      ...[

                        const SizedBox(
                          width: 8,
                        ),

                        const Expanded(

                          child: Column(

                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [

                              Text(

                                'TOKOMIRING',

                                overflow:
                                    TextOverflow
                                        .ellipsis,

                                style:
                                    TextStyle(

                                  color:
                                      Colors.white,

                                  fontWeight:
                                      FontWeight.bold,

                                  fontSize: 10,
                                ),
                              ),

                              SizedBox(
                                height: 1,
                              ),

                              Text(

                                'Premium UI',

                                overflow:
                                    TextOverflow
                                        .ellipsis,

                                style:
                                    TextStyle(

                                  color:
                                      Colors.white70,

                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                    if (!isMobile)
                      ...[

                        const SizedBox(
                          width: 6,
                        ),

                        GestureDetector(

                          onTap: () {

                            setState(() {

                              collapsed =
                                  !collapsed;
                            });
                          },

                          child: Container(

                            width: 24,

                            height: 24,

                            decoration:
                                BoxDecoration(

                              color:
                                  Colors.white
                                      .withOpacity(
                                0.06,
                              ),

                              borderRadius:
                                  BorderRadius.circular(
                                8,
                              ),
                            ),

                            child: Icon(

                              collapsed

                                  ? Icons
                                      .menu_rounded

                                  : Icons
                                      .menu_open_rounded,

                              size: 13,

                              color:
                                  Colors.white,
                            ),
                          ),
                        ),
                      ],
                  ],
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
                  horizontal: 8,
                ),

                children: [

                  buildSidebarItem(
                    icon:
                        Icons.dashboard_rounded,
                    title:
                        'Dashboard',
                    index: 0,
                    isMobile:
                        isMobile,
                  ),

                  buildSidebarItem(
                    icon:
                        Icons.shopping_bag_rounded,
                    title:
                        'Marketplace',
                    index: 1,
                    isMobile:
                        isMobile,
                  ),

                  buildSidebarItem(
                    icon:
                        Icons.shopping_cart_rounded,
                    title:
                        'Cart',
                    index: 2,
                    isMobile:
                        isMobile,
                  ),

                  buildSidebarItem(
                    icon:
                        Icons.receipt_long_rounded,
                    title:
                        'History',
                    index: 3,
                    isMobile:
                        isMobile,
                  ),

                  buildSidebarItem(
                    icon:
                        Icons.favorite_rounded,
                    title:
                        'Wishlist',
                    index: 4,
                    isMobile:
                        isMobile,
                  ),

                  buildSidebarItem(
                    icon:
                        Icons.notifications_rounded,
                    title:
                        'Notifications',
                    index: 5,
                    isMobile:
                        isMobile,
                  ),

                  buildSidebarItem(
                    icon:
                        Icons.person_rounded,
                    title:
                        'Profile',
                    index: 6,
                    isMobile:
                        isMobile,
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
                8,
                6,
                8,
                10,
              ),

              child: Column(

                children: [

                  Container(

                    padding:
                        const EdgeInsets.all(
                      7,
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
                        14,
                      ),
                    ),

                    child:

                        collapsed ||
                                isMobile

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
                                    width: 8,
                                  ),

                                  Expanded(

                                    child: Column(

                                      crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,

                                      children: [

                                        Text(

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

                                            fontSize: 10,
                                          ),
                                        ),

                                        const SizedBox(
                                          height: 1,
                                        ),

                                        const Text(

                                          'Premium',

                                          overflow:
                                              TextOverflow
                                                  .ellipsis,

                                          style:
                                              TextStyle(

                                            color:
                                                Colors.white70,

                                            fontSize: 8,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  premiumBadge(),
                                ],
                              ),
                  ),

                  const SizedBox(
                    height: 8,
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
    );
  }

  Widget buildSidebarItem({

    required IconData icon,

    required String title,

    required int index,

    required bool isMobile,
  }) {

    final active =
        widget.selectedIndex ==
            index;

    final compact =
        collapsed ||
            isMobile;

    return Padding(

      padding:
          const EdgeInsets.only(
        bottom: 5,
      ),

      child: InkWell(

        borderRadius:
            BorderRadius.circular(
          14,
        ),

        onTap: () {

          widget.onSelected(index);
        },

        child: AnimatedContainer(

          duration:
              const Duration(
            milliseconds: 200,
          ),

          height: 40,

          padding:
              EdgeInsets.symmetric(

            horizontal:
                compact
                    ? 0
                    : 10,
          ),

          decoration:
              BoxDecoration(

            gradient:

                active

                    ? const LinearGradient(

                        colors: [

                          Color(
                            0xff2563EB,
                          ),

                          Color(
                            0xff1D4ED8,
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
              14,
            ),
          ),

          child:

              compact

                  ? Center(

                      child: Icon(

                        icon,

                        size: 16,

                        color:
                            Colors.white,
                      ),
                    )

                  : Row(

                      children: [

                        Icon(

                          icon,

                          size: 16,

                          color:
                              Colors.white,
                        ),

                        const SizedBox(
                          width: 8,
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
                                  Colors.white,

                              fontWeight:
                                  FontWeight.w600,

                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }

  Widget premiumBadge() {

    return Container(

      width: 12,

      height: 12,

      decoration:
          const BoxDecoration(

        shape:
            BoxShape.circle,

        gradient:
            LinearGradient(

          colors: [

            Color(0xff38BDF8),

            Color(0xff2563EB),
          ],
        ),
      ),

      child:
          const Center(

        child: Icon(

          Icons.check,

          size: 7,

          color:
              Colors.white,
        ),
      ),
    );
  }

  Widget buildAvatar(
    String base64Photo,
  ) {

    try {

      if (base64Photo
          .isNotEmpty) {

        return CircleAvatar(

          radius: 15,

          backgroundImage:
              MemoryImage(

            base64Decode(
              base64Photo,
            ),
          ),
        );
      }

    } catch (_) {}

    return const CircleAvatar(

      radius: 15,

      backgroundColor:
          Color(0xffE2E8F0),

      child: Icon(

        Icons.person_rounded,

        size: 13,

        color:
            Color(0xff475569),
      ),
    );
  }

  Widget buildLogoutButton(
    bool isMobile,
  ) {

    final compact =
        collapsed ||
            isMobile;

    return InkWell(

      borderRadius:
          BorderRadius.circular(
        14,
      ),

      onTap:
          widget.onLogout,

      child: Container(

        height: 38,

        padding:
            EdgeInsets.symmetric(

          horizontal:
              compact
                  ? 0
                  : 10,
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
            14,
          ),
        ),

        child:

            compact

                ? const Center(

                    child: Icon(

                      Icons.logout_rounded,

                      size: 16,

                      color:
                          Colors.red,
                    ),
                  )

                : const Row(

                    children: [

                      Icon(

                        Icons.logout_rounded,

                        size: 15,

                        color:
                            Colors.red,
                      ),

                      SizedBox(
                        width: 6,
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

                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}