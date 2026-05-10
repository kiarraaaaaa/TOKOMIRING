// lib/widgets/buttons/logout_button.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

import '../../screens/auth/login_screen.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        await Provider.of<AuthProvider>(
          context,
          listen: false,
        ).logout();

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const LoginScreen(),
          ),
          (route) => false,
        );
      },

      icon: const Icon(
        Icons.logout,
      ),

      label: const Text(
        'Logout',
      ),

      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,

        foregroundColor: Colors.white,

        padding:
            const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),

        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(16),
        ),
      ),
    );
  }
}