// lib/screens/auth/signup_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';

import '../../providers/auth_provider.dart';

import '../../widgets/forms/custom_text_field.dart';
import '../../widgets/buttons/primary_button.dart';

import '../user/user_home_screen.dart';

class SignupScreen
    extends StatefulWidget {

  const SignupScreen({
    super.key,
  });

  @override
  State<SignupScreen>
      createState() =>
          _SignupScreenState();
}

class _SignupScreenState
    extends State<SignupScreen> {

  final GlobalKey<FormState>
      _formKey =
      GlobalKey<FormState>();

  final TextEditingController
      nameController =
      TextEditingController();

  final TextEditingController
      usernameController =
      TextEditingController();

  final TextEditingController
      emailController =
      TextEditingController();

  final TextEditingController
      passwordController =
      TextEditingController();

  bool obscurePassword =
      true;

  // =====================================================
  // SIGNUP
  // =====================================================

  Future<void> signup() async {

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
        await authProvider.register(

      name:
          nameController.text
              .trim(),

      username:
          usernameController.text
              .trim()
              .toLowerCase(),

      email:
          emailController.text
              .trim()
              .toLowerCase(),

      password:
          passwordController.text
              .trim(),

      role:
          'user',
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
            'Account created successfully',
          ),
        ),
      );

      Navigator.pushAndRemoveUntil(

        context,

        MaterialPageRoute(
          builder: (_) =>
              const UserHomeScreen(),
        ),

        (route) => false,
      );
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
              AppColors.danger,

          content: Text(

            authProvider
                    .errorMessage ??
                'Signup failed',
          ),
        ),
      );
    }
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

              width: 450,

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

                        // =========================
                        // LOGO
                        // =========================

                        Image.asset(
                          'assets/images/tokomiring.png',

                          height: 110,
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        // =========================
                        // TITLE
                        // =========================

                        const Text(

                          'Create Account',

                          style: TextStyle(

                            fontSize: 32,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        const Text(

                          'Register your account',

                          style: TextStyle(

                            color:
                                Colors.grey,

                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        // =========================
                        // FULL NAME
                        // =========================

                        CustomTextField(

                          controller:
                              nameController,

                          hintText:
                              'Full Name',

                          labelText:
                              'Full Name',

                          prefixIcon:
                              Icons.person,

                          validator:
                              (value) {

                            if (value ==
                                    null ||
                                value
                                    .trim()
                                    .isEmpty) {

                              return 'Full name is required';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        // =========================
                        // USERNAME
                        // =========================

                        CustomTextField(

                          controller:
                              usernameController,

                          hintText:
                              'Username',

                          labelText:
                              'Username',

                          prefixIcon:
                              Icons.alternate_email,

                          validator:
                              (value) {

                            if (value ==
                                    null ||
                                value
                                    .trim()
                                    .isEmpty) {

                              return 'Username is required';
                            }

                            if (value
                                    .length <
                                3) {

                              return 'Minimum 3 characters';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        // =========================
                        // EMAIL
                        // =========================

                        CustomTextField(

                          controller:
                              emailController,

                          hintText:
                              'Email Address',

                          labelText:
                              'Email',

                          keyboardType:
                              TextInputType
                                  .emailAddress,

                          prefixIcon:
                              Icons.email,

                          validator:
                              (value) {

                            if (value ==
                                    null ||
                                value
                                    .trim()
                                    .isEmpty) {

                              return 'Email is required';
                            }

                            if (!value
                                .contains(
                              '@',
                            )) {

                              return 'Invalid email';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        // =========================
                        // PASSWORD
                        // =========================

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

                            if (value
                                    .length <
                                6) {

                              return 'Minimum 6 characters';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(
                          height: 35,
                        ),

                        // =========================
                        // BUTTON
                        // =========================

                        PrimaryButton(

                          text:
                              'Create Account',

                          isLoading:
                              authProvider
                                  .isLoading,

                          onPressed: () {

                            if (authProvider
                                .isLoading) {
                              return;
                            }

                            signup();
                          },
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        // =========================
                        // LOGIN
                        // =========================

                        TextButton(

                          onPressed: () {

                            Navigator.pop(
                              context,
                            );
                          },

                          child: const Text(
                            'Already have an account? Login',
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

    nameController.dispose();

    usernameController.dispose();

    emailController.dispose();

    passwordController.dispose();

    super.dispose();
  }
}