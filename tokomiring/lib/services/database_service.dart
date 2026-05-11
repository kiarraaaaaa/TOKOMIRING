// lib/services/database_service.dart

import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

import '../models/order_model.dart';
import '../models/product_model.dart';

class DatabaseService {
  // =====================================================
  // DATABASE
  // =====================================================

  final DatabaseReference _database =
      FirebaseDatabase.instance.ref();

  final Uuid _uuid = const Uuid();

  // =====================================================
  // PRODUCT SECTION
  // =====================================================

  Future<void> addProduct(
    ProductModel product,
  ) async {
    try {
      print(
        'ADDING PRODUCT...',
      );

      print(
        product.toMap(),
      );

      await _database
          .child('products')
          .child(product.id)
          .set(
            product.toMap(),
          );

      print(
        'PRODUCT SUCCESSFULLY ADDED',
      );
    } catch (e) {
      print(
        'ADD PRODUCT ERROR:',
      );

      print(
        e.toString(),
      );

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
        data as dynamic,
      );

      List<ProductModel> products =
          [];

      map.forEach((key, value) {
        products.add(
          ProductModel.fromMap(
            Map<dynamic, dynamic>.from(
              value,
            ),
            key,
          ),
        );
      });

      // SORT NEWEST FIRST

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
  // GET PRODUCTS BY CATEGORY
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
  // CREATE ORDER
  // =====================================================

  Future<String> createOrder(
    OrderModel order,
  ) async {
    try {
      final orderId =
          _uuid.v4();

      final newOrder =
          order.copyWith(
        orderId: orderId,
      );

      // SAVE ORDER

      await _database
          .child('orders')
          .child(orderId)
          .set(
            newOrder.toMap(),
          );

      // NOTIFICATION

      await _database
          .child('notifications')
          .push()
          .set({
        'title': 'New Order',

        'message':
            '${order.customerName} created a new order',

        'createdAt':
            DateTime.now()
                .toIso8601String(),
      });

      // REDUCE STOCK

      for (var item
          in order.items) {
        final snapshot =
            await _database
                .child(
                  'products',
                )
                .child(
                  item.productId,
                )
                .get();

        if (snapshot.exists) {
          final productData =
              Map<dynamic,
                  dynamic>.from(
            snapshot.value
                as dynamic,
          );

          int currentStock =
              productData['stock'] ??
                  0;

          await _database
              .child(
                'products',
              )
              .child(
                item.productId,
              )
              .update({
            'stock':
                currentStock -
                    item.quantity,
          });
        }
      }

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
        data as dynamic,
      );

      List<OrderModel> orders =
          [];

      map.forEach((key, value) {
        orders.add(
          OrderModel.fromMap(
            Map<dynamic, dynamic>.from(
              value,
            ),
            key,
          ),
        );
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
      await _database
          .child('orders')
          .child(orderId)
          .update({
        'status': status,

        'updatedAt':
            DateTime.now()
                .toIso8601String(),
      });

      await _database
          .child('notifications')
          .push()
          .set({
        'title': 'Order Updated',

        'message':
            'Order status changed to $status',

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
  // VALIDATE ORDER
  // =====================================================

  Future<void> validateOrder(
    String orderId,
  ) async {
    try {
      await _database
          .child('orders')
          .child(orderId)
          .update({
        'isValidated': true,

        'status':
            'Processing Delivery',

        'updatedAt':
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
  // SALES REPORT
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
  // CALCULATE REVENUE
  // =====================================================

  double calculateRevenue(
    List<OrderModel> orders,
  ) {
    double total = 0;

    for (var order in orders) {
      total += order.totalPrice;
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

  Stream<
      List<Map<dynamic, dynamic>>>
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
        data as dynamic,
      );

      List<Map<dynamic, dynamic>>
          notifications = [];

      map.forEach((key, value) {
        notifications.add(
          Map<dynamic, dynamic>.from(
            value,
          ),
        );
      });

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
                product.stock <=
                5,
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