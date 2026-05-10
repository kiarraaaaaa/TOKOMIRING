// lib/screens/auth/signup_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() =>
      _SignupScreenState();
}

class _SignupScreenState
    extends State<SignupScreen> {
  final nameController =
      TextEditingController();

  final usernameController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  String _selectedRole = 'user';

  @override
  Widget build(BuildContext context) {
    final authProvider =
        Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 450,
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min,
                  children: [
                    const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 30),

                    TextField(
                      controller:
                          nameController,
                      decoration:
                          const InputDecoration(
                        labelText:
                            'Full Name',
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller:
                          usernameController,
                      decoration:
                          const InputDecoration(
                        labelText:
                            'Username',
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller:
                          emailController,
                      decoration:
                          const InputDecoration(
                        labelText: 'Email',
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller:
                          passwordController,
                      obscureText: true,
                      decoration:
                          const InputDecoration(
                        labelText:
                            'Password',
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Select Role:',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text('User'),
                            value: 'user',
                            groupValue: _selectedRole,
                            onChanged: (value) {
                              setState(() {
                                _selectedRole = value!;
                              });
                            },
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text('Admin'),
                            value: 'admin',
                            groupValue: _selectedRole,
                            onChanged: (value) {
                              setState(() {
                                _selectedRole = value!;
                              });
                            },
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: authProvider.isLoading
                            ? null
                            : () async {
                                bool success =
                                    await authProvider
                                        .register(
                                  name:
                                      nameController
                                          .text,
                                  username:
                                      usernameController
                                          .text,
                                  email:
                                      emailController
                                          .text,
                                  password:
                                      passwordController
                                          .text,
                                  role:
                                      _selectedRole,
                                );

                                if (success) {
                                  if (mounted) {
                                    Navigator
                                        .pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            const LoginScreen(),
                                      ),
                                    );
                                  }
                                } else {
                                  if (mounted) {
                                    ScaffoldMessenger
                                        .of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          authProvider
                                                  .errorMessage ??
                                              'Registration failed',
                                        ),
                                        backgroundColor:
                                            Colors.red,
                                      ),
                                    );
                                  }
                                }
                              },
                        child:
                            authProvider
                                    .isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child:
                                        CircularProgressIndicator(
                                      strokeWidth:
                                          2,
                                      valueColor:
                                          AlwaysStoppedAnimation<
                                              Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : const Text(
                                    'Sign Up',
                                  ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    TextButton(
                      onPressed: () {
                        Navigator
                            .pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const LoginScreen(),
                          ),
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
