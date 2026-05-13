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
  // INCREASE SOLD
  // =====================================================

  Future<void> increaseProductSold({

    required String productId,

    required int quantity,

  }) async {

    try {

      final snapshot =
          await _database
              .child('products')
              .child(productId)
              .get();

      if (!snapshot.exists ||
          snapshot.value == null) {

        return;
      }

      final data =
          Map<dynamic, dynamic>.from(
        snapshot.value as Map,
      );

      final currentSold =
          data['sold'] ?? 0;

      final updatedSold =
          currentSold + quantity;

      await _database
          .child('products')
          .child(productId)
          .update({

        'sold':
            updatedSold,
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

      // ===============================================
      // SORT NEWEST
      // ===============================================

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
      // NOTIFICATION
      // ===============================================

      await _database
          .child('notifications')
          .push()
          .set({

        'title':
            'New Order',

        'message':
            '${order.customerName} created a new order',

        'createdAt':
            DateTime.now()
                .toIso8601String(),
      });

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

      // ===============================================
      // SORT NEWEST
      // ===============================================

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

      final oldStatus =
          orderData['status'] ??
              '';

      await _database
          .child('orders')
          .child(orderId)
          .update({

        'status':
            status,

        'updatedAt':
            DateTime.now()
                .toIso8601String(),
      });

      // ===============================================
      // COMPLETED = UPDATE SOLD
      // ===============================================

      if (status
                  .toLowerCase() ==
              'completed' &&
          oldStatus
                  .toLowerCase() !=
              'completed') {

        final items =
            orderData['items'];

        if (items is List) {

          for (final item
              in items) {

            final itemMap =
                Map<dynamic,
                    dynamic>.from(
              item,
            );

            await increaseProductSold(

              productId:
                  itemMap['productId']
                      .toString(),

              quantity:
                  itemMap['quantity']
                      as int,
            );
          }
        }
      }

      // ===============================================
      // NOTIFICATION
      // ===============================================

      await _database
          .child('notifications')
          .push()
          .set({

        'title':
            'Order Updated',

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

        'isValidated':
            true,

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