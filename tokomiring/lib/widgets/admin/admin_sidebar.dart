import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class AdminSidebar
    extends StatefulWidget {

  final int selectedIndex;

  final Function(int)
      onSelected;

  final VoidCallback?
      onLogout;

  const AdminSidebar({

    super.key,

    required this.selectedIndex,

    required this.onSelected,

    this.onLogout,
  });

  @override
  State<AdminSidebar>
      createState() =>
          _AdminSidebarState();
}

class _AdminSidebarState
    extends State<AdminSidebar> {

  bool collapsed = false;

  @override
  Widget build(
    BuildContext context,
  ) {

    // =================================================
    // REALTIME AUTH
    // =================================================

    final authProvider =
        context.watch<AuthProvider>();

    final currentUser =
        authProvider.user;

    final adminName =

        currentUser
                    ?.name
                    .trim()
                    .isNotEmpty ==
                true

            ? currentUser!
                .name

            : 'Administrator';

    final photoUrl =
        currentUser?.photoUrl ??
            '';

    final width =
        MediaQuery.of(context)
            .size
            .width;

    final bool isTablet =
        width < 1200;

    final bool isMobile =
        width < 800;

    double sidebarWidth = 185;

    if (collapsed &&
        !isMobile) {

      sidebarWidth = 68;

    } else if (isTablet) {

      sidebarWidth = 165;
    }

    return AnimatedContainer(

      duration:
          const Duration(
        milliseconds: 250,
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
              0xff1E293B,
            ),
          ],
        ),
      ),

      child: SafeArea(

        child: Column(
          children: [

            // =================================================
            // HEADER
            // =================================================

            Padding(

              padding:
                  const EdgeInsets.all(
                10,
              ),

              child: Row(
                children: [

                  Container(

                    width: 36,

                    height: 36,

                    decoration:
                        BoxDecoration(

                      borderRadius:
                          BorderRadius.circular(
                        10,
                      ),

                      gradient:
                          const LinearGradient(

                        colors: [

                          Color(
                            0xff2563EB,
                          ),

                          Color(
                            0xff7C3AED,
                          ),
                        ],
                      ),
                    ),

                    child:
                        const Icon(

                      Icons.storefront,

                      size: 17,

                      color:
                          Colors.white,
                    ),
                  ),

                  if (!collapsed ||
                      isMobile) ...[

                    const SizedBox(
                      width: 8,
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

                            'Admin Panel',

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

                        width: 28,

                        height: 28,

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

                              ? Icons.menu

                              : Icons.menu_open,

                          size: 15,

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

            // =================================================
            // MENU
            // =================================================

            Expanded(

              child:
                  ListView(

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 8,
                ),

                children: [

                  sidebarItem(
                    icon:
                        Icons.dashboard,
                    title:
                        'Dashboard',
                    index: 0,
                  ),

                  sidebarItem(
                    icon:
                        Icons.inventory_2,
                    title:
                        'Products',
                    index: 1,
                  ),

                  sidebarItem(
                    icon:
                        Icons.shopping_bag,
                    title:
                        'Orders',
                    index: 2,
                  ),

                  sidebarItem(
                    icon:
                        Icons.bar_chart,
                    title:
                        'Reports',
                    index: 3,
                  ),

                  sidebarItem(
                    icon:
                        Icons.people,
                    title:
                        'Users',
                    index: 4,
                  ),

                  sidebarItem(
                    icon:
                        Icons.notifications,
                    title:
                        'Notifications',
                    index: 5,
                  ),

                  sidebarItem(
                    icon:
                        Icons.person,
                    title:
                        'Profile',
                    index: 6,
                  ),
                ],
              ),
            ),

            // =================================================
            // FOOTER PROFILE
            // =================================================

            Padding(

              padding:
                  const EdgeInsets.all(
                10,
              ),

              child: Column(
                children: [

                  InkWell(

                    borderRadius:
                        BorderRadius.circular(
                      14,
                    ),

                    onTap: () {

                      widget.onSelected(
                        6,
                      );
                    },

                    child: Container(

                      padding:
                          const EdgeInsets.all(
                        10,
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
                          14,
                        ),
                      ),

                      child:

                          collapsed &&
                                  !isMobile

                              ? buildAvatar(
                                  photoUrl,
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

                                          Row(
                                            children: [

                                              Expanded(
                                                child: Text(

                                                  adminName,

                                                  overflow:
                                                      TextOverflow
                                                          .ellipsis,

                                                  style:
                                                      const TextStyle(

                                                    color:
                                                        Colors.white,

                                                    fontWeight:
                                                        FontWeight.bold,

                                                    fontSize: 10.5,
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(
                                                width:
                                                    4,
                                              ),

                                              Container(

                                                width:
                                                    14,

                                                height:
                                                    14,

                                                decoration:
                                                    const BoxDecoration(

                                                  color:
                                                      Color(
                                                    0xff3B82F6,
                                                  ),

                                                  shape:
                                                      BoxShape.circle,
                                                ),

                                                child:
                                                    const Icon(

                                                  Icons.check,

                                                  color:
                                                      Colors.white,

                                                  size:
                                                      10,
                                                ),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(
                                            height:
                                                1,
                                          ),

                                          const Text(

                                            'System Manager',

                                            style:
                                                TextStyle(

                                              color:
                                                  Colors.white70,

                                              fontSize:
                                                  8.5,
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
                    height: 10,
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

  // =====================================================
  // REALTIME AVATAR
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
                0.15,
              ),

              width: 1.2,
            ),
          ),

          child: CircleAvatar(

            radius: 14,

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

          width: 1.2,
        ),
      ),

      child:
          const CircleAvatar(

        radius: 14,

        backgroundColor:
            Color(
          0xffE2E8F0,
        ),

        child: Icon(

          Icons.person,

          size: 14,

          color:
              Color(
            0xff475569,
          ),
        ),
      ),
    );
  }

  // =====================================================
  // ITEM
  // =====================================================

  Widget sidebarItem({

    required IconData icon,

    required String title,

    required int index,
  }) {

    final active =
        widget.selectedIndex ==
            index;

    final showText =
        !collapsed;

    return Padding(

      padding:
          const EdgeInsets.only(
        bottom: 6,
      ),

      child: InkWell(

        borderRadius:
            BorderRadius.circular(
          14,
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
            milliseconds: 250,
          ),

          padding:
              const EdgeInsets.symmetric(

            horizontal: 11,

            vertical: 11,
          ),

          decoration:
              BoxDecoration(

            borderRadius:
                BorderRadius.circular(
              14,
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

          child: Row(
            children: [

              Icon(

                icon,

                size: 17,

                color:
                    Colors.white,
              ),

              if (showText) ...[

                const SizedBox(
                  width: 10,
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

                      fontSize: 10.5,
                    ),
                  ),
                ),

                if (active)

                  Container(

                    width: 5,

                    height: 5,

                    decoration:
                        const BoxDecoration(

                      color:
                          Colors.white,

                      shape:
                          BoxShape.circle,
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // LOGOUT
  // =====================================================

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

        padding:
            const EdgeInsets.symmetric(

          horizontal: 12,

          vertical: 11,
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

                ? const Icon(

                    Icons.logout,

                    size: 15,

                    color:
                        Colors.red,
                  )

                : const Row(
                    children: [

                      Icon(

                        Icons.logout,

                        size: 15,

                        color:
                            Colors.red,
                      ),

                      SizedBox(
                        width: 8,
                      ),

                      Text(

                        'Logout',

                        style:
                            TextStyle(

                          color:
                              Colors.red,

                          fontSize: 10.5,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}