// =====================================================
// FINAL RESPONSIVE VERSION FIXED OVERFLOW
// lib/screens/admin/admin_user_screen.dart
// =====================================================

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../models/user_model.dart';

class AdminUserScreen extends StatefulWidget {
  const AdminUserScreen({
    super.key,
  });

  @override
  State<AdminUserScreen> createState() =>
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

    if (width < 650) {
      analyticsCount = 2;
    }

    if (width < 450) {
      analyticsCount = 1;
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
          14,
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
                        ? 22
                        : 30,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 3,
            ),

            Text(
              'Manage active users and admins.',
              style:
                  TextStyle(
                fontSize: 10,
                color:
                    Colors.grey
                        .shade600,
              ),
            ),

            const SizedBox(
              height: 14,
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
                    10,
                mainAxisSpacing:
                    10,
                childAspectRatio:
                    width < 500
                        ? 2.4
                        : 2.1,
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
                        Icons.people_rounded,
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
                        Icons.check_circle_rounded,
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
                        Icons.block_rounded,
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
                        Icons.admin_panel_settings_rounded,
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
              height: 14,
            ),

            // =====================================
            // FILTER
            // =====================================

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  filters.map(
                (
                  filter,
                ) {
                  final active =
                      selectedFilter ==
                          filter;

                  return InkWell(
                    borderRadius:
                        BorderRadius.circular(
                      10,
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
                            12,
                        vertical:
                            10,
                      ),
                      decoration:
                          BoxDecoration(
                        color:
                            active
                                ? Colors.blue
                                : Colors.white,
                        borderRadius:
                            BorderRadius.circular(
                          10,
                        ),
                      ),
                      child: Text(
                        filter,
                        style:
                            TextStyle(
                          color:
                              active
                                  ? Colors.white
                                  : Colors.black,
                          fontWeight:
                              FontWeight.w600,
                          fontSize:
                              10,
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),

            const SizedBox(
              height: 14,
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
                  22,
                ),
                decoration:
                    BoxDecoration(
                  color:
                      Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                    16,
                  ),
                ),
                child:
                    const Center(
                  child: Text(
                    'No users found',
                    style:
                        TextStyle(
                      fontSize: 11,
                    ),
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
              height: 60,
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
        width < 900;

    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 10,
      ),
      padding:
          const EdgeInsets.all(
        14,
      ),
      decoration:
          BoxDecoration(
        color:
            Colors.white,
        borderRadius:
            BorderRadius.circular(
          16,
        ),
      ),
      child:
          mobile
              ? Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        buildAvatar(
                          user,
                        ),

                        const SizedBox(
                          width: 10,
                        ),

                        Expanded(
                          child:
                              Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: [
                              Wrap(
                                crossAxisAlignment:
                                    WrapCrossAlignment
                                        .center,
                                spacing: 4,
                                runSpacing: 4,
                                children: [
                                  Text(
                                    user.displayName,
                                    style:
                                        const TextStyle(
                                      fontSize:
                                          12.5,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),

                                  if (user.role ==
                                      'admin')
                                    verifiedBadge(),
                                ],
                              ),

                              const SizedBox(
                                height: 3,
                              ),

                              Text(
                                user.email,
                                overflow:
                                    TextOverflow
                                        .ellipsis,
                                maxLines:
                                    2,
                                style:
                                    TextStyle(
                                  fontSize:
                                      9.5,
                                  color:
                                      Colors.grey
                                          .shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
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
                      height: 12,
                    ),

                    SizedBox(
                      width:
                          double.infinity,
                      height:
                          38,
                      child:
                          ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              user.isActive
                                  ? Colors.red
                                  : Colors.green,
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                              10,
                            ),
                          ),
                        ),
                        onPressed: () {
                          toggleUserStatus(
                            user,
                          );
                        },
                        child:
                            FittedBox(
                          child: Text(
                            user.isActive
                                ? 'Ban User'
                                : 'Activate User',
                            style:
                                const TextStyle(
                              fontSize:
                                  10,
                              color:
                                  Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .center,
                  children: [
                    buildAvatar(
                      user,
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    Expanded(
                      flex: 4,
                      child:
                          Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                        children: [
                          Wrap(
                            crossAxisAlignment:
                                WrapCrossAlignment
                                    .center,
                            spacing: 4,
                            runSpacing: 4,
                            children: [
                              Text(
                                user.displayName,
                                style:
                                    const TextStyle(
                                  fontSize:
                                      12.5,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              if (user.role ==
                                  'admin')
                                verifiedBadge(),
                            ],
                          ),

                          const SizedBox(
                            height: 2,
                          ),

                          Text(
                            user.email,
                            overflow:
                                TextOverflow
                                    .ellipsis,
                            maxLines:
                                1,
                            style:
                                TextStyle(
                              fontSize:
                                  9.5,
                              color:
                                  Colors.grey
                                      .shade700,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    Flexible(
                      child:
                          Wrap(
                        spacing: 6,
                        runSpacing: 6,
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
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    SizedBox(
                      width: 95,
                      height: 36,
                      child:
                          ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              user.isActive
                                  ? Colors.red
                                  : Colors.green,
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                              10,
                            ),
                          ),
                        ),
                        onPressed: () {
                          toggleUserStatus(
                            user,
                          );
                        },
                        child:
                            FittedBox(
                          child: Text(
                            user.isActive
                                ? 'Ban User'
                                : 'Activate',
                            style:
                                const TextStyle(
                              fontSize:
                                  9,
                              color:
                                  Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  // =====================================================
  // AVATAR
  // =====================================================

  Widget buildAvatar(
    UserModel user,
  ) {
    try {
      if (user.safePhotoUrl
          .isNotEmpty) {
        return CircleAvatar(
          radius: 17,
          backgroundImage:
              MemoryImage(
            base64Decode(
              user.safePhotoUrl,
            ),
          ),
        );
      }
    } catch (_) {}

    return CircleAvatar(
      radius: 17,
      backgroundColor:
          Colors.blue
              .withOpacity(
        0.1,
      ),
      child:
          const Icon(
        Icons.person_rounded,
        size: 15,
        color:
            Colors.blue,
      ),
    );
  }

  // =====================================================
  // VERIFIED BADGE
  // =====================================================

  Widget verifiedBadge() {
    return Container(
      width: 13,
      height: 13,
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
          Icons.check_rounded,
          size: 7,
          color:
              Colors.white,
        ),
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
    return IntrinsicWidth(
      child: Container(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 5,
        ),
        decoration:
            BoxDecoration(
          color:
              color.withOpacity(
            0.1,
          ),
          borderRadius:
              BorderRadius.circular(
            8,
          ),
        ),
        child:
            Text(
          text,
          textAlign:
              TextAlign.center,
          style:
              TextStyle(
            color: color,
            fontWeight:
                FontWeight.w700,
            fontSize: 8.8,
          ),
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
        12,
      ),
      decoration:
          BoxDecoration(
        color:
            Colors.white,
        borderRadius:
            BorderRadius.circular(
          16,
        ),
      ),
      child:
          Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration:
                BoxDecoration(
              color:
                  color.withOpacity(
                0.12,
              ),
              borderRadius:
                  BorderRadius.circular(
                10,
              ),
            ),
            child: Icon(
              icon,
              color: color,
              size: 18,
            ),
          ),

          const SizedBox(
            width: 10,
          ),

          Expanded(
            child:
                Column(
              mainAxisAlignment:
                  MainAxisAlignment
                      .center,
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '$value',
                    style:
                        const TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 2,
                ),

                Text(
                  title,
                  maxLines: 1,
                  overflow:
                      TextOverflow
                          .ellipsis,
                  style:
                      TextStyle(
                    fontSize: 10,
                    color:
                        Colors.grey
                            .shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}