import 'dart:typed_data';
import 'dart:convert';

import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class AdminProfileScreen
    extends StatefulWidget {

  const AdminProfileScreen({
    super.key,
  });

  @override
  State<AdminProfileScreen>
      createState() =>
          _AdminProfileScreenState();
}

class _AdminProfileScreenState
    extends State<AdminProfileScreen> {

  late TextEditingController
      nameController;

  late TextEditingController
      usernameController;

  Uint8List? selectedImage;

  String? base64Photo;

  bool isSaving = false;

  @override
  void initState() {

    super.initState();

    final user =
        context
            .read<AuthProvider>()
            .user;

    base64Photo =
        user?.photoUrl;

    nameController =
        TextEditingController(

      text:
          user?.name ?? '',
    );

    usernameController =
        TextEditingController(

      text:
          user?.username ?? '',
    );
  }

  @override
  void dispose() {

    nameController.dispose();

    usernameController.dispose();

    super.dispose();
  }

  // =====================================================
  // PICK IMAGE
  // =====================================================

  Future<void> pickImage()
      async {

    final result =
        await FilePicker.platform
            .pickFiles(

      type:
          FileType.image,

      withData: true,
    );

    if (result == null ||
        result.files.isEmpty) {
      return;
    }

    final file =
        result.files.first;

    if (file.bytes == null) {
      return;
    }

    setState(() {

      selectedImage =
          file.bytes;

      base64Photo =
          base64Encode(
        file.bytes!,
      );
    });
  }

  // =====================================================
  // FORCE REALTIME REFRESH
  // =====================================================

  Future<void>
      forceRefreshSidebar()
      async {

    final authProvider =
        context.read<AuthProvider>();

    await authProvider
        .refreshUser();

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  // =====================================================
  // SAVE PROFILE
  // =====================================================

  Future<void> saveProfile()
      async {

    final authProvider =
        context.read<AuthProvider>();

    final currentUser =
        authProvider.user;

    if (currentUser == null) {
      return;
    }

    setState(() {

      isSaving = true;
    });

    try {

      // ===============================================
      // UPDATE PROFILE
      // ===============================================

      final success =
          await authProvider
              .updateProfile(

        name:
            nameController.text
                .trim(),

        username:
            usernameController
                .text
                .trim(),

        phone:
            currentUser.phone,

        address:
            currentUser.address,

        photoBase64:
            base64Photo ?? '',
      );

      if (!success) {
        return;
      }

      // ===============================================
      // FORCE REFRESH SIDEBAR
      // ===============================================

      await forceRefreshSidebar();

      if (!mounted) {
        return;
      }

      // ===============================================
      // UPDATE LOCAL UI
      // ===============================================

      final refreshedUser =
          authProvider.user;

      if (refreshedUser != null) {

        nameController.text =
            refreshedUser.name;

        usernameController
                .text =
            refreshedUser
                .username;

        base64Photo =
            refreshedUser
                .photoUrl;
      }

      setState(() {});

      // ===============================================
      // SUCCESS
      // ===============================================

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(

        const SnackBar(

          behavior:
              SnackBarBehavior
                  .floating,

          content: Text(
            'Profile updated successfully',
          ),
        ),
      );

    } catch (e) {

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(

        SnackBar(

          behavior:
              SnackBarBehavior
                  .floating,

          content: Text(
            e.toString(),
          ),
        ),
      );

    } finally {

      if (mounted) {

        setState(() {

          isSaving = false;
        });
      }
    }
  }

  // =====================================================
  // PROFILE IMAGE
  // =====================================================

  Widget profileImage() {

    // ===============================================
    // NEW PICKED IMAGE
    // ===============================================

    if (selectedImage != null) {

      return CircleAvatar(

        radius: 42,

        backgroundImage:
            MemoryImage(
          selectedImage!,
        ),
      );
    }

    // ===============================================
    // BASE64 IMAGE
    // ===============================================

    if (base64Photo != null &&
        base64Photo!.isNotEmpty) {

      try {

        final bytes =
            base64Decode(
          base64Photo!,
        );

        return CircleAvatar(

          radius: 42,

          backgroundImage:
              MemoryImage(
            bytes,
          ),
        );

      } catch (_) {}
    }

    // ===============================================
    // DEFAULT
    // ===============================================

    return CircleAvatar(

      radius: 42,

      backgroundColor:
          Colors.grey.shade200,

      child:
          const Icon(

        Icons.person,

        size: 38,

        color:
            Colors.grey,
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    final authProvider =
        context.watch<AuthProvider>();

    final user =
        authProvider.user;

    return Scaffold(

      backgroundColor:
          const Color(
        0xffF8FAFC,
      ),

      body:
          SingleChildScrollView(

        padding:
            const EdgeInsets.all(
          18,
        ),

        child: Center(

          child: ConstrainedBox(

            constraints:
                const BoxConstraints(
              maxWidth: 520,
            ),

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                const Text(

                  'Admin Profile',

                  style: TextStyle(

                    fontSize: 24,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 4,
                ),

                Text(

                  'Manage your account settings.',

                  style: TextStyle(

                    fontSize: 12,

                    color:
                        Colors.grey
                            .shade600,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                Container(

                  width:
                      double.infinity,

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
                      22,
                    ),

                    boxShadow: [

                      BoxShadow(

                        color:
                            Colors.black
                                .withOpacity(
                          0.02,
                        ),

                        blurRadius:
                            10,

                        offset:
                            const Offset(
                          0,
                          4,
                        ),
                      ),
                    ],
                  ),

                  child: Column(

                    children: [

                      // =================================
                      // PROFILE IMAGE
                      // =================================

                      Stack(

                        children: [

                          profileImage(),

                          Positioned(

                            bottom: 0,

                            right: 0,

                            child: GestureDetector(

                              onTap:
                                  pickImage,

                              child: Container(

                                width: 28,

                                height: 28,

                                decoration:
                                    const BoxDecoration(

                                  color:
                                      Colors.blue,

                                  shape:
                                      BoxShape.circle,
                                ),

                                child:
                                    const Icon(

                                  Icons.edit,

                                  size: 15,

                                  color:
                                      Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 14,
                      ),

                      Text(

                        user?.name ??
                            'Administrator',

                        textAlign:
                            TextAlign.center,

                        style:
                            const TextStyle(

                          fontSize: 20,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 4,
                      ),

                      Text(

                        user?.email ?? '',

                        textAlign:
                            TextAlign.center,

                        style:
                            TextStyle(

                          fontSize: 12,

                          color:
                              Colors.grey
                                  .shade600,
                        ),
                      ),

                      const SizedBox(
                        height: 24,
                      ),

                      // =================================
                      // NAME
                      // =================================

                      TextField(

                        controller:
                            nameController,

                        style:
                            const TextStyle(
                          fontSize: 13,
                        ),

                        decoration:
                            InputDecoration(

                          labelText:
                              'Full Name',

                          labelStyle:
                              const TextStyle(
                            fontSize: 12,
                          ),

                          contentPadding:
                              const EdgeInsets.symmetric(

                            horizontal:
                                14,

                            vertical:
                                14,
                          ),

                          border:
                              OutlineInputBorder(

                            borderRadius:
                                BorderRadius.circular(
                              14,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 14,
                      ),

                      // =================================
                      // USERNAME
                      // =================================

                      TextField(

                        controller:
                            usernameController,

                        style:
                            const TextStyle(
                          fontSize: 13,
                        ),

                        decoration:
                            InputDecoration(

                          labelText:
                              'Username',

                          labelStyle:
                              const TextStyle(
                            fontSize: 12,
                          ),

                          contentPadding:
                              const EdgeInsets.symmetric(

                            horizontal:
                                14,

                            vertical:
                                14,
                          ),

                          border:
                              OutlineInputBorder(

                            borderRadius:
                                BorderRadius.circular(
                              14,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 22,
                      ),

                      // =================================
                      // SAVE BUTTON
                      // =================================

                      SizedBox(

                        width:
                            double.infinity,

                        height: 46,

                        child:
                            ElevatedButton(

                          style:
                              ElevatedButton.styleFrom(

                            shape:
                                RoundedRectangleBorder(

                              borderRadius:
                                  BorderRadius.circular(
                                14,
                              ),
                            ),
                          ),

                          onPressed:
                              isSaving

                                  ? null

                                  : saveProfile,

                          child:

                              isSaving

                                  ? const SizedBox(

                                      width:
                                          18,

                                      height:
                                          18,

                                      child:
                                          CircularProgressIndicator(
                                        strokeWidth:
                                            2,
                                        color:
                                            Colors.white,
                                      ),
                                    )

                                  : const Text(

                                      'Save Changes',

                                      style:
                                          TextStyle(
                                        fontSize:
                                            13,
                                      ),
                                    ),
                        ),
                      ),

                      const SizedBox(
                        height: 12,
                      ),

                      // =================================
                      // LOGOUT
                      // =================================

                      SizedBox(

                        width:
                            double.infinity,

                        height: 46,

                        child:
                            OutlinedButton(

                          style:
                              OutlinedButton.styleFrom(

                            shape:
                                RoundedRectangleBorder(

                              borderRadius:
                                  BorderRadius.circular(
                                14,
                              ),
                            ),
                          ),

                          onPressed: () async {

                            await context
                                .read<AuthProvider>()
                                .logout();

                            if (!context
                                .mounted) {
                              return;
                            }

                            Navigator.pushNamedAndRemoveUntil(

                              context,

                              '/welcome',

                              (route) => false,
                            );
                          },

                          child:
                              const Text(

                            'Logout',

                            style:
                                TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}