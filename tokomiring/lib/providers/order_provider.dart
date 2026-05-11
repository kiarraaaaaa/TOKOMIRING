// lib/providers/order_provider.dart

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

    for (var order
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
  // PENDING ORDERS
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
  // COMPLETED ORDERS
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
  // INITIALIZE
  // =====================================================

  void initializeOrders() {

    _setLoading(true);

    _clearError();

    // ===============================================
    // CANCEL OLD STREAM
    // ===============================================

    _orderSubscription
        ?.cancel();

    // ===============================================
    // LISTEN FIREBASE
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

      await _databaseService
          .validateOrder(
        orderId,
      );

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

      await _databaseService
          .updateOrderStatus(

        orderId:
            orderId,

        status:
            status,
      );

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
  // GET ORDER BY ID
  // =====================================================

  OrderModel? getOrderById(
    String orderId,
  ) {

    try {

      return _orders.firstWhere(
        (order) =>
            order.orderId ==
            orderId,
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