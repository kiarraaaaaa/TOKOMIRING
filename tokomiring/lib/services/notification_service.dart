// lib/services/notification_service.dart

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class NotificationService {

  // =====================================================
  // DATABASE
  // =====================================================

  final DatabaseReference _database =
      FirebaseDatabase.instance.ref();

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

      // ===============================================
      // GENERATE UNIQUE ID
      // ===============================================

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

      // ===============================================
      // SAVE NOTIFICATION
      // ===============================================

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

        'createdAt':
            DateTime.now()
                .toIso8601String(),
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

      // ===============================================
      // EMPTY
      // ===============================================

      if (data == null) {

        return [];
      }

      // ===============================================
      // INVALID FORMAT
      // ===============================================

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

          // ===========================================
          // FILTER ROLE
          // ===========================================

          if (item['targetRole'] ==
                  role ||

              item['targetRole'] ==
                  'all') {

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
                  item['targetRole'] ?? '',

              'isRead':
                  item['isRead'] ?? false,

              'createdAt':
                  item['createdAt'] ?? '',
            });
          }

        } catch (_) {}
      });

      // ===============================================
      // SORT NEWEST FIRST
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
          'Your order status changed to $status',

      type:
          'status',

      targetRole:
          'user',
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