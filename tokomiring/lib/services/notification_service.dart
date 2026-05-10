// lib/services/notification_service.dart

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
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
      final notificationId =
          DateTime.now()
              .millisecondsSinceEpoch
              .toString();

      await _database
          .child('notifications')
          .child(notificationId)
          .set({
        'id': notificationId,

        'title': title,

        'message': message,

        'type': type,

        'targetRole': targetRole,

        'isRead': false,

        'createdAt':
            DateTime.now().toIso8601String(),
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
      final data = event.snapshot.value;

      if (data == null) {
        return [];
      }

      final map =
          Map<dynamic, dynamic>.from(data as dynamic);

      List<Map<String, dynamic>> notifications =
          [];

      map.forEach((key, value) {
        final item =
            Map<dynamic, dynamic>.from(value);

        if (item['targetRole'] == role ||
            item['targetRole'] == 'all') {
          notifications.add({
            'id': item['id'] ?? '',

            'title': item['title'] ?? '',

            'message': item['message'] ?? '',

            'type': item['type'] ?? '',

            'targetRole':
                item['targetRole'] ?? '',

            'isRead':
                item['isRead'] ?? false,

            'createdAt':
                item['createdAt'] ?? '',
          });
        }
      });

      notifications.sort(
        (a, b) => b['createdAt']
            .compareTo(a['createdAt']),
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
        'isRead': true,
      });
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
  // CLEAR ALL NOTIFICATIONS
  // =====================================================

  Future<void> clearAllNotifications() async {
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
  // TOTAL UNREAD
  // =====================================================

  Stream<int> getUnreadCount({
    required String role,
  }) {
    return getNotifications(role: role).map(
      (notifications) => notifications
          .where(
            (notification) =>
                notification['isRead'] == false,
          )
          .length,
    );
  }

  // =====================================================
  // CREATE ORDER NOTIFICATION
  // =====================================================

  Future<void> sendNewOrderNotification({
    required String customerName,
  }) async {
    await createNotification(
      title: 'New Order',

      message:
          '$customerName created a new order',

      type: 'order',

      targetRole: 'admin',
    );
  }

  // =====================================================
  // CREATE PAYMENT NOTIFICATION
  // =====================================================

  Future<void> sendPaymentNotification({
    required String customerName,
  }) async {
    await createNotification(
      title: 'Payment Uploaded',

      message:
          '$customerName uploaded payment proof',

      type: 'payment',

      targetRole: 'admin',
    );
  }

  // =====================================================
  // ORDER STATUS NOTIFICATION
  // =====================================================

  Future<void> sendOrderStatusNotification({
    required String status,
  }) async {
    await createNotification(
      title: 'Order Status Updated',

      message:
          'Your order status changed to $status',

      type: 'status',

      targetRole: 'user',
    );
  }

  // =====================================================
  // LOW STOCK NOTIFICATION
  // =====================================================

  Future<void> sendLowStockNotification({
    required String productName,
  }) async {
    await createNotification(
      title: 'Low Stock Warning',

      message:
          '$productName stock is running low',

      type: 'stock',

      targetRole: 'admin',
    );
  }

  // =====================================================
  // ADMIN BROADCAST
  // =====================================================

  Future<void> sendBroadcastNotification({
    required String title,
    required String message,
  }) async {
    await createNotification(
      title: title,

      message: message,

      type: 'broadcast',

      targetRole: 'all',
    );
  }

  // =====================================================
  // REALTIME LISTENER DEBUG
  // =====================================================

  void listenNotifications() {
    _database
        .child('notifications')
        .onChildAdded
        .listen((event) {
      if (kDebugMode) {
        print(
          'New notification: ${event.snapshot.value}',
        );
      }
    });
  }
}