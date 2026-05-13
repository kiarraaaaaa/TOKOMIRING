// =====================================================
// FIX FINAL - ADMIN USER SCREEN
// FIX:
// ✅ FREEZE
// ✅ OVERFLOW
// ✅ GRID CRASH
// ✅ SIDEBAR LAG
// ✅ BUTTON KEGEDEAN
// ✅ SCROLL BUG
// =====================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../models/user_model.dart';

class AdminUserScreen
    extends StatefulWidget {

  const AdminUserScreen({
    super.key,
  });

  @override
  State<AdminUserScreen>
      createState() =>
          _AdminUserScreenState();
}

class _AdminUserScreenState
    extends State<AdminUserScreen> {

  String selectedFilter =
      'All Users';

  final List<String> filters = [

    'All Users',

    'Active Users',

    'Banned Users',

    'Admins',
  ];

  @override
  void initState() {

    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {

      final provider =
          Provider.of<AuthProvider>(
        context,
        listen: false,
      );

      provider.loadUsers();
    });
  }

  // =====================================================
  // TOGGLE STATUS
  // =====================================================

  Future<void> toggleUserStatus(
    UserModel user,
  ) async {

    final provider =
        Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    final updated =
        user.copyWith(
      isActive:
          !user.isActive,
    );

    await provider.updateUser(
      updated,
    );
  }

  // =====================================================
  // FILTER
  // =====================================================

  List<UserModel> getFilteredUsers(
    List<UserModel> users,
  ) {

    switch (selectedFilter) {

      case 'Active Users':

        return users.where(
          (
            e,
          ) {

            return e.isActive;
          },
        ).toList();

      case 'Banned Users':

        return users.where(
          (
            e,
          ) {

            return !e.isActive;
          },
        ).toList();

      case 'Admins':

        return users.where(
          (
            e,
          ) {

            return e.role ==
                'admin';
          },
        ).toList();

      default:

        return users;
    }
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(
    BuildContext context,
  ) {

    final provider =
        Provider.of<AuthProvider>(
      context,
    );

    final users =
        provider.users;

    final filteredUsers =
        getFilteredUsers(
      users,
    );

    final width =
        MediaQuery.of(context)
            .size
            .width;

    int analyticsCount = 4;

    if (width < 700) {

      analyticsCount = 1;

    } else if (width < 1100) {

      analyticsCount = 2;
    }

    return Container(

      color:
          const Color(
        0xffF8FAFC,
      ),

      child:
          SingleChildScrollView(

        physics:
            const BouncingScrollPhysics(),

        padding:
            const EdgeInsets.all(
          24,
        ),

        child:
            Column(
          crossAxisAlignment:
              CrossAxisAlignment
                  .start,

          children: [

            Text(

              'User Management',

              style:
                  TextStyle(

                fontSize:
                    width < 700
                        ? 28
                        : 42,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Text(

              'Manage active users and admins.',

              style:
                  TextStyle(

                fontSize: 15,

                color:
                    Colors.grey
                        .shade600,
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            // =====================================
            // ANALYTICS
            // =====================================

            GridView.builder(

              shrinkWrap:
                  true,

              physics:
                  const NeverScrollableScrollPhysics(),

              itemCount: 4,

              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(

                crossAxisCount:
                    analyticsCount,

                crossAxisSpacing:
                    18,

                mainAxisSpacing:
                    18,

                mainAxisExtent:
                    180,
              ),

              itemBuilder:
                  (
                    context,
                    index,
                  ) {

                final analytics = [

                  {
                    'title':
                        'Total Users',

                    'value':
                        users.length,

                    'icon':
                        Icons.people,

                    'color':
                        Colors.blue,
                  },

                  {
                    'title':
                        'Active Users',

                    'value':
                        users
                            .where(
                      (
                        e,
                      ) {

                        return e.isActive;
                      },
                    ).length,

                    'icon':
                        Icons.check_circle,

                    'color':
                        Colors.green,
                  },

                  {
                    'title':
                        'Banned Users',

                    'value':
                        users
                            .where(
                      (
                        e,
                      ) {

                        return !e.isActive;
                      },
                    ).length,

                    'icon':
                        Icons.block,

                    'color':
                        Colors.red,
                  },

                  {
                    'title':
                        'Admins',

                    'value':
                        users
                            .where(
                      (
                        e,
                      ) {

                        return e.role ==
                            'admin';
                      },
                    ).length,

                    'icon':
                        Icons.admin_panel_settings,

                    'color':
                        Colors.purple,
                  },
                ];

                final item =
                    analytics[index];

                return analyticsCard(

                  item['title']
                      as String,

                  item['value']
                      as int,

                  item['icon']
                      as IconData,

                  item['color']
                      as Color,
                );
              },
            ),

            const SizedBox(
              height: 28,
            ),

            // =====================================
            // FILTER
            // =====================================

            SizedBox(

              height: 54,

              child:
                  ListView.builder(

                scrollDirection:
                    Axis.horizontal,

                itemCount:
                    filters.length,

                itemBuilder:
                    (
                      context,
                      index,
                    ) {

                  final filter =
                      filters[index];

                  final active =
                      selectedFilter ==
                          filter;

                  return Padding(

                    padding:
                        const EdgeInsets.only(
                      right: 12,
                    ),

                    child:
                        InkWell(

                      borderRadius:
                          BorderRadius.circular(
                        14,
                      ),

                      onTap: () {

                        setState(() {

                          selectedFilter =
                              filter;
                        });
                      },

                      child:
                          AnimatedContainer(

                        duration:
                            const Duration(
                          milliseconds:
                              220,
                        ),

                        padding:
                            const EdgeInsets.symmetric(

                          horizontal:
                              20,

                          vertical:
                              14,
                        ),

                        decoration:
                            BoxDecoration(

                          color:

                              active

                                  ? Colors.blue

                                  : Colors.white,

                          borderRadius:
                              BorderRadius.circular(
                            14,
                          ),
                        ),

                        child:
                            Center(

                          child: Text(

                            filter,

                            style:
                                TextStyle(

                              color:

                                  active

                                      ? Colors.white

                                      : Colors.black,

                              fontWeight:
                                  FontWeight.bold,

                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            // =====================================
            // USER LIST
            // =====================================

            if (filteredUsers
                .isEmpty)

              Container(

                width:
                    double.infinity,

                padding:
                    const EdgeInsets.all(
                  40,
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

                child:
                    const Center(

                  child: Text(
                    'No users found',
                  ),
                ),
              )

            else

              ListView.builder(

                shrinkWrap:
                    true,

                physics:
                    const NeverScrollableScrollPhysics(),

                itemCount:
                    filteredUsers.length,

                itemBuilder:
                    (
                      context,
                      index,
                    ) {

                  final user =
                      filteredUsers[
                          index];

                  return userCard(
                    user,
                  );
                },
              ),

            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // USER CARD
  // =====================================================

  Widget userCard(
    UserModel user,
  ) {

    final width =
        MediaQuery.of(context)
            .size
            .width;

    final mobile =
        width < 850;

    return Container(

      margin:
          const EdgeInsets.only(
        bottom: 18,
      ),

      padding:
          const EdgeInsets.all(
        22,
      ),

      decoration:
          BoxDecoration(

        color:
            Colors.white,

        borderRadius:
            BorderRadius.circular(
          24,
        ),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black
                    .withOpacity(
              0.03,
            ),

            blurRadius: 10,

            offset:
                const Offset(
              0,
              4,
            ),
          ),
        ],
      ),

      child:

          mobile

              ? Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    Row(
                      children: [

                        CircleAvatar(

                          radius: 28,

                          backgroundColor:
                              Colors.blue
                                  .withOpacity(
                            0.1,
                          ),

                          child:
                              const Icon(
                            Icons.person,
                            color:
                                Colors.blue,
                          ),
                        ),

                        const SizedBox(
                          width: 16,
                        ),

                        Expanded(
                          child:
                              Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [

                              Text(

                                user.name,

                                overflow:
                                    TextOverflow
                                        .ellipsis,

                                style:
                                    const TextStyle(

                                  fontSize:
                                      18,

                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              const SizedBox(
                                height:
                                    6,
                              ),

                              Text(
                                user.email,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 18,
                    ),

                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [

                        chip(
                          user.role
                              .toUpperCase(),
                          user.role ==
                                  'admin'

                              ? Colors
                                  .purple

                              : Colors
                                  .blue,
                        ),

                        chip(

                          user.isActive

                              ? 'ACTIVE'

                              : 'BANNED',

                          user.isActive

                              ? Colors
                                  .green

                              : Colors
                                  .red,
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    SizedBox(

                      width:
                          double.infinity,

                      height:
                          44,

                      child:
                          ElevatedButton(

                        style:
                            ElevatedButton.styleFrom(

                          backgroundColor:

                              user.isActive

                                  ? Colors.red

                                  : Colors.green,
                        ),

                        onPressed:
                            () {

                          toggleUserStatus(
                            user,
                          );
                        },

                        child:
                            Text(

                          user.isActive

                              ? 'Ban User'

                              : 'Activate User',

                          style:
                              const TextStyle(
                            color:
                                Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )

              : Row(
                  children: [

                    CircleAvatar(

                      radius: 30,

                      backgroundColor:
                          Colors.blue
                              .withOpacity(
                        0.1,
                      ),

                      child:
                          const Icon(
                        Icons.person,
                        color:
                            Colors.blue,
                      ),
                    ),

                    const SizedBox(
                      width: 18,
                    ),

                    Expanded(
                      flex: 3,

                      child:
                          Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [

                          Text(

                            user.name,

                            overflow:
                                TextOverflow
                                    .ellipsis,

                            style:
                                const TextStyle(

                              fontSize: 18,

                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(
                            height: 6,
                          ),

                          Text(
                            user.email,
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child:
                          chip(
                        user.role
                            .toUpperCase(),

                        user.role ==
                                'admin'

                            ? Colors
                                .purple

                            : Colors
                                .blue,
                      ),
                    ),

                    Expanded(
                      child:
                          chip(

                        user.isActive

                            ? 'ACTIVE'

                            : 'BANNED',

                        user.isActive

                            ? Colors
                                .green

                            : Colors
                                .red,
                      ),
                    ),

                    SizedBox(

                      width: 140,

                      height: 42,

                      child:
                          ElevatedButton(

                        style:
                            ElevatedButton.styleFrom(

                          backgroundColor:

                              user.isActive

                                  ? Colors.red

                                  : Colors.green,
                        ),

                        onPressed:
                            () {

                          toggleUserStatus(
                            user,
                          );
                        },

                        child:
                            Text(

                          user.isActive

                              ? 'Ban'

                              : 'Activate',

                          style:
                              const TextStyle(
                            color:
                                Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  // =====================================================
  // CHIP
  // =====================================================

  Widget chip(
    String text,
    Color color,
  ) {

    return Container(

      padding:
          const EdgeInsets.symmetric(

        horizontal: 14,

        vertical: 8,
      ),

      decoration:
          BoxDecoration(

        color:
            color.withOpacity(
          0.1,
        ),

        borderRadius:
            BorderRadius.circular(
          12,
        ),
      ),

      child:
          Text(

        text,

        style:
            TextStyle(

          color: color,

          fontWeight:
              FontWeight.bold,

          fontSize: 12,
        ),
      ),
    );
  }

  // =====================================================
  // ANALYTICS CARD
  // =====================================================

  Widget analyticsCard(

    String title,

    int value,

    IconData icon,

    Color color,
  ) {

    return Container(

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

      child:
          Column(
        crossAxisAlignment:
            CrossAxisAlignment
                .start,

        children: [

          Container(

            width: 56,

            height: 56,

            decoration:
                BoxDecoration(

              color:
                  color.withOpacity(
                0.12,
              ),

              borderRadius:
                  BorderRadius.circular(
                16,
              ),
            ),

            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),

          const Spacer(),

          Text(

            '$value',

            style:
                const TextStyle(

              fontSize: 30,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 6,
          ),

          Text(

            title,

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
        ],
      ),
    );
  }
}