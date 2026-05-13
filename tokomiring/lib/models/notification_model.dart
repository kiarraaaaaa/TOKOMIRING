class NotificationModel {

  final String id;

  final String title;

  final String message;

  final String type;

  final String targetRole;

  final bool isRead;

  final String time;

  final String date;

  final DateTime createdAt;

  NotificationModel({

    required this.id,

    required this.title,

    required this.message,

    required this.type,

    required this.targetRole,

    required this.isRead,

    required this.time,

    required this.date,

    required this.createdAt,
  });

  // =====================================================
  // FROM MAP
  // =====================================================

  factory NotificationModel.fromMap(

    Map<dynamic, dynamic> map,

    String id,
  ) {

    final createdAt =
        _safeDate(
      map['createdAt'],
    );

    return NotificationModel(

      id: id,

      title:
          map['title']
                  ?.toString() ??
              '',

      message:
          map['message']
                  ?.toString() ??
              '',

      type:
          map['type']
                  ?.toString() ??
              'general',

      targetRole:
          map['targetRole']
                  ?.toString() ??
              'admin',

      isRead:
          map['isRead'] ??
              false,

      time:
          map['time']
                  ?.toString() ??
              '',

      date:
          map['date']
                  ?.toString() ??
              '',

      createdAt:
          createdAt,
    );
  }

  // =====================================================
  // TO MAP
  // =====================================================

  Map<String, dynamic> toMap() {

    return {

      'id':
          id,

      'title':
          title,

      'message':
          message,

      'type':
          type,

      'targetRole':
          targetRole,

      'isRead':
          isRead,

      'time':
          time,

      'date':
          date,

      'createdAt':
          createdAt
              .toIso8601String(),
    };
  }

  // =====================================================
  // COPY WITH
  // =====================================================

  NotificationModel copyWith({

    String? id,

    String? title,

    String? message,

    String? type,

    String? targetRole,

    bool? isRead,

    String? time,

    String? date,

    DateTime? createdAt,
  }) {

    return NotificationModel(

      id:
          id ?? this.id,

      title:
          title ?? this.title,

      message:
          message ?? this.message,

      type:
          type ?? this.type,

      targetRole:
          targetRole ??
              this.targetRole,

      isRead:
          isRead ?? this.isRead,

      time:
          time ?? this.time,

      date:
          date ?? this.date,

      createdAt:
          createdAt ??
              this.createdAt,
    );
  }

  @override
  String toString() {

    return 'NotificationModel(title: $title, type: $type)';
  }
}

// =======================================================
// SAFE DATE
// =======================================================

DateTime _safeDate(
  dynamic value,
) {

  if (value == null) {

    return DateTime.now();
  }

  try {

    return DateTime.parse(
      value.toString(),
    );

  } catch (_) {

    return DateTime.now();
  }
}