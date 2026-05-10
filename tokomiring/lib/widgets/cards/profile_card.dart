// lib/widgets/cards/profile_card.dart

import 'package:flutter/material.dart';

import '../../models/user_model.dart';

class ProfileCard extends StatelessWidget {
  final UserModel user;

  const ProfileCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.all(24),
        child: Row(
          children: [
            CircleAvatar(
              radius: 45,
              backgroundImage:
                  user.photoUrl.isEmpty
                      ? null
                      : NetworkImage(
                          user.photoUrl,
                        ),
              child: user.photoUrl.isEmpty
                  ? const Icon(
                      Icons.person,
                      size: 40,
                    )
                  : null,
            ),

            const SizedBox(width: 20),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    '@${user.username}',
                  ),

                  const SizedBox(height: 8),

                  Text(user.email),

                  const SizedBox(height: 12),

                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: user.role ==
                              'admin'
                          ? Colors.red
                              .withOpacity(0.1)
                          : Colors.blue
                              .withOpacity(0.1),

                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),
                    ),
                    child: Text(
                      user.role.toUpperCase(),
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                        color: user.role ==
                                'admin'
                            ? Colors.red
                            : Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}