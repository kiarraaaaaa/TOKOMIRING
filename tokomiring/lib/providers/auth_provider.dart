// =====================================================
// lib/providers/auth_provider.dart
// REALTIME STABLE VERSION
// =====================================================

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider
    extends ChangeNotifier {

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

  String? _errorMessage;

  StreamSubscription?
      _userSubscription;

  bool _isRefreshing =
      false;

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

  // =====================================================
  // INIT AUTH
  // =====================================================

  Future<void> initializeAuth()
      async {

    try {

      _setLoading(true);

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

          notifyListeners();
        }

        // ===============================================
        // STABLE REALTIME LISTENER
        // ===============================================

        await _userSubscription
            ?.cancel();

        _userSubscription =

            FirebaseAuth
                .instance
                .userChanges()
                .listen((_) async {

          await refreshUser(
            silent: true,
          );
        });
      }

      else {

        _userModel =
            null;

        _isLoggedIn =
            false;

        notifyListeners();
      }

    } catch (e) {

      _errorMessage =
          'Failed to initialize auth';

      debugPrint(
        e.toString(),
      );

    } finally {

      _setLoading(false);
    }
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
            u.uid == user.uid,
      );

      if (index != -1) {

        _users[index] =
            user;

        notifyListeners();
      }

    } catch (e) {

      debugPrint(
        e.toString(),
      );
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

      debugPrint(
        e.toString(),
      );

      notifyListeners();

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

        return true;
      }

      _errorMessage =
          'Invalid email or password';

      notifyListeners();

      return false;

    } catch (e) {

      _errorMessage =
          e.toString();

      debugPrint(
        e.toString(),
      );

      notifyListeners();

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

    required String photoUrl,

  }) async {

    try {

      if (_userModel == null) {
        return false;
      }

      _setLoading(true);

      // ===============================================
      // UPDATE FIREBASE
      // ===============================================

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
            photoUrl,
      );

      // ===============================================
      // INSTANT LOCAL UPDATE
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
            photoUrl,
      );

      // ===============================================
      // INSTANT REALTIME UPDATE
      // ===============================================

      notifyListeners();

      // ===============================================
      // BACKGROUND REFRESH
      // ===============================================

      Future.microtask(() async {

        await refreshUser(
          silent: true,
        );
      });

      return true;

    } catch (e) {

      _errorMessage =
          e.toString();

      debugPrint(
        e.toString(),
      );

      notifyListeners();

      return false;

    } finally {

      _setLoading(false);
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

      debugPrint(
        e.toString(),
      );

      notifyListeners();

      return false;

    } finally {

      _setLoading(false);
    }
  }

  // =====================================================
  // LOGOUT
  // =====================================================

  Future<void> logout() async {

    try {

      _setLoading(true);

      await _userSubscription
          ?.cancel();

      await _authService
          .logout();

      _userModel =
          null;

      _isLoggedIn =
          false;

      _clearError();

      notifyListeners();

    } catch (e) {

      _errorMessage =
          e.toString();

      debugPrint(
        e.toString(),
      );

      notifyListeners();

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

      _userModel =
          null;

      _isLoggedIn =
          false;

      notifyListeners();

      return true;

    } catch (e) {

      _errorMessage =
          e.toString();

      debugPrint(
        e.toString(),
      );

      notifyListeners();

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

        final changed =

            userData.name !=
                    _userModel!.name ||

                userData.photoUrl !=
                    _userModel!
                        .photoUrl ||

                userData.username !=
                    _userModel!
                        .username ||

                userData.phone !=
                    _userModel!
                        .phone ||

                userData.address !=
                    _userModel!
                        .address;

        if (changed) {

          _userModel =
              userData;

          if (!silent) {

            notifyListeners();

          } else {

            WidgetsBinding
                .instance
                .addPostFrameCallback((_) {

              notifyListeners();
            });
          }
        }
      }

    } catch (e) {

      _errorMessage =
          e.toString();

      debugPrint(
        e.toString(),
      );

    } finally {

      _isRefreshing =
          false;
    }
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

  @override
  void dispose() {

    _userSubscription
        ?.cancel();

    super.dispose();
  }
}