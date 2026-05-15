// =====================================================
// lib/widgets/user/user_sidebar.dart
// FINAL ULTRA PREMIUM RESPONSIVE VERSION
// =====================================================

import 'dart:convert';

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

    double sidebarWidth = 220;

    if (collapsed &&
        !isMobile) {

      sidebarWidth = 82;

    } else if (isTablet) {

      sidebarWidth = 190;
    }

    return AnimatedContainer(

      duration:
          const Duration(
        milliseconds: 220,
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
              0xff0F172A,
            ),

            Color(
              0xff172554,
            ),
          ],
        ),
      ),

      child: SafeArea(

        child: Column(

          children: [

            // =====================================
            // HEADER
            // =====================================

            Padding(

              padding:
                  const EdgeInsets.fromLTRB(
                14,
                18,
                14,
                12,
              ),

              child: Row(

                children: [

                  AnimatedContainer(

                    duration:
                        const Duration(
                      milliseconds: 220,
                    ),

                    width:
                        collapsed
                            ? 44
                            : 48,

                    height:
                        collapsed
                            ? 44
                            : 48,

                    padding:
                        const EdgeInsets.all(
                      7,
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
                      isMobile) ...[

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

                            maxLines: 1,

                            style:
                                TextStyle(

                              color:
                                  Colors.white,

                              fontWeight:
                                  FontWeight.bold,

                              fontSize: 13,
                            ),
                          ),

                          SizedBox(
                            height: 2,
                          ),

                          Text(

                            'Premium Dashboard',

                            overflow:
                                TextOverflow
                                    .ellipsis,

                            maxLines: 1,

                            style:
                                TextStyle(

                              color:
                                  Colors.white70,

                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  if (!isMobile)

                    InkWell(

                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),

                      onTap: () {

                        setState(() {

                          collapsed =
                              !collapsed;
                        });
                      },

                      child: Container(

                        width: 36,

                        height: 36,

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

                              ? Icons.menu_rounded

                              : Icons.menu_open_rounded,

                          size: 18,

                          color:
                              Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // =====================================
            // MENU
            // =====================================

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

            // =====================================
            // PROFILE
            // =====================================

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

                  InkWell(

                    borderRadius:
                        BorderRadius.circular(
                      20,
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
                          0.06,
                        ),

                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),

                        border: Border.all(

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
                                      width: 12,
                                    ),

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

                                                  memberName,

                                                  overflow:
                                                      TextOverflow
                                                          .ellipsis,

                                                  maxLines:
                                                      1,

                                                  style:
                                                      const TextStyle(

                                                    color:
                                                        Colors.white,

                                                    fontSize:
                                                        12,

                                                    fontWeight:
                                                        FontWeight.bold,
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(
                                                width:
                                                    6,
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
                                                TextOverflow
                                                    .ellipsis,

                                            maxLines:
                                                1,

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
    );
  }

  // =========================================
  // SIDEBAR ITEM
  // =========================================

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
            milliseconds: 220,
          ),

          height:
              collapsed
                  ? 54
                  : 52,

          padding:
              EdgeInsets.symmetric(

            horizontal:
                collapsed
                    ? 0
                    : 14,
          ),

          decoration:
              BoxDecoration(

            borderRadius:
                BorderRadius.circular(
              18,
            ),

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
          ),

          child:

              collapsed

                  ? Center(

                      child: Icon(

                        icon,

                        size: 20,

                        color:
                            Colors.white,
                      ),
                    )

                  : Row(

                      children: [

                        Icon(

                          icon,

                          size: 20,

                          color:
                              Colors.white,
                        ),

                        const SizedBox(
                          width: 12,
                        ),

                        Expanded(

                          child: Text(

                            title,

                            overflow:
                                TextOverflow
                                    .ellipsis,

                            maxLines: 1,

                            style:
                                const TextStyle(

                              color:
                                  Colors.white,

                              fontWeight:
                                  FontWeight.w600,

                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }

  // =====================================
  // PREMIUM BADGE
  // =====================================

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

  // =====================================
  // AVATAR
  // =====================================

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
                0.12,
              ),

              width: 1.5,
            ),
          ),

          child: CircleAvatar(

            radius: 20,

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

        radius: 20,

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

  // =====================================
  // LOGOUT
  // =====================================

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

                ? 52

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

          color:
              Colors.red
                  .withOpacity(
            0.10,
          ),

          borderRadius:
              BorderRadius.circular(
            18,
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

                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}