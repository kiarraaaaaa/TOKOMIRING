// =====================================================
// FULL FIXED VERSION
// lib/screens/auth/login_screen.dart
// ADMIN DASHBOARD ERROR FIXED
// =====================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    extends State<LoginScreen>
    with TickerProviderStateMixin {

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

  late AnimationController
      _animationController;

  late Animation<double>
      _fadeAnimation;

  late Animation<Offset>
      _slideAnimation;

  @override
  void initState() {

    super.initState();

    _animationController =
        AnimationController(

      vsync: this,

      duration:
          const Duration(
        milliseconds: 700,
      ),
    );

    _fadeAnimation =
        CurvedAnimation(

      parent:
          _animationController,

      curve:
          Curves.easeInOut,
    );

    _slideAnimation =
        Tween<Offset>(

      begin:
          const Offset(
        0,
        0.08,
      ),

      end:
          Offset.zero,

    ).animate(

      CurvedAnimation(

        parent:
            _animationController,

        curve:
            Curves.easeOut,
      ),
    );

    _animationController
        .forward();
  }

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

    if (!mounted) {
      return;
    }

    // ===================================================
    // LOGIN SUCCESS
    // ===================================================

    if (success) {

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(

        SnackBar(

          backgroundColor:
              Colors.green,

          behavior:
              SnackBarBehavior
                  .floating,

          shape:
              RoundedRectangleBorder(

            borderRadius:
                BorderRadius.circular(
              16,
            ),
          ),

          content: const Text(
            'Login success',
          ),
        ),
      );

      // ===============================================
      // ADMIN LOGIN
      // ===============================================

      if (authProvider.role ==
          'admin') {

        Navigator.of(context)
            .pushAndRemoveUntil(

          MaterialPageRoute(

            builder:
                (
                  context,
                ) {

              return AdminDashboardScreen();
            },
          ),

          (
            route,
          ) {

            return false;
          },
        );
      }

      // ===============================================
      // USER LOGIN
      // ===============================================

      else {

        Navigator.of(context)
            .pushAndRemoveUntil(

          MaterialPageRoute(

            builder:
                (
                  context,
                ) {

              return const UserHomeScreen();
            },
          ),

          (
            route,
          ) {

            return false;
          },
        );
      }
    }

    // ===================================================
    // LOGIN FAILED
    // ===================================================

    else {

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(

        SnackBar(

          backgroundColor:
              Colors.red,

          behavior:
              SnackBarBehavior
                  .floating,

          shape:
              RoundedRectangleBorder(

            borderRadius:
                BorderRadius.circular(
              16,
            ),
          ),

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
              28,
            ),
          ),

          title: const Text(
            'Reset Password',
          ),

          content:
              Column(

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
                    InputDecoration(

                  labelText:
                      'Email',

                  prefixIcon:
                      const Icon(
                    Icons.email,
                  ),

                  filled: true,

                  fillColor:
                      const Color(
                    0xffF8FAFC,
                  ),

                  border:
                      OutlineInputBorder(

                    borderRadius:
                        BorderRadius.circular(
                      18,
                    ),

                    borderSide:
                        BorderSide.none,
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

              style:
                  ElevatedButton.styleFrom(

                backgroundColor:
                    Colors.blue,
              ),

              onPressed:
                  () async {

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

                if (!mounted) {
                  return;
                }

                Navigator.pop(
                  context,
                );

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(

                  SnackBar(

                    backgroundColor:

                        success

                            ? Colors
                                .green

                            : Colors
                                .red,

                    behavior:
                        SnackBarBehavior
                            .floating,

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

                style: TextStyle(
                  color:
                      Colors.white,
                ),
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

    final width =
        MediaQuery.of(
          context,
        ).size.width;

    return Scaffold(

      body: Container(

        width: double.infinity,

        height: double.infinity,

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

          child: Center(

            child:
                SingleChildScrollView(

              padding:
                  const EdgeInsets.all(
                24,
              ),

              child:
                  FadeTransition(

                opacity:
                    _fadeAnimation,

                child:
                    SlideTransition(

                  position:
                      _slideAnimation,

                  child:
                      Container(

                    width:

                        width < 500

                            ? double.infinity

                            : 450,

                    padding:
                        const EdgeInsets.all(
                      34,
                    ),

                    decoration:
                        BoxDecoration(

                      color:
                          Colors.white,

                      borderRadius:
                          BorderRadius.circular(
                        34,
                      ),

                      boxShadow: [

                        BoxShadow(

                          color:
                              Colors.black
                                  .withOpacity(
                            0.08,
                          ),

                          blurRadius:
                              30,

                          offset:
                              const Offset(
                            0,
                            15,
                          ),
                        ),
                      ],
                    ),

                    child: Form(

                      key: _formKey,

                      child: Column(
                        mainAxisSize:
                            MainAxisSize.min,

                        children: [

                          Container(

                            width: 120,

                            height: 120,

                            decoration:
                                BoxDecoration(

                              borderRadius:
                                  BorderRadius.circular(
                                30,
                              ),

                              gradient:
                                  LinearGradient(

                                colors: [

                                  Colors.blue
                                      .withOpacity(
                                    0.1,
                                  ),

                                  Colors.purple
                                      .withOpacity(
                                    0.1,
                                  ),
                                ],
                              ),
                            ),

                            child:
                                Padding(

                              padding:
                                  const EdgeInsets.all(
                                18,
                              ),

                              child:
                                  Image.asset(
                                'assets/images/tokomiring.png',
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 28,
                          ),

                          const Text(

                            'Welcome Back',

                            textAlign:
                                TextAlign
                                    .center,

                            style:
                                TextStyle(

                              fontSize: 34,

                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          Text(

                            'Login to continue your journey.',

                            textAlign:
                                TextAlign
                                    .center,

                            style:
                                TextStyle(

                              color:
                                  Colors.grey
                                      .shade600,

                              fontSize: 15,
                            ),
                          ),

                          const SizedBox(
                            height: 36,
                          ),

                          TextFormField(

                            controller:
                                emailController,

                            keyboardType:
                                TextInputType
                                    .emailAddress,

                            decoration:
                                InputDecoration(

                              labelText:
                                  'Email',

                              prefixIcon:
                                  const Icon(
                                Icons.email,
                              ),

                              filled: true,

                              fillColor:
                                  const Color(
                                0xffF8FAFC,
                              ),

                              border:
                                  OutlineInputBorder(

                                borderRadius:
                                    BorderRadius.circular(
                                  18,
                                ),

                                borderSide:
                                    BorderSide.none,
                              ),
                            ),

                            validator:
                                (
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
                            height: 22,
                          ),

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

                                onPressed:
                                    () {

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

                              filled: true,

                              fillColor:
                                  const Color(
                                0xffF8FAFC,
                              ),

                              border:
                                  OutlineInputBorder(

                                borderRadius:
                                    BorderRadius.circular(
                                  18,
                                ),

                                borderSide:
                                    BorderSide.none,
                              ),
                            ),

                            validator:
                                (
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

                          SizedBox(

                            width:
                                double.infinity,

                            height: 58,

                            child:
                                ElevatedButton(

                              style:
                                  ElevatedButton.styleFrom(

                                backgroundColor:
                                    Colors.blue,

                                shape:
                                    RoundedRectangleBorder(

                                  borderRadius:
                                      BorderRadius.circular(
                                    18,
                                  ),
                                ),
                              ),

                              onPressed:

                                  authProvider
                                          .isLoading

                                      ? null

                                      : login,

                              child:

                                  authProvider
                                          .isLoading

                                      ? const SizedBox(

                                          width:
                                              24,

                                          height:
                                              24,

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

                                          style:
                                              TextStyle(

                                            color:
                                                Colors.white,

                                            fontSize:
                                                16,

                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .center,

                            children: [

                              Text(

                                'Don’t have an account?',

                                style:
                                    TextStyle(

                                  color:
                                      Colors.grey
                                          .shade600,
                                ),
                              ),

                              TextButton(

                                onPressed:
                                    () {

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
                        ],
                      ),
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

    _animationController
        .dispose();

    emailController.dispose();

    passwordController.dispose();

    super.dispose();
  }
}