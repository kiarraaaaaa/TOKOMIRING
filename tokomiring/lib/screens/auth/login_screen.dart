// lib/screens/auth/login_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';

import '../../providers/auth_provider.dart';

import '../admin/admin_dashboard_screen.dart';
import '../user/user_home_screen.dart';

import 'signup_screen.dart';

class LoginScreen
    extends StatefulWidget {

  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen>
      createState() =>
          _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final GlobalKey<FormState>
      _formKey =
      GlobalKey<FormState>();

  final TextEditingController
      emailController =
      TextEditingController();

  final TextEditingController
      passwordController =
      TextEditingController();

  bool obscurePassword =
      true;

  // =====================================================
  // LOGIN
  // =====================================================

  Future<void> login() async {

    FocusScope.of(context)
        .unfocus();

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
          emailController.text
              .trim(),

      password:
          passwordController.text
              .trim(),
    );

    if (!mounted) return;

    // ===================================================
    // SUCCESS
    // ===================================================

    if (success) {

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(

        const SnackBar(
          content: Text(
            'Login success',
          ),
        ),
      );

      // ===============================================
      // ADMIN
      // ===============================================

      if (authProvider.role ==
          'admin') {

        Navigator.pushAndRemoveUntil(
          context,

          MaterialPageRoute(
            builder: (_) =>
                const AdminDashboardScreen(),
          ),

          (route) => false,
        );
      }

      // ===============================================
      // USER
      // ===============================================

      else {

        Navigator.pushAndRemoveUntil(
          context,

          MaterialPageRoute(
            builder: (_) =>
                const UserHomeScreen(),
          ),

          (route) => false,
        );
      }
    }

    // ===================================================
    // FAILED
    // ===================================================

    else {

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(

        SnackBar(
          backgroundColor:
              Colors.red,

          content: Text(
            authProvider
                    .errorMessage ??
                'Login failed',
          ),
        ),
      );
    }
  }

  // =====================================================
  // RESET PASSWORD
  // =====================================================

  Future<void> resetPassword()
      async {

    final TextEditingController
        emailResetController =
        TextEditingController();

    await showDialog(

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

          title: const Text(
            'Reset Password',
          ),

          content: Column(
            mainAxisSize:
                MainAxisSize.min,

            children: [

              const Text(
                'Enter your email to receive reset link.',
              ),

              const SizedBox(
                height: 20,
              ),

              TextField(
                controller:
                    emailResetController,

                decoration:
                    const InputDecoration(

                  labelText:
                      'Email',

                  prefixIcon:
                      Icon(
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

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(

                  SnackBar(

                    backgroundColor:
                        success
                            ? Colors.green
                            : Colors.red,

                    content: Text(

                      success

                          ? 'Reset link sent'

                          : authProvider
                                  .errorMessage ??
                              'Failed',
                    ),
                  ),
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

    emailResetController
        .dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    final authProvider =
        Provider.of<AuthProvider>(
      context,
    );

    return Scaffold(

      body: Container(

        width: double.infinity,

        decoration:
            const BoxDecoration(

          gradient:
              LinearGradient(

            colors: [

              Color(0xff0F172A),

              Color(0xff1E293B),
            ],

            begin:
                Alignment.topLeft,

            end:
                Alignment.bottomRight,
          ),
        ),

        child: Center(

          child:
              SingleChildScrollView(

            padding:
                const EdgeInsets.all(
              20,
            ),

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

                        // =============================
                        // LOGO
                        // =============================

                        Image.asset(
                          'assets/images/tokomiring.png',

                          height: 120,
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        // =============================
                        // TITLE
                        // =============================

                        const Text(

                          'Welcome Back',

                          style: TextStyle(

                            fontSize: 34,

                            fontWeight:
                                FontWeight.bold,
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

                        // =============================
                        // EMAIL
                        // =============================

                        TextFormField(

                          controller:
                              emailController,

                          keyboardType:
                              TextInputType
                                  .emailAddress,

                          decoration:
                              const InputDecoration(

                            labelText:
                                'Email',

                            prefixIcon:
                                Icon(
                              Icons.email,
                            ),
                          ),

                          validator:
                              (value) {

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

                        // =============================
                        // PASSWORD
                        // =============================

                        TextFormField(

                          controller:
                              passwordController,

                          obscureText:
                              obscurePassword,

                          decoration:
                              InputDecoration(

                            labelText:
                                'Password',

                            prefixIcon:
                                const Icon(
                              Icons.lock,
                            ),

                            suffixIcon:
                                IconButton(

                              onPressed: () {

                                setState(() {

                                  obscurePassword =
                                      !obscurePassword;
                                });
                              },

                              icon: Icon(

                                obscurePassword

                                    ? Icons
                                        .visibility_off

                                    : Icons
                                        .visibility,
                              ),
                            ),
                          ),

                          validator:
                              (value) {

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

                        // =============================
                        // FORGOT PASSWORD
                        // =============================

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
                          height: 20,
                        ),

                        // =============================
                        // LOGIN BUTTON
                        // =============================

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

                            child:
                                authProvider
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

                        // =============================
                        // SIGNUP
                        // =============================

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