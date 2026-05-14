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
            product.stock > 0,
      });

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

        'isAvailable':
            product.stock > 0,

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

      int safeStock =
          stock;

      if (safeStock < 0) {

        safeStock = 0;
      }

      await _database
          .child(productsPath)
          .child(productId)
          .update({

        'stock':
            safeStock,

        'isAvailable':
            safeStock > 0,

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
  // REDUCE PRODUCT STOCK
  // =====================================================

  Future<void>
      reduceProductStock({

    required String productId,

    required int quantity,

  }) async {

    try {

      final productRef =
          _database
              .child(productsPath)
              .child(productId);

      final snapshot =
          await productRef.get();

      if (!snapshot.exists ||
          snapshot.value == null) {

        throw Exception(
          'Product not found',
        );
      }

      final data =
          Map<dynamic, dynamic>.from(
        snapshot.value as Map,
      );

      int currentStock =
          data['stock'] ?? 0;

      int currentSold =
          data['sold'] ?? 0;

      if (quantity <= 0) {

        throw Exception(
          'Invalid quantity',
        );
      }

      if (currentStock <
          quantity) {

        throw Exception(
          'Insufficient stock',
        );
      }

      final newStock =
          currentStock -
              quantity;

      final newSold =
          currentSold +
              quantity;

      await productRef.update({

        'stock':
            newStock,

        'sold':
            newSold,

        'isAvailable':
            newStock > 0,

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
  // RESTORE PRODUCT STOCK
  // =====================================================

  Future<void>
      restoreProductStock({

    required String productId,

    required int quantity,

  }) async {

    try {

      final productRef =
          _database
              .child(productsPath)
              .child(productId);

      final snapshot =
          await productRef.get();

      if (!snapshot.exists ||
          snapshot.value == null) {

        return;
      }

      final data =
          Map<dynamic, dynamic>.from(
        snapshot.value as Map,
      );

      int currentStock =
          data['stock'] ?? 0;

      int currentSold =
          data['sold'] ?? 0;

      int newSold =
          currentSold -
              quantity;

      if (newSold < 0) {

        newSold = 0;
      }

      final newStock =
          currentStock +
              quantity;

      await productRef.update({

        'stock':
            newStock,

        'sold':
            newSold,

        'isAvailable':
            true,

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
  // UPDATE PRODUCT STOCK + SOLD
  // =====================================================

  Future<void>
      updateProductStockAndSold({

    required String productId,

    required int stock,

    required int sold,

  }) async {

    try {

      int safeStock =
          stock;

      int safeSold =
          sold;

      if (safeStock < 0) {

        safeStock = 0;
      }

      if (safeSold < 0) {

        safeSold = 0;
      }

      await _database
          .child(productsPath)
          .child(productId)
          .update({

        'stock':
            safeStock,

        'sold':
            safeSold,

        'isAvailable':
            safeStock > 0,

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

          products.add(
            product,
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

          final order =
              OrderModel.fromMap(

            Map<dynamic, dynamic>.from(
              value,
            ),

            key,
          );

          orders.add(
            order,
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
  // CART SECTION
  // =====================================================

  Future<void> addToCart({

    required String userId,

    required ProductModel product,

    required int quantity,

  }) async {

    try {

      if (product.stock <= 0) {

        throw Exception(
          'Product sold out',
        );
      }

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

      if (updatedQty >
          product.stock) {

        throw Exception(
          'Stock not enough',
        );
      }

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

      final stock =
          data['stock'] ?? 0;

      if (quantity >
          stock) {

        throw Exception(
          'Stock not enough',
        );
      }

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

          throw Exception(
            '${item.productName} not found',
          );
        }

        final data =
            Map<dynamic, dynamic>.from(
          snapshot.value as Map,
        );

        final stock =
            data['stock'] ?? 0;

        if (stock <
            item.quantity) {

          throw Exception(
            '${item.productName} stock not enough',
          );
        }
      }

      final newOrder =
          order.copyWith(

        orderId:
            orderId,

        createdAt:
            now,

        updatedAt:
            now,

        status:
            'Waiting Admin Validation',

        isValidated:
            false,
      );

      await _database
          .child(ordersPath)
          .child(orderId)
          .set(
            newOrder.toMap(),
          );

      for (final item
          in order.items) {

        await reduceProductStock(

          productId:
              item.productId,

          quantity:
              item.quantity,
        );
      }

      await clearCart(
        order.userId,
      );

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
  // UPDATE ORDER STATUS
  // =====================================================

  Future<void>
      updateOrderStatus({

    required String orderId,

    required String status,

  }) async {

    try {

      final now =
          DateTime.now();

      final Map<String, dynamic>
          updates = {

        'status':
            status,

        'updatedAt':
            now.toIso8601String(),

        'isValidated':

            status ==
                    'Processing Delivery' ||

                status ==
                    'Completed',
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

      await createNotification(

        title:
            'Order Updated',

        message:
            'Order status changed to $status',

        type:
            'order',

        targetRole:
            'user',
      );

    } catch (e) {

      throw Exception(
        e.toString(),
      );
    }
  }
}