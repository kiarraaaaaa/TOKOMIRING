// lib/screens/auth/login_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

import '../admin/admin_dashboard_screen.dart';
import '../user/user_home_screen.dart';

import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {
  final GlobalKey<FormState>
      _formKey = GlobalKey<FormState>();

  final TextEditingController
      emailController =
      TextEditingController();

  final TextEditingController
      passwordController =
      TextEditingController();

  // =====================================================
  // LOGIN
  // =====================================================

  Future<void> login() async {
    if (!_formKey.currentState!
        .validate()) {
      return;
    }

    final authProvider =
        Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    final success =
        await authProvider.login(
      email:
          emailController.text.trim(),

      password:
          passwordController.text
              .trim(),
    );

    if (!mounted) return;

    if (success) {
      // =============================================
      // ADMIN
      // =============================================

      if (authProvider.role ==
          'admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const AdminDashboardScreen(),
          ),
        );
      }

      // =============================================
      // USER
      // =============================================

      else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const UserHomeScreen(),
          ),
        );
      }
    }
  }

  // =====================================================
  // RESET PASSWORD
  // =====================================================

  Future<void> resetPassword() async {
    final emailResetController =
        TextEditingController();

    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              20,
            ),
          ),

          title: const Text(
            'Reset Password',
          ),

          content: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              const Text(
                'Enter your email address to receive a password reset link.',
              ),

              const SizedBox(
                height: 20,
              ),

              TextField(
                controller:
                    emailResetController,

                decoration:
                    const InputDecoration(
                  labelText: 'Email',

                  prefixIcon: Icon(
                    Icons.email,
                  ),
                ),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
              child: const Text(
                'Cancel',
              ),
            ),

            ElevatedButton(
              onPressed: () async {
                if (emailResetController
                    .text
                    .trim()
                    .isEmpty) {
                  return;
                }

                final authProvider =
                    Provider.of<
                        AuthProvider>(
                  context,
                  listen: false,
                );

                final success =
                    await authProvider
                        .resetPassword(
                  emailResetController
                      .text
                      .trim(),
                );

                if (!mounted) return;

                Navigator.pop(
                  context,
                );

                showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),
                      ),

                      title: Icon(
                        success
                            ? Icons
                                .check_circle
                            : Icons.error,
                        color: success
                            ? Colors.green
                            : Colors.red,
                        size: 70,
                      ),

                      content: Text(
                        success
                            ? 'Password reset email has been sent.'
                            : authProvider
                                    .errorMessage ??
                                'Failed to send reset email.',
                        textAlign:
                            TextAlign.center,
                      ),

                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                            );
                          },
                          child: const Text(
                            'OK',
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text(
                'Send',
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider =
        Provider.of<AuthProvider>(
      context,
    );

    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff0F172A),
              Color(0xff1E293B),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Center(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.all(20),

            child: SizedBox(
              width: 430,

              child: Card(
                elevation: 10,

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    30,
                  ),
                ),

                child: Padding(
                  padding:
                      const EdgeInsets.all(
                    30,
                  ),

                  child: Form(
                    key: _formKey,

                    child: Column(
                      mainAxisSize:
                          MainAxisSize.min,

                      children: [
                        // =====================================
                        // LOGO
                        // =====================================

                        Image.asset(
                          'assets/images/tokomiring.png',
                          height: 120,
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        // =====================================
                        // TITLE
                        // =====================================

                        const Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        const Text(
                          'Login to continue',
                          style: TextStyle(
                            color:
                                Colors.grey,
                          ),
                        ),

                        const SizedBox(
                          height: 35,
                        ),

                        // =====================================
                        // EMAIL
                        // =====================================

                        TextFormField(
                          controller:
                              emailController,

                          decoration:
                              const InputDecoration(
                            labelText:
                                'Email',

                            prefixIcon:
                                Icon(
                              Icons.email,
                            ),
                          ),

                          validator: (
                            value,
                          ) {
                            if (value ==
                                    null ||
                                value
                                    .trim()
                                    .isEmpty) {
                              return 'Email is required';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        // =====================================
                        // PASSWORD
                        // =====================================

                        TextFormField(
                          controller:
                              passwordController,

                          obscureText:
                              true,

                          decoration:
                              const InputDecoration(
                            labelText:
                                'Password',

                            prefixIcon:
                                Icon(
                              Icons.lock,
                            ),
                          ),

                          validator: (
                            value,
                          ) {
                            if (value ==
                                    null ||
                                value
                                    .trim()
                                    .isEmpty) {
                              return 'Password is required';
                            }

                            return null;
                          },
                        ),

                        // =====================================
                        // FORGOT PASSWORD
                        // =====================================

                        Align(
                          alignment:
                              Alignment
                                  .centerRight,

                          child: TextButton(
                            onPressed:
                                resetPassword,

                            child: const Text(
                              'Forgot Password?',
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        // =====================================
                        // ERROR
                        // =====================================

                        if (authProvider
                                .errorMessage !=
                            null)
                          Container(
                            width:
                                double.infinity,

                            padding:
                                const EdgeInsets
                                    .all(
                              14,
                            ),

                            margin:
                                const EdgeInsets
                                    .only(
                              bottom: 20,
                            ),

                            decoration:
                                BoxDecoration(
                              color: Colors
                                  .red
                                  .shade100,

                              borderRadius:
                                  BorderRadius.circular(
                                14,
                              ),
                            ),

                            child: Text(
                              authProvider
                                  .errorMessage!,

                              style: TextStyle(
                                color: Colors
                                    .red
                                    .shade800,
                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),
                          ),

                        // =====================================
                        // LOGIN BUTTON
                        // =====================================

                        SizedBox(
                          width:
                              double.infinity,

                          height: 58,

                          child: ElevatedButton(
                            onPressed:
                                authProvider
                                        .isLoading
                                    ? null
                                    : login,

                            child: authProvider
                                    .isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child:
                                        CircularProgressIndicator(
                                      color:
                                          Colors.white,
                                      strokeWidth:
                                          2,
                                    ),
                                  )
                                : const Text(
                                    'Login',
                                  ),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        // =====================================
                        // CREATE ACCOUNT
                        // =====================================

                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) =>
                                        const SignupScreen(),
                              ),
                            );
                          },

                          child: const Text(
                            'Create Account',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();

    passwordController.dispose();

    super.dispose();
  }
}