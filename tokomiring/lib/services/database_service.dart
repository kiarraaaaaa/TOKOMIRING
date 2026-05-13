import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../models/order_model.dart';
import '../models/product_model.dart';

class DatabaseService {

  // =====================================================
  // DATABASE
  // =====================================================

  final DatabaseReference _database =
      FirebaseDatabase.instance.ref();

  final Uuid _uuid =
      const Uuid();

  // =====================================================
  // PRODUCT SECTION
  // =====================================================

  Future<void> addProduct(
    ProductModel product,
  ) async {

    try {

      final productRef =
          _database
              .child('products')
              .child(product.id);

      final snapshot =
          await productRef.get();

      if (snapshot.exists) {

        throw Exception(
          'Product already exists',
        );
      }

      await productRef.set(
        product.toMap(),
      );

    } catch (e) {

      throw Exception(
        e.toString(),
      );
    }
  }

  // =====================================================
  // UPDATE PRODUCT
  // =====================================================

  Future<void> updateProduct(
    ProductModel product,
  ) async {

    try {

      await _database
          .child('products')
          .child(product.id)
          .update(
            product.toMap(),
          );

    } catch (e) {

      throw Exception(
        e.toString(),
      );
    }
  }

  // =====================================================
  // DELETE PRODUCT
  // =====================================================

  Future<void> deleteProduct(
    String productId,
  ) async {

    try {

      await _database
          .child('products')
          .child(productId)
          .remove();

    } catch (e) {

      throw Exception(
        e.toString(),
      );
    }
  }

  // =====================================================
  // UPDATE STOCK
  // =====================================================

  Future<void> updateStock({

    required String productId,

    required int stock,

  }) async {

    try {

      if (stock < 0) {

        throw Exception(
          'Stock cannot be negative',
        );
      }

      await _database
          .child('products')
          .child(productId)
          .update({

        'stock': stock,
      });

    } catch (e) {

      throw Exception(
        e.toString(),
      );
    }
  }

  // =====================================================
  // GET PRODUCTS
  // =====================================================

  Stream<List<ProductModel>>
      getProducts() {

    return _database
        .child('products')
        .onValue
        .map((event) {

      final data =
          event.snapshot.value;

      if (data == null) {

        return [];
      }

      final map =
          Map<dynamic, dynamic>.from(
        data as Map,
      );

      final List<ProductModel>
          products = [];

      map.forEach((key, value) {

        try {

          products.add(

            ProductModel.fromMap(

              Map<dynamic, dynamic>.from(
                value,
              ),

              key,
            ),
          );

        } catch (_) {}
      });

      products.sort(
        (a, b) =>
            b.createdAt.compareTo(
          a.createdAt,
        ),
      );

      return products;
    });
  }

  // =====================================================
  // CATEGORY
  // =====================================================

