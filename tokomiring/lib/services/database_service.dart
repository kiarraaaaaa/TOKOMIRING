// lib/services/database_service.dart

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
  // DATABASE PATHS
  // =====================================================

  static const String productsPath =
      'products';

  static const String ordersPath =
      'orders';

  static const String usersPath =
      'users';

  static const String notificationsPath =
      'notifications';

  static const String cartsPath =
      'carts';

  // =====================================================
  // PRODUCT SECTION
  // =====================================================

  Future<void> addProduct(
    ProductModel product,
  ) async {

    try {

      final productRef =
          _database
              .child(productsPath)
              .child(product.id);

      final snapshot =
          await productRef.get();

      if (snapshot.exists) {

        throw Exception(
          'Product already exists',
        );
      }

      await productRef.set({

        ...product.toMap(),

        'createdAt':
            DateTime.now()
                .toIso8601String(),

        'updatedAt':
            DateTime.now()
                .toIso8601String(),

        'isAvailable':
            true,
      });

      // ===============================================
      // NOTIFICATION
      // ===============================================

      await createNotification(

        title:
            'New Product',

        message:
            '${product.name} added successfully',

        type:
            'product',

        targetRole:
            'user',
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
          .child(productsPath)
          .child(product.id)
          .update({

        ...product.toMap(),

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
  // DELETE PRODUCT
  // =====================================================

  Future<void> deleteProduct(
    String productId,
  ) async {

    try {

      await _database
          .child(productsPath)
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
          .child(productsPath)
          .child(productId)
          .update({

        'stock':
            stock,

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
  // GET PRODUCTS
  // =====================================================

  Stream<List<ProductModel>>
      getProducts() {

    return _database
        .child(productsPath)
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

          final product =
              ProductModel.fromMap(

            Map<dynamic, dynamic>.from(
              value,
            ),

            key,
          );

          if (product.stock > 0) {

            products.add(product);
          }

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
  // SEARCH PRODUCTS
  // =====================================================

  Stream<List<ProductModel>>
      searchProducts(
    String query,
  ) {

    return getProducts().map(

      (products) {

        return products.where(

          (product) {

            return product.name
                    .toLowerCase()
                    .contains(

                      query.toLowerCase(),
                    ) ||

                product.category
                    .toLowerCase()
                    .contains(

                      query.toLowerCase(),
                    );
          },
        ).toList();
      },
    );
  }

  // =====================================================
  // CATEGORY PRODUCTS
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
  // CART SECTION
  // =====================================================

  Future<void> addToCart({

    required String userId,

    required ProductModel product,

    required int quantity,

  }) async {

    try {

      final cartRef =
          _database
              .child(cartsPath)
              .child(userId)
              .child(product.id);

      final snapshot =
          await cartRef.get();

      int currentQty = 0;

      if (snapshot.exists &&
          snapshot.value != null) {

        final data =
            Map<dynamic, dynamic>.from(
          snapshot.value as Map,
        );

        currentQty =
            data['quantity'] ?? 0;
      }

      final updatedQty =
          currentQty + quantity;

      await cartRef.set({

        'productId':
            product.id,

        'name':
            product.name,

        'imageBase64':
            product.imageBase64,

        'price':
            product.price,

        'stock':
            product.stock,

        'quantity':
            updatedQty,

        'subtotal':
            updatedQty *
                product.price,

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
  // GET CART
  // =====================================================

  Stream<List<Map<dynamic, dynamic>>>
      getCart(
    String userId,
  ) {

    return _database
        .child(cartsPath)
        .child(userId)
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
          items = [];

      map.forEach((key, value) {

        try {

          items.add(

            Map<dynamic, dynamic>.from(
              value,
            ),
          );

        } catch (_) {}
      });

      return items;
    });
  }

  // =====================================================
  // UPDATE CART QUANTITY
  // =====================================================

  Future<void>
      updateCartQuantity({

    required String userId,

    required String productId,

    required int quantity,

  }) async {

    try {

      final cartRef =
          _database
              .child(cartsPath)
              .child(userId)
              .child(productId);

      if (quantity <= 0) {

        await cartRef.remove();

        return;
      }

      final snapshot =
          await cartRef.get();

      if (!snapshot.exists ||
          snapshot.value == null) {

        return;
      }

      final data =
          Map<dynamic, dynamic>.from(
        snapshot.value as Map,
      );

      final price =
          data['price'] ?? 0;

      await cartRef.update({

        'quantity':
            quantity,

        'subtotal':
            quantity * price,
      });

    } catch (e) {

      throw Exception(
        e.toString(),
      );
    }
  }

  // =====================================================
  // REMOVE CART ITEM
  // =====================================================

  Future<void> removeCartItem({

    required String userId,

    required String productId,

  }) async {

    try {

      await _database
          .child(cartsPath)
          .child(userId)
          .child(productId)
          .remove();

    } catch (e) {

      throw Exception(
        e.toString(),
      );
    }
  }

  // =====================================================
  // CLEAR CART
  // =====================================================

  Future<void> clearCart(
    String userId,
  ) async {

    try {

      await _database
          .child(cartsPath)
          .child(userId)
          .remove();

    } catch (e) {

      throw Exception(
        e.toString(),
      );
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

    final now =
        DateTime.now().toLocal();

    await _database
        .child(notificationsPath)
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
          ).format(now),

      'date':
          DateFormat(
            'dd MMM yyyy',
          ).format(now),
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

        status:
            'Pending',

        isValidated:
            false,
      );

      // ===============================================
      // SAVE ORDER
      // ===============================================

      await _database
          .child(ordersPath)
          .child(orderId)
          .set(
            newOrder.toMap(),
          );

      // ===============================================
      // UPDATE STOCK
      // ===============================================

      for (final item
          in order.items) {

        final snapshot =
            await _database
                .child(productsPath)
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
            .child(productsPath)
            .child(
              item.productId,
            )
            .update({

          'stock':
              updatedStock,
        });
      }

      // ===============================================
      // CLEAR CART
      // ===============================================

      await clearCart(
        order.userId,
      );

      // ===============================================
      // ADMIN NOTIFICATION
      // ===============================================

      await createNotification(

        title:
            'New Order',

        message:
            '${order.customerName} placed a new order',

        type:
            'order',

        targetRole:
            'admin',
      );

      // ===============================================
      // USER NOTIFICATION
      // ===============================================

      await createNotification(

        title:
            'Order Created',

        message:
            'Your order has been submitted successfully',

        type:
            'order',

        targetRole:
            'user',
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
        .child(ordersPath)
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
              .child(ordersPath)
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

      if (status
              .toLowerCase() ==
          'completed') {

        updates['completedAt'] =
            now.toIso8601String();
      }

      await _database
          .child(ordersPath)
          .child(orderId)
          .update(
            updates,
          );

      // ===============================================
      // USER NOTIFICATION
      // ===============================================

      await createNotification(

        title:
            'Order Status Updated',

        message:
            '$customerName order changed to $status',

        type:
            'status',

        targetRole:
            'user',
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
              .child(ordersPath)
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
          .child(ordersPath)
          .child(orderId)
          .update({

        'isValidated':
            true,

        'status':
            'Validated',

        'updatedAt':
            now.toIso8601String(),
      });

      // ===============================================
      // USER NOTIFICATION
      // ===============================================

      await createNotification(

        title:
            'Order Validated',

        message:
            '$customerName order validated successfully',

        type:
            'validation',

        targetRole:
            'user',
      );

    } catch (e) {

      throw Exception(
        e.toString(),
      );
    }
  }

  // =====================================================
  // NOTIFICATIONS
  // =====================================================

  Stream<List<Map<dynamic, dynamic>>>
      getNotifications() {

    return _database
        .child(notificationsPath)
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

      (orders) {

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
      },
    );
  }

  Stream<int>
      getTotalOrders() {

    return getOrders().map(
      (orders) =>
          orders.length,
    );
  }

  // =====================================================
  // USER ANALYTICS
  // =====================================================

  Stream<int>
      getUserPendingOrders(
    String userId,
  ) {

    return getUserOrders(
      userId,
    ).map(

      (orders) => orders
          .where(

            (order) =>

                order.status
                    .toLowerCase() ==

                'pending',
          )
          .length,
    );
  }

  Stream<int>
      getUserValidatedOrders(
    String userId,
  ) {

    return getUserOrders(
      userId,
    ).map(

      (orders) => orders
          .where(

            (order) =>
                order.isValidated,
          )
          .length,
    );
  }

  Stream<int>
      getUserTotalOrders(
    String userId,
  ) {

    return getUserOrders(
      userId,
    ).map(
      (orders) =>
          orders.length,
    );
  }
}