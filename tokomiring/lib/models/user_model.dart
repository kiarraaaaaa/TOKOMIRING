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
          map['name']
                  ?.toString() ??
              '',

      username:
          map['username']
                  ?.toString() ??
              '',

      email:
          map['email']
                  ?.toString() ??
              '',

      role:
          map['role']
                  ?.toString() ??
              'user',

      photoUrl:
          map['photoUrl']
                  ?.toString() ??
              '',

      phone:
          map['phone']
                  ?.toString() ??
              '',

      address:
          map['address']
                  ?.toString() ??
              '',

      isActive:
          map['isActive'] ??
              true,

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
          name.trim(),

      'username':
          username.trim(),

      'email':
          email.trim(),

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

      photoUrl
          .trim()
          .isNotEmpty;

  bool get hasPhone =>

      phone
          .trim()
          .isNotEmpty;

  bool get hasAddress =>

      address
          .trim()
          .isNotEmpty;

  // =====================================================
  // DISPLAY NAME REALTIME
  // =====================================================

  String get displayName {

    final cleanName =
        name.trim();

    final cleanUsername =
        username.trim();

    if (cleanName
        .isNotEmpty) {

      return cleanName;
    }

    if (cleanUsername
        .isNotEmpty) {

      return cleanUsername;
    }

    return 'Administrator';
  }

  // =====================================================
  // PHOTO REALTIME
  // =====================================================

  String get safePhotoUrl {

    final cleanPhoto =
        photoUrl.trim();

    if (cleanPhoto
        .isEmpty) {

      return '';
    }

    return cleanPhoto;
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
          username ??
              this.username,

      email:
          email ?? this.email,

      role:
          role ?? this.role,

      photoUrl:
          photoUrl ??
              this.photoUrl,

      phone:
          phone ?? this.phone,

      address:
          address ??
              this.address,

      isActive:
          isActive ??
              this.isActive,

      createdAt:
          createdAt ??
              this.createdAt,
    );
  }

  // =====================================================
  // EQUALITY
  // =====================================================

  @override
  bool operator ==(
    Object other,
  ) {

    if (identical(
      this,
      other,
    )) {

      return true;
    }

    return other is UserModel &&

        other.uid == uid &&

        other.name == name &&

        other.username ==
            username &&

        other.email == email &&

        other.role == role &&

        other.photoUrl ==
            photoUrl &&

        other.phone == phone &&

        other.address ==
            address &&

        other.isActive ==
            isActive;
  }

  @override
  int get hashCode {

    return uid.hashCode ^

        name.hashCode ^

        username.hashCode ^

        email.hashCode ^

        role.hashCode ^

        photoUrl.hashCode ^

        phone.hashCode ^

        address.hashCode ^

        isActive.hashCode;
  }
}