  Stream<List<ProductModel>>
      getProductsByCategory(
    String category,
  ) {

    return getProducts().map(

      (products) => products
          .where(

            (product) =>

                product.category
                    .toLowerCase() ==

                category.toLowerCase(),
          )
          .toList(),
    );
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

    final now =
        DateTime.now().toLocal();

    await _database
        .child('notifications')
        .push()
        .set({

      'title':
          title,

      'message':
          message,

      'type':
          type,

      'targetRole':
          targetRole,

      'isRead':
          false,

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
  }

  // =====================================================
  // CREATE ORDER
  // =====================================================

  Future<String> createOrder(
    OrderModel order,
  ) async {

    try {

      final orderId =
          _uuid.v4();

      final now =
          DateTime.now();

      final newOrder =
          order.copyWith(

        orderId:
            orderId,

        createdAt:
            now,

        updatedAt:
            now,
      );

      // ===============================================
      // SAVE ORDER
      // ===============================================

      await _database
          .child('orders')
          .child(orderId)
          .set(
            newOrder.toMap(),
          );

      // ===============================================
      // REDUCE STOCK
      // ===============================================

      for (final item
          in order.items) {

        final snapshot =
            await _database
                .child('products')
                .child(
                  item.productId,
                )
                .get();

        if (!snapshot.exists ||
            snapshot.value == null) {

          continue;
        }

        final productData =
            Map<dynamic, dynamic>.from(
          snapshot.value as Map,
        );

        final currentStock =
            productData['stock'] ?? 0;

        int updatedStock =
            currentStock -
                item.quantity;

        if (updatedStock < 0) {

          updatedStock = 0;
        }

        await _database
            .child('products')
            .child(
              item.productId,
            )
            .update({

          'stock':
              updatedStock,
        });
      }

      // ===============================================
      // REALTIME NOTIFICATION
      // ===============================================

      await createNotification(

        title:
            'New Order',

        message:
            '${order.customerName} created a new order',

        type:
            'order',

        targetRole:
            'admin',
      );

      return orderId;

    } catch (e) {

      throw Exception(
        e.toString(),
      );
    }
  }

  // =====================================================
  // GET ORDERS
  // =====================================================

  Stream<List<OrderModel>>
      getOrders() {

    return _database
        .child('orders')
        .onValue
        .map((event) {

      final data =
          event.snapshot.value;

      if (data == null) {

        return [];
      }

      final map =
          Map<dynamic, dynamic>.from(
        data as Map,
      );

      final List<OrderModel>
          orders = [];

      map.forEach((key, value) {

        try {

          orders.add(

            OrderModel.fromMap(

              Map<dynamic, dynamic>.from(
                value,
              ),

              key,
            ),
          );

        } catch (_) {}
      });

      orders.sort(
        (a, b) =>
            b.createdAt.compareTo(
          a.createdAt,
        ),
      );

      return orders;
    });
  }

  // =====================================================
  // USER ORDERS
  // =====================================================

  Stream<List<OrderModel>>
      getUserOrders(
    String userId,
  ) {

    return getOrders().map(

      (orders) => orders
          .where(

            (order) =>
                order.userId ==
                userId,
          )
          .toList(),
    );
  }

  // =====================================================
  // UPDATE ORDER STATUS
  // =====================================================

  Future<void>
      updateOrderStatus({

    required String orderId,

    required String status,

  }) async {

    try {

      final orderSnapshot =
          await _database
              .child('orders')
              .child(orderId)
              .get();

      if (!orderSnapshot.exists ||
          orderSnapshot.value ==
              null) {

        throw Exception(
          'Order not found',
        );
      }

      final orderData =
          Map<dynamic, dynamic>.from(
        orderSnapshot.value as Map,
      );

      final customerName =
          orderData['customerName']
                  ?.toString() ??
              'Customer';

      final now =
          DateTime.now();

      final updates = {

        'status':
            status,

        'updatedAt':
            now.toIso8601String(),
      };

      // ===============================================
      // COMPLETED TIME
      // ===============================================

      if (status
              .toLowerCase() ==
          'completed') {

        updates['completedAt'] =
            now.toIso8601String();
      }

      // ===============================================
      // UPDATE ORDER
      // ===============================================

      await _database
          .child('orders')
          .child(orderId)
          .update(
            updates,
          );

      // ===============================================
      // REALTIME NOTIFICATION
      // ===============================================

      await createNotification(

        title:
            'Order Updated',

        message:
            '$customerName order changed to $status',

        type:
            'status',

        targetRole:
            'admin',
      );

    } catch (e) {

      throw Exception(
        e.toString(),
      );
    }
  }

  // =====================================================
  // VALIDATE ORDER
  // =====================================================

  Future<void> validateOrder(
    String orderId,
  ) async {

    try {

      final orderSnapshot =
          await _database
              .child('orders')
              .child(orderId)
              .get();

      if (!orderSnapshot.exists ||
          orderSnapshot.value ==
              null) {

        throw Exception(
          'Order not found',
        );
      }

      final orderData =
          Map<dynamic, dynamic>.from(
        orderSnapshot.value as Map,
      );

      final customerName =
          orderData['customerName']
                  ?.toString() ??
              'Customer';

      final now =
          DateTime.now();

      await _database
          .child('orders')
          .child(orderId)
          .update({

        'isValidated':
            true,

        'status':
            'Processing Delivery',

        'updatedAt':
            now.toIso8601String(),
      });

      // ===============================================
      // REALTIME VALIDATION NOTIFICATION
      // ===============================================

      await createNotification(

        title:
            'Order Validated',

        message:
            '$customerName order validated successfully',

        type:
            'validation',

        targetRole:
            'admin',
      );

    } catch (e) {

      throw Exception(
        e.toString(),
      );
    }
  }

  // =====================================================
  // REPORTS
  // =====================================================

  Stream<List<OrderModel>>
      getDailyOrders(
    DateTime date,
  ) {

    return getOrders().map(

      (orders) => orders.where(

        (order) {

          return order
                      .createdAt
                      .year ==
                  date.year &&

              order
                      .createdAt
                      .month ==
                  date.month &&

              order
                      .createdAt
                      .day ==
                  date.day;
        },
      ).toList(),
    );
  }

  Stream<List<OrderModel>>
      getMonthlyOrders(
    DateTime date,
  ) {

    return getOrders().map(

      (orders) => orders.where(

        (order) {

          return order
                      .createdAt
                      .year ==
                  date.year &&

              order
                      .createdAt
                      .month ==
                  date.month;
        },
      ).toList(),
    );
  }

  Stream<List<OrderModel>>
      getYearlyOrders(
    DateTime date,
  ) {

    return getOrders().map(

      (orders) => orders.where(

        (order) {

          return order
                  .createdAt
                  .year ==
              date.year;
        },
      ).toList(),
    );
  }

  // =====================================================
  // REVENUE
  // =====================================================

  double calculateRevenue(
    List<OrderModel> orders,
  ) {

    double total = 0;

    for (final order
        in orders) {

      if (order.status
              .toLowerCase() ==
          'completed') {

        total +=
            order.totalPrice;
      }
    }

    return total;
  }

  // =====================================================
  // TOTAL ORDERS
  // =====================================================

  int calculateTotalOrders(
    List<OrderModel> orders,
  ) {

    return orders.length;
  }

  // =====================================================
  // NOTIFICATIONS
  // =====================================================

  Stream<List<Map<dynamic, dynamic>>>
      getNotifications() {

    return _database
        .child('notifications')
        .onValue
        .map((event) {

      final data =
          event.snapshot.value;

      if (data == null) {

        return [];
      }

      final map =
          Map<dynamic, dynamic>.from(
        data as Map,
      );

      final List<Map<dynamic, dynamic>>
          notifications = [];

      map.forEach((key, value) {

        try {

          notifications.add(

            Map<dynamic, dynamic>.from(
              value,
            ),
          );

        } catch (_) {}
      });

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
  // DASHBOARD
  // =====================================================

  Stream<int>
      getTotalProducts() {

    return getProducts().map(
      (products) =>
          products.length,
    );
  }

  Stream<int>
      getLowStockProducts() {

    return getProducts().map(

      (products) => products
          .where(

            (product) =>
                product.stock <= 5,
          )
          .length,
    );
  }

  Stream<double>
      getTotalRevenue() {

    return getOrders().map(

      (orders) =>
          calculateRevenue(
        orders,
      ),
    );
  }

  Stream<int>
      getTotalOrders() {

    return getOrders().map(
      (orders) =>
          orders.length,
    );
  }
}