// lib/services/auth_service.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  final DatabaseReference _database =
      FirebaseDatabase.instance.ref();

  // =====================================================
  // CURRENT USER
  // =====================================================

  User? get currentUser =>
      _auth.currentUser;

  // =====================================================
  // AUTH STATE
  // =====================================================

  Stream<User?> get authStateChanges =>
      _auth.authStateChanges();

  // =====================================================
  // REGISTER
  // =====================================================

  Future<UserModel?> register({
    required String name,
    required String username,
    required String email,
    required String password,
    String role = 'user',
  }) async {
    try {
      // CREATE FIREBASE AUTH
      final credential =
          await _auth
              .createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final user = credential.user;

      if (user == null) {
        return null;
      }

      // UPDATE DISPLAY NAME
      await user.updateDisplayName(name);

      // CREATE USER MODEL
      final userModel = UserModel(
        uid: user.uid,

        name: name.trim(),

        username: username.trim(),

        email: email.trim(),

        role: role,

        photoUrl: '',

        phone: '',

        address: '',

        isActive: true,

        createdAt: DateTime.now(),
      );

      // SAVE TO REALTIME DATABASE
      await _database
          .child('users')
          .child(user.uid)
          .set(
            userModel.toMap(),
          );

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw Exception(
        e.message ??
            'Register failed',
      );
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  // =====================================================
  // LOGIN
  // =====================================================

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential =
          await _auth
              .signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final user = credential.user;

      if (user == null) {
        return null;
      }

      final snapshot =
          await _database
              .child('users')
              .child(user.uid)
              .get();

      if (!snapshot.exists) {
        return null;
      }

      final data =
          Map<dynamic, dynamic>.from(
        snapshot.value as dynamic,
      );

      return UserModel.fromMap(
        data,
        user.uid,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(
        e.message ??
            'Login failed',
      );
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  // =====================================================
  // GET USER DATA
  // =====================================================

  Future<UserModel?> getUserData(
    String uid,
  ) async {
    try {
      final snapshot =
          await _database
              .child('users')
              .child(uid)
              .get();

      if (!snapshot.exists) {
        return null;
      }

      final data =
          Map<dynamic, dynamic>.from(
        snapshot.value as dynamic,
      );

      return UserModel.fromMap(
        data,
        uid,
      );
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  // =====================================================
  // UPDATE PROFILE
  // =====================================================

  Future<void> updateProfile({
    required String uid,
    required String name,
    required String username,
    required String phone,
    required String address,
    required String photoUrl,
  }) async {
    try {
      await _database
          .child('users')
          .child(uid)
          .update({
        'name': name,

        'username': username,

        'phone': phone,

        'address': address,

        'photoUrl': photoUrl,
      });

      await _auth.currentUser
          ?.updateDisplayName(name);
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  // =====================================================
  // RESET PASSWORD
  // =====================================================

  Future<void> resetPassword(
    String email,
  ) async {
    try {
      await _auth
          .sendPasswordResetEmail(
        email: email.trim(),
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(
        e.message ??
            'Reset password failed',
      );
    }
  }

  // =====================================================
  // LOGOUT
  // =====================================================

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  // =====================================================
  // DELETE ACCOUNT
  // =====================================================

  Future<void> deleteAccount(
    String uid,
  ) async {
    try {
      // DELETE DATABASE USER
      await _database
          .child('users')
          .child(uid)
          .remove();

      // DELETE AUTH USER
      await _auth.currentUser
          ?.delete();
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  // =====================================================
  // CHECK ADMIN
  // =====================================================

  Future<bool> isAdmin(
    String uid,
  ) async {
    try {
      final snapshot =
          await _database
              .child('users')
              .child(uid)
              .get();

      if (!snapshot.exists) {
        return false;
      }

      final data =
          Map<dynamic, dynamic>.from(
        snapshot.value as dynamic,
      );

      return data['role'] == 'admin';
    } catch (e) {
      return false;
    }
  }

  // =====================================================
  // CREATE DEFAULT ADMIN
  // =====================================================

  Future<void> createDefaultAdmin() async {
    try {
      const adminEmail =
          'admin@tokomiring.com';

      const adminPassword =
          'admin123';

      final methods =
          await _auth
              .fetchSignInMethodsForEmail(
        adminEmail,
      );

      if (methods.isEmpty) {
        await register(
          name: 'Administrator',

          username: 'admin',

          email: adminEmail,

          password: adminPassword,

          role: 'admin',
        );
      }
    } catch (_) {}
  }
}