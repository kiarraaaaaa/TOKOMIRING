// lib/widgets/buttons/logout_button.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';

import '../../providers/auth_provider.dart';

import '../../screens/auth/login_screen.dart';

class LogoutButton
    extends StatefulWidget {

  final bool isExpanded;

  final bool showIcon;

  final double height;

  // =====================================================
  // CONSTRUCTOR
  // =====================================================

  const LogoutButton({

    super.key,

    this.isExpanded =
        false,

    this.showIcon =
        true,

    this.height =
        56,
  });

  @override
  State<LogoutButton>
      createState() =>
          _LogoutButtonState();
}

class _LogoutButtonState
    extends State<LogoutButton> {

  bool isLoading =
      false;

  // =====================================================
  // LOGOUT
  // =====================================================

  Future<void> logout()
      async {

    final confirm =
        await showDialog<bool>(

      context: context,

      builder: (_) {

        return AlertDialog(

          shape:
              RoundedRectangleBorder(

            borderRadius:
                BorderRadius.circular(
              24,
            ),
          ),

          title:
              const Text(
            'Logout',
          ),

          content:
              const Text(
            'Are you sure you want to logout?',
          ),

          actions: [

            TextButton(

              onPressed: () {

                Navigator.pop(
                  context,
                  false,
                );
              },

              child:
                  const Text(
                'Cancel',
              ),
            ),

            ElevatedButton(

              style:
                  ElevatedButton.styleFrom(

                backgroundColor:
                    AppColors.danger,

                foregroundColor:
                    Colors.white,
              ),

              onPressed: () {

                Navigator.pop(
                  context,
                  true,
                );
              },

              child:
                  const Text(
                'Logout',
              ),
            ),
          ],
        );
      },
    );

    if (confirm != true) {
      return;
    }

    setState(() {

      isLoading = true;
    });

    try {

      await Provider.of<AuthProvider>(

        context,

        listen: false,

      ).logout();

      if (!mounted) {
        return;
      }

      Navigator.pushAndRemoveUntil(

        context,

        MaterialPageRoute(

          builder: (_) =>
              const LoginScreen(),
        ),

        (route) => false,
      );

    } catch (_) {

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(

        const SnackBar(

          content: Text(
            'Logout failed',
          ),
        ),
      );

    } finally {

      if (mounted) {

        setState(() {

          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    final button =
        ElevatedButton.icon(

      onPressed:
          isLoading
              ? null
              : logout,

      icon:
          isLoading

              ? const SizedBox(

                  width: 18,

                  height: 18,

                  child:
                      CircularProgressIndicator(

                    color:
                        Colors.white,

                    strokeWidth:
                        2,
                  ),
                )

              : widget.showIcon

                  ? const Icon(
                      Icons.logout,
                    )

                  : const SizedBox(),

      label:
          Text(

        isLoading
            ? 'Logging out...'
            : 'Logout',

        style:
            const TextStyle(

          fontWeight:
              FontWeight.bold,

          fontSize: 15,
        ),
      ),

      style:
          ElevatedButton.styleFrom(

        elevation: 0,

        backgroundColor:
            AppColors.danger,

        foregroundColor:
            Colors.white,

        disabledBackgroundColor:
            AppColors.danger
                .withOpacity(
          0.7,
        ),

        padding:
            const EdgeInsets.symmetric(

          horizontal: 20,

          vertical: 16,
        ),

        minimumSize:
            Size(
          0,
          widget.height,
        ),

        shape:
            RoundedRectangleBorder(

          borderRadius:
              BorderRadius.circular(
            18,
          ),
        ),
      ),
    );

    // ===================================================
    // EXPANDED
    // ===================================================

    if (widget.isExpanded) {

      return SizedBox(

        width:
            double.infinity,

        height:
            widget.height,

        child:
            button,
      );
    }

    return SizedBox(

      height:
          widget.height,

      child:
          button,
    );
  }
}