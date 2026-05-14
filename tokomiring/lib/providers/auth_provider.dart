 // =====================================================
// lib/providers/auth_provider.dart
// PREMIUM REALTIME VERSION
// =====================================================

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider
    extends ChangeNotifier {
  // =====================================================
  // SERVICES
  // =====================================================

  final AuthService
      _authService =
      AuthService();

  // =====================================================
  // VARIABLES
  // =====================================================

  UserModel? _userModel;

  List<UserModel> _users = [];

  bool _isLoading = false;

  bool _isLoggedIn = false;

  bool _isInitialized = false;

  bool _isRefreshing =
      false;

  String? _errorMessage;

  StreamSubscription?
      _userSubscription;

  StreamSubscription?
      _authSubscription;

  // =====================================================
  // GETTERS
  // =====================================================

  UserModel? get user =>
      _userModel;

  List<UserModel> get users =>
      _users;

  bool get isLoading =>
      _isLoading;

  bool get isLoggedIn =>
      _isLoggedIn;

  bool get isInitialized =>
      _isInitialized;

  String? get errorMessage =>
      _errorMessage;

  String get role =>
      _userModel?.role ??
      'user';

  bool get isAdmin =>
      _userModel?.role ==
      'admin';

  bool get isUser =>
      _userModel?.role ==
      'user';

  String get username =>
      _userModel?.username ??
      '';

  String get email =>
      _userModel?.email ??
      '';

  String get address =>
      _userModel?.address ??
      '';

  String get phone =>
      _userModel?.phone ??
      '';

  String get photoUrl =>
      _userModel?.safePhotoUrl ??
      '';

  String get displayName =>
      _userModel?.displayName ??
      'Member';

  String get roleLabel =>
      _userModel?.roleLabel ??
      'Member';

  bool get isVerified =>
      _userModel?.isVerified ??
      false;

  int get profileCompletion =>
      _userModel
          ?.profileCompletionPercent ??
      0;

  // =====================================================
  // INITIALIZE AUTH
  // =====================================================

  Future<void> initializeAuth()
      async {
    try {
      _setLoading(true);

      await _authSubscription
          ?.cancel();

      // ===============================================
      // REALTIME AUTH LISTENER
      // ===============================================

      _authSubscription =
          FirebaseAuth
              .instance
              .authStateChanges()
              .listen(
        (firebaseUser) async {
          if (firebaseUser == null) {
            _clearUser();
            return;
          }

          final userData =
              await _authService
                  .getUserData(
            firebaseUser.uid,
          );

          if (userData != null) {
            _userModel =
                userData;

            _isLoggedIn =
                true;

            notifyListeners();

            await _listenUserRealtime(
              firebaseUser.uid,
            );
          }
        },
      );

      final currentUser =
          FirebaseAuth
              .instance
              .currentUser;

      if (currentUser != null) {
        final userData =
            await _authService
                .getUserData(
          currentUser.uid,
        );

        if (userData != null) {
          _userModel =
              userData;

          _isLoggedIn =
              true;
        }
      }

      _isInitialized =
          true;

      notifyListeners();
    } catch (e) {
      _errorMessage =
          e.toString();

      debugPrint(
        e.toString(),
      );
    } finally {
      _setLoading(false);
    }
  }

  // =====================================================
  // REALTIME USER LISTENER
  // =====================================================

  Future<void>
      _listenUserRealtime(
    String uid,
  ) async {
    await _userSubscription
        ?.cancel();

    _userSubscription =
        _authService
            .userStream(uid)
            .listen(
      (event) {
        try {
          final data =
              event.snapshot.value;

          if (data == null) {
            return;
          }

          final userMap =
              Map<dynamic, dynamic>.from(
            data as Map,
          );

          final updatedUser =
              UserModel.fromMap(
            userMap,
            uid,
          );

          final hasChanges =
              _userModel == null ||

                  updatedUser.name !=
                      _userModel!.name ||

                  updatedUser.username !=
                      _userModel!
                          .username ||

                  updatedUser.phone !=
                      _userModel!
                          .phone ||

                  updatedUser.address !=
                      _userModel!
                          .address ||

                  updatedUser.photoUrl !=
                      _userModel!
                          .photoUrl ||

                  updatedUser.role !=
                      _userModel!
                          .role ||

                  updatedUser.isActive !=
                      _userModel!
                          .isActive;

          if (hasChanges) {
            _userModel =
                updatedUser;

            notifyListeners();
          }
        } catch (e) {
          debugPrint(
            e.toString(),
          );
        }
      },
    );
  }

  // =====================================================
  // LOAD USERS
  // =====================================================

  Future<void> loadUsers()
      async {
    try {
      _setLoading(true);

      final result =
          await _authService
              .getAllUsers();

      _users = result;

      notifyListeners();
    } catch (e) {
      debugPrint(
        e.toString(),
      );
    } finally {
      _setLoading(false);
    }
  }

  // =====================================================
  // REGISTER
  // =====================================================

  Future<bool> register({
    required String name,
    required String username,
    required String email,
    required String password,
    String role = 'user',
  }) async {
    try {
      _setLoading(true);

      _clearError();

      final result =
          await _authService
              .register(
        name:
            name.trim(),
        username:
            username.trim(),
        email:
            email.trim(),
        password:
            password.trim(),
        role:
            role,
      );

      if (result != null) {
        _userModel =
            result;

        _isLoggedIn =
            true;

        notifyListeners();

        return true;
      }

      return false;
    } catch (e) {
      _errorMessage =
          e.toString();

      notifyListeners();

      debugPrint(
        e.toString(),
      );

      return false;
    } finally {
      _setLoading(false);
    }
  }

  // =====================================================
  // LOGIN
  // =====================================================

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      _setLoading(true);

      _clearError();

      final result =
          await _authService
              .login(
        email:
            email.trim(),
        password:
            password.trim(),
      );

      if (result != null) {
        _userModel =
            result;

        _isLoggedIn =
            true;

        notifyListeners();

        await _listenUserRealtime(
          result.uid,
        );

        return true;
      }

      _errorMessage =
          'Invalid email or password';

      notifyListeners();

      return false;
    } catch (e) {
      _errorMessage =
          e.toString();

      notifyListeners();

      debugPrint(
        e.toString(),
      );

      return false;
    } finally {
      _setLoading(false);
    }
  }

  // =====================================================
  // UPDATE PROFILE
  // =====================================================

  Future<bool> updateProfile({
    required String name,
    required String username,
    required String phone,
    required String address,
    required String photoBase64,
  }) async {
    try {
      if (_userModel == null) {
        return false;
      }

      _setLoading(true);

      await _authService
          .updateProfile(
        uid:
            _userModel!.uid,
        name:
            name.trim(),
        username:
            username.trim(),
        phone:
            phone.trim(),
        address:
            address.trim(),
        photoUrl:
            photoBase64.trim(),
      );

      // ===============================================
      // LOCAL INSTANT UPDATE
      // ===============================================

      _userModel =
          _userModel!.copyWith(
        name:
            name.trim(),
        username:
            username.trim(),
        phone:
            phone.trim(),
        address:
            address.trim(),
        photoUrl:
            photoBase64.trim(),
        updatedAt:
            DateTime.now(),
      );

      notifyListeners();

      // ===============================================
      // BACKGROUND REFRESH
      // ===============================================

      Future.microtask(
        () async {
          await refreshUser(
            silent: true,
          );
        },
      );

      return true;
    } catch (e) {
      _errorMessage =
          e.toString();

      notifyListeners();

      debugPrint(
        e.toString(),
      );

      return false;
    } finally {
      _setLoading(false);
    }
  }

  // =====================================================
  // UPDATE ADDRESS
  // =====================================================

  Future<void> updateAddress(
    String address,
  ) async {
    try {
      if (_userModel == null) {
        return;
      }

      await _authService
          .updateAddress(
        uid:
            _userModel!.uid,
        address:
            address.trim(),
      );

      _userModel =
          _userModel!.copyWith(
        address:
            address.trim(),
        updatedAt:
            DateTime.now(),
      );

      notifyListeners();
    } catch (e) {
      debugPrint(
        e.toString(),
      );
    }
  }

  // =====================================================
  // UPDATE PHONE
  // =====================================================

  Future<void> updatePhone(
    String phone,
  ) async {
    try {
      if (_userModel == null) {
        return;
      }

      await _authService
          .updatePhone(
        uid:
            _userModel!.uid,
        phone:
            phone.trim(),
      );

      _userModel =
          _userModel!.copyWith(
        phone:
            phone.trim(),
        updatedAt:
            DateTime.now(),
      );

      notifyListeners();
    } catch (e) {
      debugPrint(
        e.toString(),
      );
    }
  }

  // =====================================================
  // UPDATE USER
  // =====================================================

  Future<void> updateUser(
    UserModel user,
  ) async {
    try {
      await _authService
          .updateUser(
        user,
      );

      final index =
          _users.indexWhere(
        (u) =>
            u.uid ==
            user.uid,
      );

      if (index != -1) {
        _users[index] =
            user;
      }

      if (_userModel != null &&
          _userModel!.uid ==
              user.uid) {
        _userModel =
            user;
      }

      notifyListeners();
    } catch (e) {
      debugPrint(
        e.toString(),
      );
    }
  }

  // =====================================================
  // RESET PASSWORD
  // =====================================================

  Future<bool> resetPassword(
    String email,
  ) async {
    try {
      _setLoading(true);

      _clearError();

      await _authService
          .resetPassword(
        email.trim(),
      );

      return true;
    } catch (e) {
      _errorMessage =
          e.toString();

      notifyListeners();

      debugPrint(
        e.toString(),
      );

      return false;
    } finally {
      _setLoading(false);
    }
  }

  // =====================================================
  // LOGOUT
  // =====================================================

  Future<void> logout()
      async {
    try {
      _setLoading(true);

      await _userSubscription
          ?.cancel();

      await _authSubscription
          ?.cancel();

      await _authService
          .logout();

      _clearUser();
    } catch (e) {
      _errorMessage =
          e.toString();

      notifyListeners();

      debugPrint(
        e.toString(),
      );
    } finally {
      _setLoading(false);
    }
  }

  // =====================================================
  // DELETE ACCOUNT
  // =====================================================

  Future<bool> deleteAccount()
      async {
    try {
      if (_userModel == null) {
        return false;
      }

      _setLoading(true);

      await _authService
          .deleteAccount(
        _userModel!.uid,
      );

      _clearUser();

      return true;
    } catch (e) {
      _errorMessage =
          e.toString();

      notifyListeners();

      debugPrint(
        e.toString(),
      );

      return false;
    } finally {
      _setLoading(false);
    }
  }

  // =====================================================
  // REFRESH USER
  // =====================================================

  Future<void> refreshUser({
    bool silent = false,
  }) async {
    try {
      if (_userModel == null) {
        return;
      }

      if (_isRefreshing) {
        return;
      }

      _isRefreshing =
          true;

      final userData =
          await _authService
              .getUserData(
        _userModel!.uid,
      );

      if (userData != null) {
        _userModel =
            userData;

        if (!silent) {
          notifyListeners();
        } else {
          WidgetsBinding
              .instance
              .addPostFrameCallback(
            (_) {
              notifyListeners();
            },
          );
        }
      }
    } catch (e) {
      debugPrint(
        e.toString(),
      );
    } finally {
      _isRefreshing =
          false;
    }
  }

  // =====================================================
  // CLEAR USER
  // =====================================================

  void _clearUser() {
    _userModel =
        null;

    _isLoggedIn =
        false;

    _clearError();

    notifyListeners();
  }

  // =====================================================
  // PRIVATE HELPERS
  // =====================================================

  void _setLoading(
    bool value,
  ) {
    _isLoading =
        value;

    notifyListeners();
  }

  void _clearError() {
    _errorMessage =
        null;
  }

  // =====================================================
  // DISPOSE
  // =====================================================

  @override
  void dispose() {
    _userSubscription
        ?.cancel();

    _authSubscription
        ?.cancel();

    super.dispose();
  }
}