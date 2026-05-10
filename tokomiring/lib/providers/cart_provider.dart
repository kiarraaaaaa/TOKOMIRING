// lib/providers/cart_provider.dart

import 'package:flutter/material.dart';

import '../models/product_model.dart';

class CartItemModel {
  final ProductModel product;
  int quantity;

  CartItemModel({
    required this.product,
    required this.quantity,
  });

  double get subtotal =>
      product.price * quantity;
}

class CartProvider extends ChangeNotifier {
  // =====================================================
  // CART ITEMS
  // =====================================================

  final List<CartItemModel> _items = [];

  List<CartItemModel> get items => _items;

  // =====================================================
  // TOTAL ITEMS
  // =====================================================

  int get totalItems {
    int total = 0;

    for (var item in _items) {
      total += item.quantity;
    }

    return total;
  }

  // =====================================================
  // TOTAL PRICE
  // =====================================================

  double get totalPrice {
    double total = 0;

    for (var item in _items) {
      total += item.subtotal;
    }

    return total;
  }

  // =====================================================
  // CHECK EMPTY
  // =====================================================

  bool get isEmpty => _items.isEmpty;

  bool get isNotEmpty => _items.isNotEmpty;

  // =====================================================
  // ADD TO CART
  // =====================================================

  void addToCart(
    ProductModel product,
  ) {
    final index = _items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(
        CartItemModel(
          product: product,
          quantity: 1,
        ),
      );
    }

    notifyListeners();
  }

  // =====================================================
  // REMOVE FROM CART
  // =====================================================

  void removeFromCart(
    String productId,
  ) {
    _items.removeWhere(
      (item) => item.product.id == productId,
    );

    notifyListeners();
  }

  // =====================================================
  // INCREASE QUANTITY
  // =====================================================

  void increaseQuantity(
    String productId,
  ) {
    final index = _items.indexWhere(
      (item) => item.product.id == productId,
    );

    if (index >= 0) {
      _items[index].quantity++;

      notifyListeners();
    }
  }

  // =====================================================
  // DECREASE QUANTITY
  // =====================================================

  void decreaseQuantity(
    String productId,
  ) {
    final index = _items.indexWhere(
      (item) => item.product.id == productId,
    );

    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }

      notifyListeners();
    }
  }

  // =====================================================
  // UPDATE QUANTITY
  // =====================================================

  void updateQuantity({
    required String productId,
    required int quantity,
  }) {
    final index = _items.indexWhere(
      (item) => item.product.id == productId,
    );

    if (index >= 0) {
      _items[index].quantity = quantity;

      notifyListeners();
    }
  }

  // =====================================================
  // CHECK PRODUCT IN CART
  // =====================================================

  bool isInCart(
    String productId,
  ) {
    return _items.any(
      (item) => item.product.id == productId,
    );
  }

  // =====================================================
  // GET PRODUCT QUANTITY
  // =====================================================

  int getQuantity(
    String productId,
  ) {
    final index = _items.indexWhere(
      (item) => item.product.id == productId,
    );

    if (index >= 0) {
      return _items[index].quantity;
    }

    return 0;
  }

  // =====================================================
  // CLEAR CART
  // =====================================================

  void clearCart() {
    _items.clear();

    notifyListeners();
  }

  // =====================================================
  // GET CART MAP
  // =====================================================

  List<Map<String, dynamic>> toMap() {
    return _items.map((item) {
      return {
        'productId': item.product.id,

        'productName': item.product.name,

        'productImage': item.product.imageUrl,

        'productPrice': item.product.price,

        'quantity': item.quantity,

        'subtotal': item.subtotal,
      };
    }).toList();
  }
}