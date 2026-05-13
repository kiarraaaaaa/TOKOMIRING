// lib/services/notification_service.dart

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class NotificationService {

  // =====================================================
  // DATABASE
  // =====================================================

  final DatabaseReference _database =
      FirebaseDatabase.instance.ref();

  // =====================================================
  // REALTIME TIME
  // =====================================================

  String formatRealtimeTime(
    String createdAt,
  ) {

    try {

      final date =
          DateTime.parse(
        createdAt,
      ).toLocal();

      return DateFormat(
        'HH:mm:ss',
      ).format(
        date,
      );

    } catch (_) {

      return '--:--';
    }
  }

  // =====================================================
  // REALTIME DATE
  // =====================================================

  String formatRealtimeDate(
    String createdAt,
  ) {

    try {

      final date =
          DateTime.parse(
        createdAt,
      ).toLocal();

      return DateFormat(
        'dd MMM yyyy',
      ).format(
        date,
      );

    } catch (_) {

      return '-- --- ----';
    }
  }

  // =====================================================
  // CREATE NOTIFICATION
  // =====================================================

  Future<void> createNotification({

    required String title,

    required String message,

    required String type,

    required String targetRole,

  }) async {

    try {

      final notificationId =
          _database
              .child('notifications')
              .push()
              .key;

      if (notificationId == null) {

        throw Exception(
          'Failed to generate notification ID',
        );
      }

      final now =
          DateTime.now().toLocal();

      await _database
          .child('notifications')
          .child(notificationId)
          .set({

        'id':
            notificationId,

        'title':
            title.trim(),

        'message':
            message.trim(),

        'type':
            type.trim(),

        'targetRole':
            targetRole.trim(),

        'isRead':
            false,

        // ===============================================
        // REALTIME TIMESTAMP
        // ===============================================

        'createdAt':
            now.toIso8601String(),

        'time':
            DateFormat(
              'HH:mm:ss',
            ).format(
              now,
            ),

        'date':
            DateFormat(
              'dd MMM yyyy',
            ).format(
              now,
            ),
      });

    } catch (e) {

      throw Exception(
        e.toString(),
      );
    }
  }

  // =====================================================
  // GET NOTIFICATIONS
  // =====================================================

  Stream<List<Map<String, dynamic>>>
      getNotifications({

    required String role,

  }) {

    return _database
        .child('notifications')
        .onValue
        .map((event) {

      final data =
          event.snapshot.value;

      if (data == null) {

        return [];
      }

      if (data is! Map) {

        return [];
      }

      final map =
          Map<dynamic, dynamic>.from(
        data,
      );

      final List<Map<String, dynamic>>
          notifications = [];

      map.forEach((key, value) {

        try {

          if (value == null ||
              value is! Map) {

            return;
          }

          final item =
              Map<dynamic, dynamic>.from(
            value,
          );

          final targetRole =
              item['targetRole']
                      ?.toString() ??
                  '';

          if (targetRole ==
                  role ||

              targetRole ==
                  'all') {

            final createdAt =
                item['createdAt']
                        ?.toString() ??
                    DateTime.now()
                        .toIso8601String();

            notifications.add({

              'id':
                  item['id'] ?? '',

              'title':
                  item['title'] ?? '',

              'message':
                  item['message'] ?? '',

              'type':
                  item['type'] ?? '',

              'targetRole':
                  targetRole,

              'isRead':
                  item['isRead'] ?? false,

              'createdAt':
                  createdAt,

              // =========================================
              // REALTIME FORMATTED
              // =========================================

              'time':

                  item['time'] ??

                      formatRealtimeTime(
                        createdAt,
                      ),

              'date':

                  item['date'] ??

                      formatRealtimeDate(
                        createdAt,
                      ),
            });
          }

        } catch (_) {}
      });

      // ===============================================
      // SORT NEWEST
      // ===============================================

      notifications.sort(
        (a, b) {

          final aDate =
              DateTime.tryParse(
                    a['createdAt']
                        .toString(),
                  ) ??
                  DateTime.now();

          final bDate =
              DateTime.tryParse(
                    b['createdAt']
                        .toString(),
                  ) ??
                  DateTime.now();

          return bDate.compareTo(
            aDate,
          );
        },
      );

      return notifications;
    });
  }

  // =====================================================
  // MARK AS READ
  // =====================================================

  Future<void> markAsRead(
    String notificationId,
  ) async {

    try {

      await _database
          .child('notifications')
          .child(notificationId)
          .update({

        'isRead':
            true,
      });

    } catch (e) {

      throw Exception(
        e.toString(),
      );
    }
  }

  // =====================================================
  // MARK ALL AS READ
  // =====================================================

  Future<void>
      markAllAsRead({

    required String role,

  }) async {

    try {

      final snapshot =
          await _database
              .child('notifications')
              .get();

      if (!snapshot.exists ||
          snapshot.value == null) {

        return;
      }

      final map =
          Map<dynamic, dynamic>.from(
        snapshot.value as Map,
      );

      for (final entry
          in map.entries) {

        final item =
            Map<dynamic, dynamic>.from(
          entry.value,
        );

        if (item['targetRole'] ==
                role ||

            item['targetRole'] ==
                'all') {

          await _database
              .child('notifications')
              .child(
                entry.key,
              )
              .update({

            'isRead':
                true,
          });
        }
      }

    } catch (e) {

      throw Exception(
        e.toString(),
      );
    }
  }

  // =====================================================
  // DELETE NOTIFICATION
  // =====================================================

  Future<void> deleteNotification(
    String notificationId,
  ) async {

    try {

      await _database
          .child('notifications')
          .child(notificationId)
          .remove();

    } catch (e) {

      throw Exception(
        e.toString(),
      );
    }
  }

  // =====================================================
  // CLEAR ALL
  // =====================================================

  Future<void>
      clearAllNotifications()
      async {

    try {

      await _database
          .child('notifications')
          .remove();

    } catch (e) {

      throw Exception(
        e.toString(),
      );
    }
  }

  // =====================================================
  // UNREAD COUNT
  // =====================================================

  Stream<int> getUnreadCount({

    required String role,

  }) {

    return getNotifications(
      role: role,
    ).map(

      (notifications) {

        return notifications
            .where(

              (notification) =>

                  notification[
                      'isRead'] ==

                  false,
            )
            .length;
      },
    );
  }

  // =====================================================
  // NEW ORDER
  // =====================================================

  Future<void>
      sendNewOrderNotification({

    required String customerName,

  }) async {

    await createNotification(

      title:
          'New Order',

      message:
          '$customerName created a new order',

      type:
          'order',

      targetRole:
          'admin',
    );
  }

  // =====================================================
  // PAYMENT
  // =====================================================

  Future<void>
      sendPaymentNotification({

    required String customerName,

  }) async {

    await createNotification(

      title:
          'Payment Uploaded',

      message:
          '$customerName uploaded payment proof',

      type:
          'payment',

      targetRole:
          'admin',
    );
  }

  // =====================================================
  // ORDER STATUS
  // =====================================================

  Future<void>
      sendOrderStatusNotification({

    required String status,

  }) async {

    await createNotification(

      title:
          'Order Status Updated',

      message:
          'Order status changed to $status',

      type:
          'status',

      targetRole:
          'admin',
    );
  }

  // =====================================================
  // ORDER VALIDATION
  // =====================================================

  Future<void>
      sendValidationNotification({

    required String customerName,

  }) async {

    await createNotification(

      title:
          'Order Validated',

      message:
          '$customerName order has been validated',

      type:
          'validation',

      targetRole:
          'admin',
    );
  }

  // =====================================================
  // LOW STOCK
  // =====================================================

  Future<void>
      sendLowStockNotification({

    required String productName,

  }) async {

    await createNotification(

      title:
          'Low Stock Warning',

      message:
          '$productName stock is running low',

      type:
          'stock',

      targetRole:
          'admin',
    );
  }

  // =====================================================
  // BROADCAST
  // =====================================================

  Future<void>
      sendBroadcastNotification({

    required String title,

    required String message,

  }) async {

    await createNotification(

      title:
          title,

      message:
          message,

      type:
          'broadcast',

      targetRole:
          'all',
    );
  }

  // =====================================================
  // DEBUG LISTENER
  // =====================================================

  void listenNotifications() {

    _database
        .child('notifications')
        .onChildAdded
        .listen((event) {

      if (kDebugMode) {

        debugPrint(

          'New notification: ${event.snapshot.value}',
        );
      }
    });
  }
}