 // lib/models/user_model.dart

class UserModel {
  // =====================================================
  // BASIC INFO
  // =====================================================

  final String uid;
  final String name;
  final String username;
  final String email;

  // =====================================================
  // ROLE
  // =====================================================

  final String role;

  // =====================================================
  // PROFILE
  // =====================================================

  // BASE64 IMAGE
  // FIELD TETAP photoUrl
  // BIAR GA ERROR DI FILE LAIN

  final String photoUrl;

  final String phone;
  final String address;

  // =====================================================
  // STATUS
  // =====================================================

  final bool isActive;

  // =====================================================
  // TIMESTAMP
  // =====================================================

  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? lastLogin;

  // =====================================================
  // CONSTRUCTOR
  // =====================================================

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
    this.updatedAt,
    this.lastLogin,
  });

  // =====================================================
  // FROM MAP
  // =====================================================

  factory UserModel.fromMap(
    Map<dynamic, dynamic> map,
    String uid,
  ) {
    return UserModel(
      uid: uid,

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

      // ===============================================
      // BASE64 IMAGE
      // ===============================================

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

      // ===============================================
      // CREATED AT
      // ===============================================

      createdAt:
          _parseDate(
        map['createdAt'],
      ),

      // ===============================================
      // UPDATED AT
      // ===============================================

      updatedAt:
          map['updatedAt'] !=
                  null
              ? _parseDate(
                  map['updatedAt'],
                )
              : null,

      // ===============================================
      // LAST LOGIN
      // ===============================================

      lastLogin:
          map['lastLogin'] !=
                  null
              ? _parseDate(
                  map['lastLogin'],
                )
              : null,
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

      // ===============================================
      // BASE64 IMAGE
      // ===============================================

      'photoUrl':
          photoUrl.trim(),

      'phone':
          phone.trim(),

      'address':
          address.trim(),

      'isActive':
          isActive,

      'createdAt':
          createdAt
              .toIso8601String(),

      'updatedAt':
          updatedAt
              ?.toIso8601String(),

      'lastLogin':
          lastLogin
              ?.toIso8601String(),
    };
  }

  // =====================================================
  // ROLE CHECK
  // =====================================================

  bool get isAdmin =>
      role.toLowerCase() ==
      'admin';

  bool get isUser =>
      role.toLowerCase() ==
      'user';

  bool get isMember =>
      role.toLowerCase() ==
      'user';

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
  // DISPLAY NAME
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

    return 'Member';
  }

  // =====================================================
  // SAFE PHOTO
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
  // ROLE LABEL
  // =====================================================

  String get roleLabel {
    if (isAdmin) {
      return 'System Manager';
    }

    return 'Premium Member';
  }

  // =====================================================
  // VERIFIED STATUS
  // =====================================================

  bool get isVerified {
    return isActive;
  }

  // =====================================================
  // VERIFIED COLOR
  // =====================================================

  String get verifiedLabel {
    return isVerified
        ? 'Verified'
        : 'Unverified';
  }

  // =====================================================
  // AVATAR LETTER
  // =====================================================

  String get avatarLetter {
    if (name
        .trim()
        .isNotEmpty) {
      return name
          .trim()
          .substring(0, 1)
          .toUpperCase();
    }

    if (username
        .trim()
        .isNotEmpty) {
      return username
          .trim()
          .substring(0, 1)
          .toUpperCase();
    }

    return 'U';
  }

  // =====================================================
  // PROFILE COMPLETION
  // =====================================================

  bool get isProfileComplete {
    return name
            .trim()
            .isNotEmpty &&
        username
            .trim()
            .isNotEmpty &&
        email
            .trim()
            .isNotEmpty &&
        phone
            .trim()
            .isNotEmpty &&
        address
            .trim()
            .isNotEmpty;
  }

  // =====================================================
  // PROFILE PERCENTAGE
  // =====================================================

  double get profileCompletion {
    int total = 5;

    int completed = 0;

    if (name
        .trim()
        .isNotEmpty) {
      completed++;
    }

    if (username
        .trim()
        .isNotEmpty) {
      completed++;
    }

    if (email
        .trim()
        .isNotEmpty) {
      completed++;
    }

    if (phone
        .trim()
        .isNotEmpty) {
      completed++;
    }

    if (address
        .trim()
        .isNotEmpty) {
      completed++;
    }

    return completed / total;
  }

  // =====================================================
  // PROFILE COMPLETION PERCENT
  // =====================================================

  int get profileCompletionPercent {
    return (profileCompletion *
            100)
        .toInt();
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
    DateTime? updatedAt,
    DateTime? lastLogin,
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

      updatedAt:
          updatedAt ??
              this.updatedAt,

      lastLogin:
          lastLogin ??
              this.lastLogin,
    );
  }

  // =====================================================
  // DATE PARSER
  // =====================================================

  static DateTime _parseDate(
    dynamic value,
  ) {
    try {
      if (value == null) {
        return DateTime.now();
      }

      if (value is String) {
        return DateTime.tryParse(
              value,
            ) ??
            DateTime.now();
      }

      if (value is int) {
        return DateTime
            .fromMillisecondsSinceEpoch(
          value,
        );
      }

      return DateTime.now();
    } catch (_) {
      return DateTime.now();
    }
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

  // =====================================================
  // HASHCODE
  // =====================================================

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

  // =====================================================
  // DEBUG
  // =====================================================

  @override
  String toString() {
    return '''

UserModel(
  uid: $uid,
  name: $name,
  username: $username,
  email: $email,
  role: $role,
  photoUrl: ${photoUrl.isNotEmpty ? 'Available' : 'Empty'},
  phone: $phone,
  address: $address,
  isActive: $isActive,
  verified: $isVerified
)

''';
  }
}