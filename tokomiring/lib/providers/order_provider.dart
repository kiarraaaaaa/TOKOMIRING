import 'dart:async';

import 'package:flutter/material.dart';

import '../models/order_model.dart';

import '../services/database_service.dart';

class OrderProvider
    extends ChangeNotifier {

  final DatabaseService
      _databaseService =
      DatabaseService();

  // =====================================================
  // VARIABLES
  // =====================================================

  List<OrderModel> _orders =
      [];

  bool _isLoading =
      false;

  bool _initialized =
      false;

  String? _errorMessage;

  StreamSubscription?
      _orderSubscription;

  // =====================================================
  // GETTERS
  // =====================================================

  List<OrderModel> get orders =>
      _orders;

  bool get isLoading =>
      _isLoading;

  String? get errorMessage =>
      _errorMessage;

  // =====================================================
  // TOTAL SALES
  // =====================================================

  double get totalSales {

    double total = 0;

    for (final order
        in _orders) {

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

  int get totalOrders =>
      _orders.length;

  // =====================================================
  // PENDING
  // =====================================================

  int get pendingOrders {

    return _orders.where(
      (order) {

        return order.status
                .toLowerCase() ==
            'waiting admin validation';
      },
    ).length;
  }

  // =====================================================
  // COMPLETED
  // =====================================================

  int get completedOrders {

    return _orders.where(
      (order) {

        return order.status
                .toLowerCase() ==
            'completed';
      },
    ).length;
  }

  // =====================================================
  // TOTAL ITEMS SOLD
  // =====================================================

  int get totalItemsSold {

    int total = 0;

    for (final order
        in _orders) {

      if (order.status
              .toLowerCase() ==
          'completed') {

        total +=
            order.totalItems;
      }
    }

    return total;
  }

  // =====================================================
  // INITIALIZE
  // =====================================================

  Future<void>
      initializeOrders() async {

    // ===============================================
    // PREVENT MULTIPLE LISTENER
    // ===============================================

    if (_initialized) {
      return;
    }

    _initialized = true;

    _setLoading(true);

    _clearError();

    await _orderSubscription
        ?.cancel();

    // ===============================================
    // REALTIME STREAM
    // ===============================================

    _orderSubscription =
        _databaseService
            .getOrders()
            .listen(

      (data) {

        _orders = data;

        _setLoading(false);

        notifyListeners();
      },

      onError: (e) {

        _errorMessage =
            e.toString();

        _setLoading(false);

        notifyListeners();
      },
    );
  }

  // =====================================================
  // FORCE REFRESH
  // =====================================================

  Future<void>
      refreshOrders() async {

    try {

      _setLoading(true);

      final completer =
          Completer<void>();

      await _orderSubscription
          ?.cancel();

      _orderSubscription =
          _databaseService
              .getOrders()
              .listen(

        (data) {

          _orders = data;

          _setLoading(false);

          notifyListeners();

          if (!completer
              .isCompleted) {

            completer.complete();
          }
        },

        onError: (e) {

          _errorMessage =
              e.toString();

          _setLoading(false);

          notifyListeners();

          if (!completer
              .isCompleted) {

            completer.completeError(
              e,
            );
          }
        },
      );

      await completer.future;

    } catch (e) {

      _errorMessage =
          e.toString();

      notifyListeners();
    }
  }

  // =====================================================
  // CREATE ORDER
  // =====================================================

  Future<bool> createOrder(
    OrderModel order,
  ) async {

    try {

      _setLoading(true);

      _clearError();

      await _databaseService
          .createOrder(
        order,
      );

      await refreshOrders();

      notifyListeners();

      return true;

    } catch (e) {

      _errorMessage =
          e.toString();

      notifyListeners();

      return false;

    } finally {

      _setLoading(false);
    }
  }

  // =====================================================
  // VALIDATE ORDER
  // =====================================================

  Future<bool> validateOrder(
    String orderId,
  ) async {

    try {

      _setLoading(true);

      _clearError();

      await _databaseService
          .validateOrder(
        orderId,
      );

      final index =
          _orders.indexWhere(
        (order) {

          return order.orderId ==
              orderId;
        },
      );

      if (index != -1) {

        _orders[index] =
            _orders[index]
                .copyWith(
          status:
              'Processing Delivery',
        );
      }

      await refreshOrders();

      notifyListeners();

      return true;

    } catch (e) {

      _errorMessage =
          e.toString();

      notifyListeners();

      return false;

    } finally {

      _setLoading(false);
    }
  }

  // =====================================================
  // UPDATE STATUS
  // =====================================================

  Future<bool>
      updateOrderStatus({

    required String orderId,

    required String status,

  }) async {

    try {

      _setLoading(true);

      _clearError();

      final index =
          _orders.indexWhere(
        (order) {

          return order.orderId ==
              orderId;
        },
      );

      if (index == -1) {

        _setLoading(false);

        return false;
      }

      final oldOrder =
          _orders[index];

      // ===============================================
      // UPDATE DATABASE
      // ===============================================

      await _databaseService
          .updateOrderStatus(

        orderId:
            orderId,

        status:
            status,
      );

      // ===============================================
      // UPDATE LOCAL
      // ===============================================

      _orders[index] =
          oldOrder.copyWith(
        status: status,
      );

      // ===============================================
      // COMPLETED = UPDATE SOLD
      // ===============================================

      if (status
                  .toLowerCase() ==
              'completed' &&
          oldOrder.status
                  .toLowerCase() !=
              'completed') {

        for (final item
            in oldOrder.items) {

          try {

            await _databaseService
                .increaseProductSold(

              productId:
                  item.productId,

              quantity:
                  item.quantity,
            );

          } catch (_) {}
        }
      }

      // ===============================================
      // REFRESH
      // ===============================================

      await refreshOrders();

      notifyListeners();

      return true;

    } catch (e) {

      _errorMessage =
          e.toString();

      notifyListeners();

      return false;

    } finally {

      _setLoading(false);
    }
  }

  // =====================================================
  // DELETE
  // =====================================================

  Future<bool> deleteOrder(
    String orderId,
  ) async {

    try {

      _setLoading(true);

      _clearError();

      _orders.removeWhere(
        (order) {

          return order.orderId ==
              orderId;
        },
      );

      notifyListeners();

      return true;

    } catch (e) {

      _errorMessage =
          e.toString();

      notifyListeners();

      return false;

    } finally {

      _setLoading(false);
    }
  }

  // =====================================================
  // ORDER BY ID
  // =====================================================

  OrderModel? getOrderById(
    String orderId,
  ) {

    try {

      return _orders.firstWhere(
        (order) {

          return order.orderId ==
              orderId;
        },
      );

    } catch (_) {

      return null;
    }
  }

  // =====================================================
  // USER ORDERS
  // =====================================================

  List<OrderModel>
      getUserOrders(
    String userId,
  ) {

    return _orders.where(
      (order) {

        return order.userId ==
            userId;
      },
    ).toList();
  }

  // =====================================================
  // STATUS FILTER
  // =====================================================

  List<OrderModel>
      getOrdersByStatus(
    String status,
  ) {

    return _orders.where(
      (order) {

        return order.status
                .toLowerCase() ==
            status.toLowerCase();
      },
    ).toList();
  }

  // =====================================================
  // WEEKLY SALES
  // =====================================================

  Map<String, double>
      getWeeklySales() {

    final Map<String, double>
        weeklySales = {

      'Mon': 0,
      'Tue': 0,
      'Wed': 0,
      'Thu': 0,
      'Fri': 0,
      'Sat': 0,
      'Sun': 0,
    };

    for (final order
        in _orders) {

      if (order.status
              .toLowerCase() !=
          'completed') {

        continue;
      }

      final weekday =
          order.createdAt.weekday;

      switch (weekday) {

        case 1:

          weeklySales['Mon'] =
              weeklySales['Mon']! +
                  order.totalPrice;

          break;

        case 2:

          weeklySales['Tue'] =
              weeklySales['Tue']! +
                  order.totalPrice;

          break;

        case 3:

          weeklySales['Wed'] =
              weeklySales['Wed']! +
                  order.totalPrice;

          break;

        case 4:

          weeklySales['Thu'] =
              weeklySales['Thu']! +
                  order.totalPrice;

          break;

        case 5:

          weeklySales['Fri'] =
              weeklySales['Fri']! +
                  order.totalPrice;

          break;

        case 6:

          weeklySales['Sat'] =
              weeklySales['Sat']! +
                  order.totalPrice;

          break;

        case 7:

          weeklySales['Sun'] =
              weeklySales['Sun']! +
                  order.totalPrice;

          break;
      }
    }

    return weeklySales;
  }

  // =====================================================
  // CLEAR ERROR
  // =====================================================

  void clearError() {

    _errorMessage = null;

    notifyListeners();
  }

  // =====================================================
  // PRIVATE
  // =====================================================

  void _setLoading(
    bool value,
  ) {

    _isLoading = value;

    notifyListeners();
  }

  void _clearError() {

    _errorMessage = null;
  }

  // =====================================================
  // DISPOSE
  // =====================================================

  @override
  void dispose() {

    _orderSubscription
        ?.cancel();

    super.dispose();
  }
}