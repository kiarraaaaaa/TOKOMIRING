// lib/widgets/user/user_sidebar.dart

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
        context.watch<
            AuthProvider>();

    final currentUser =
        authProvider.user;

    final memberName =
        currentUser?.displayName?.trim().isNotEmpty ==
                true
            ? currentUser!.displayName!
            : currentUser?.name.trim().isNotEmpty ==
                    true
                ? currentUser!.name
                : 'Member';

    final memberRole =
        currentUser?.roleLabel ??
            'Member';

    final photoUrl =
        currentUser?.safePhotoUrl ??
            '';

    final width =
        MediaQuery.of(context)
            .size
            .width;

    final bool isTablet =
        width < 1200;

    final bool isMobile =
        width < 820;

    double sidebarWidth = 176;

    if (collapsed &&
        !isMobile) {

      sidebarWidth = 68;

    } else if (isTablet) {

      sidebarWidth = 156;
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

            // =============================================
            // HEADER
            // =============================================

            Padding(

              padding:
                  const EdgeInsets.fromLTRB(
                8,
                10,
                8,
                4,
              ),

              child: Row(
                children: [

                  Container(

                    width:
                        collapsed
                            ? 34
                            : 36,

                    height:
                        collapsed
                            ? 34
                            : 36,

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

                    child:
                        ClipRRect(

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

                  if (!collapsed ||
                      isMobile) ...[

                    const SizedBox(
                      width: 7,
                    ),

                    Expanded(

                      child: Column(

                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        mainAxisSize:
                            MainAxisSize.min,

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

                              fontSize: 10,
                            ),
                          ),

                          SizedBox(
                            height: 1,
                          ),

                          Text(

                            'Member Dashboard',

                            overflow:
                                TextOverflow
                                    .ellipsis,

                            maxLines: 1,

                            style:
                                TextStyle(

                              color:
                                  Colors.white70,

                              fontSize: 7.5,
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
                        8,
                      ),

                      onTap: () {

                        setState(() {

                          collapsed =
                              !collapsed;
                        });
                      },

                      child: Container(

                        width: 26,

                        height: 26,

                        decoration:
                            BoxDecoration(

                          color:
                              Colors.white
                                  .withOpacity(
                            0.08,
                          ),

                          borderRadius:
                              BorderRadius.circular(
                            8,
                          ),
                        ),

                        child: Icon(

                          collapsed

                              ? Icons.menu_rounded

                              : Icons.menu_open_rounded,

                          size: 14,

                          color:
                              Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(
              height: 4,
            ),

            // =============================================
            // MENU
            // =============================================

            Expanded(

              child:
                  ListView(

                physics:
                    const BouncingScrollPhysics(),

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 7,
                ),

                children: [

                  sidebarItem(
                    icon:
                        Icons.dashboard_rounded,
                    title:
                        'Dashboard',
                    index: 0,
                  ),

                  sidebarItem(
                    icon:
                        Icons.shopping_bag_rounded,
                    title:
                        'Marketplace',
                    index: 1,
                  ),

                  sidebarItem(
                    icon:
                        Icons.shopping_cart_rounded,
                    title:
                        'Cart',
                    index: 2,
                  ),

                  sidebarItem(
                    icon:
                        Icons.receipt_long_rounded,
                    title:
                        'History',
                    index: 3,
                  ),

                  sidebarItem(
                    icon:
                        Icons.favorite_rounded,
                    title:
                        'Wishlist',
                    index: 4,
                  ),

                  sidebarItem(
                    icon:
                        Icons.notifications_rounded,
                    title:
                        'Notifications',
                    index: 5,
                  ),

                  sidebarItem(
                    icon:
                        Icons.person_rounded,
                    title:
                        'Profile',
                    index: 6,
                  ),
                ],
              ),
            ),

            // =============================================
            // PROFILE
            // =============================================

            Padding(

              padding:
                  const EdgeInsets.fromLTRB(
                8,
                4,
                8,
                8,
              ),

              child: Column(
                children: [

                  InkWell(

                    borderRadius:
                        BorderRadius.circular(
                      12,
                    ),

                    onTap: () {

                      widget.onSelected(
                        6,
                      );
                    },

                    child: Container(

                      padding:
                          const EdgeInsets.symmetric(

                        horizontal: 8,

                        vertical: 8,
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
                          12,
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
                                      width: 7,
                                    ),

                                    Expanded(
                                      child: Column(

                                        crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,

                                        mainAxisSize:
                                            MainAxisSize
                                                .min,

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

                                                    fontWeight:
                                                        FontWeight.w700,

                                                    fontSize:
                                                        9.6,
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(
                                                width:
                                                    3,
                                              ),

                                              premiumBadge(),
                                            ],
                                          ),

                                          const SizedBox(
                                            height:
                                                1,
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
                                                  7.3,
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
                    height: 8,
                  ),

                  logoutButton(
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

  Widget premiumBadge() {

    return Container(

      width: 14,

      height: 14,

      decoration:
          BoxDecoration(

        shape:
            BoxShape.circle,

        gradient:
            const LinearGradient(

          colors: [

            Color(
              0xff38BDF8,
            ),

            Color(
              0xff2563EB,
            ),
          ],
        ),

        border: Border.all(

          color:
              Colors.white,

          width: 1,
        ),
      ),

      child:
          const Center(

        child: Icon(

          Icons.check,

          size: 8,

          color:
              Colors.white,
        ),
      ),
    );
  }

  Widget buildAvatar(
    String base64Photo, {
    double radius = 13,
  }) {

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
                0.18,
              ),

              width: 1,
            ),
          ),

          child: CircleAvatar(

            radius: radius,

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
            0.15,
          ),

          width: 1,
        ),
      ),

      child:
          CircleAvatar(

        radius: radius,

        backgroundColor:
            const Color(
          0xffE2E8F0,
        ),

        child: Icon(

          Icons.person_rounded,

          size: 13,

          color:
              Color(
            0xff475569,
          ),
        ),
      ),
    );
  }

  Widget sidebarItem({

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
        bottom: 5,
      ),

      child: InkWell(

        borderRadius:
            BorderRadius.circular(
          12,
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
                  ? 42
                  : 40,

          padding:
              EdgeInsets.symmetric(

            horizontal:
                collapsed
                    ? 0
                    : 10,
          ),

          decoration:
              BoxDecoration(

            borderRadius:
                BorderRadius.circular(
              12,
            ),

            gradient:

                active

                    ? const LinearGradient(

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
          ),

          child:

              collapsed

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
                          width: 9,
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

                              fontSize:
                                  10,
                            ),
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }

  Widget logoutButton(
    bool isMobile,
  ) {

    return InkWell(

      borderRadius:
          BorderRadius.circular(
        12,
      ),

      onTap:
          widget.onLogout,

      child: Container(

        width:
            double.infinity,

        height:
            collapsed &&
                    !isMobile

                ? 42

                : 40,

        padding:
            EdgeInsets.symmetric(

          horizontal:
              collapsed
                  ? 0
                  : 10,
        ),

        decoration:
            BoxDecoration(

          color:
              Colors.red
                  .withOpacity(
            0.08,
          ),

          borderRadius:
              BorderRadius.circular(
            12,
          ),
        ),

        child:

            collapsed &&
                    !isMobile

                ? const Center(
                    child: Icon(

                      Icons.logout_rounded,

                      size: 15,

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
                        width: 8,
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

                            fontSize:
                                10,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}