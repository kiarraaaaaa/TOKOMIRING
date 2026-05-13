import 'package:flutter/material.dart';

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

    final width =
        MediaQuery.of(context)
            .size
            .width;

    final bool isTablet =
        width < 1200;

    final bool isMobile =
        width < 800;

    double sidebarWidth = 280;

    if (collapsed &&
        !isMobile) {

      sidebarWidth = 90;

    } else if (isTablet) {

      sidebarWidth = 230;
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

            // =========================================
            // HEADER
            // =========================================

            Padding(

              padding:
                  const EdgeInsets.all(
                20,
              ),

              child: Row(
                children: [

                  Container(

                    width: 54,

                    height: 54,

                    decoration:
                        BoxDecoration(

                      borderRadius:
                          BorderRadius.circular(
                        18,
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

                      color:
                          Colors.white,
                    ),
                  ),

                  if (!collapsed ||
                      isMobile) ...[

                    const SizedBox(
                      width: 14,
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

                              fontSize: 18,
                            ),
                          ),

                          SizedBox(
                            height: 4,
                          ),

                          Text(

                            'Admin Panel',

                            style:
                                TextStyle(

                              color:
                                  Colors.white70,

                              fontSize: 12,
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
                        14,
                      ),

                      onTap: () {

                        setState(() {

                          collapsed =
                              !collapsed;
                        });
                      },

                      child: Container(

                        width: 42,

                        height: 42,

                        decoration:
                            BoxDecoration(

                          color:
                              Colors.white
                                  .withOpacity(
                            0.08,
                          ),

                          borderRadius:
                              BorderRadius.circular(
                            14,
                          ),
                        ),

                        child: Icon(

                          collapsed

                              ? Icons.menu

                              : Icons.menu_open,

                          color:
                              Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            // =========================================
            // MENU
            // =========================================

            Expanded(

              child:
                  ListView(

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 14,
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
                ],
              ),
            ),

            // =========================================
            // FOOTER
            // =========================================

            Padding(

              padding:
                  const EdgeInsets.all(
                20,
              ),

              child: Column(
                children: [

                  Container(

                    padding:
                        const EdgeInsets.all(
                      16,
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
                    ),

                    child:

                        collapsed &&
                                !isMobile

                            ? const CircleAvatar(

                                radius: 24,

                                child: Icon(
                                  Icons.person,
                                ),
                              )

                            : Row(
                                children: [

                                  const CircleAvatar(
                                    radius: 24,
                                    child: Icon(
                                      Icons.person,
                                    ),
                                  ),

                                  const SizedBox(
                                    width: 14,
                                  ),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,

                                      children: const [

                                        Text(

                                          'Administrator',

                                          overflow:
                                              TextOverflow
                                                  .ellipsis,

                                          style:
                                              TextStyle(

                                            color:
                                                Colors.white,

                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),

                                        SizedBox(
                                          height:
                                              4,
                                        ),

                                        Text(

                                          'System Manager',

                                          style:
                                              TextStyle(

                                            color:
                                                Colors.white70,

                                            fontSize:
                                                12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                  ),

                  const SizedBox(
                    height: 16,
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
        bottom: 12,
      ),

      child: InkWell(

        borderRadius:
            BorderRadius.circular(
          20,
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

            horizontal: 18,

            vertical: 18,
          ),

          decoration:
              BoxDecoration(

            borderRadius:
                BorderRadius.circular(
              20,
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

                color:
                    Colors.white,
              ),

              if (showText) ...[

                const SizedBox(
                  width: 18,
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

                      fontSize: 16,
                    ),
                  ),
                ),

                if (active)

                  Container(

                    width: 10,

                    height: 10,

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
        18,
      ),

      onTap:
          widget.onLogout,

      child: Container(

        width:
            double.infinity,

        padding:
            const EdgeInsets.symmetric(

          horizontal: 18,

          vertical: 18,
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
            18,
          ),
        ),

        child:

            collapsed &&
                    !isMobile

                ? const Icon(

                    Icons.logout,

                    color:
                        Colors.red,
                  )

                : const Row(
                    children: [

                      Icon(

                        Icons.logout,

                        color:
                            Colors.red,
                      ),

                      SizedBox(
                        width: 14,
                      ),

                      Text(

                        'Logout',

                        style:
                            TextStyle(

                          color:
                              Colors.red,

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