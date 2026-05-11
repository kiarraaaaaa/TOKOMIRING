// lib/models/user_model.dart

class UserModel {

  final String uid;

  final String name;

  final String username;

  final String email;

  final String role;

  final String photoUrl;

  final String phone;

  final String address;

  final bool isActive;

  final DateTime createdAt;

  UserModel({

    required this.uid,

    required this.name,

    required this.username,

    required this.email,

    required this.role,

    required this.photoUrl,

    required this.phone,

    required this.address,

    required this.isActive,

    required this.createdAt,
  });

  // =====================================================
  // FROM MAP
  // =====================================================

  factory UserModel.fromMap(

    Map<dynamic, dynamic> map,

    String uid,

  ) {

    return UserModel(

      uid:
          uid,

      name:
          map['name'] ?? '',

      username:
          map['username'] ?? '',

      email:
          map['email'] ?? '',

      role:
          map['role'] ?? 'user',

      photoUrl:
          map['photoUrl'] ?? '',

      phone:
          map['phone'] ?? '',

      address:
          map['address'] ?? '',

      isActive:
          map['isActive'] ?? true,

      createdAt:
          DateTime.tryParse(
                map['createdAt']
                        ?.toString() ??
                    '',
              ) ??
              DateTime.now(),
    );
  }

  // =====================================================
  // TO MAP
  // =====================================================

  Map<String, dynamic> toMap() {

    return {

      'uid':
          uid,

      'name':
          name,

      'username':
          username,

      'email':
          email,

      'role':
          role,

      'photoUrl':
          photoUrl,

      'phone':
          phone,

      'address':
          address,

      'isActive':
          isActive,

      'createdAt':
          createdAt
              .toIso8601String(),
    };
  }

  // =====================================================
  // ROLE CHECK
  // =====================================================

  bool get isAdmin =>
      role == 'admin';

  bool get isUser =>
      role == 'user';

  // =====================================================
  // PROFILE CHECK
  // =====================================================

  bool get hasPhoto =>
      photoUrl.isNotEmpty;

  bool get hasPhone =>
      phone.isNotEmpty;

  bool get hasAddress =>
      address.isNotEmpty;

  // =====================================================
  // DISPLAY NAME
  // =====================================================

  String get displayName {

    if (name.isNotEmpty) {
      return name;
    }

    return username;
  }

  // =====================================================
  // COPY WITH
  // =====================================================

  UserModel copyWith({

    String? uid,

    String? name,

    String? username,

    String? email,

    String? role,

    String? photoUrl,

    String? phone,

    String? address,

    bool? isActive,

    DateTime? createdAt,

  }) {

    return UserModel(

      uid:
          uid ?? this.uid,

      name:
          name ?? this.name,

      username:
          username ?? this.username,

      email:
          email ?? this.email,

      role:
          role ?? this.role,

      photoUrl:
          photoUrl ?? this.photoUrl,

      phone:
          phone ?? this.phone,

      address:
          address ?? this.address,

      isActive:
          isActive ?? this.isActive,

      createdAt:
          createdAt ??
              this.createdAt,
    );
  }
}