// =====================================================
// lib/providers/cart_provider.dart
// CLEAN OPTIMIZED RESPONSIVE VERSION
// =====================================================

import 'package:flutter/material.dart';

import '../models/product_model.dart';

class CartItemModel {

  final ProductModel product;

  int quantity;

  CartItemModel({

    required this.product,

    required this.quantity,
  });

  // =========================================
  // SUBTOTAL
  // =========================================

  double get subtotal =>

      product.price * quantity;

  // =========================================
  // PRODUCT INFO
  // =========================================

  String get productId => product.id;

  String get productName => product.name;

  String get productImage =>
      product.imageBase64;

  double get productPrice =>
      product.price;

  // =========================================
  // COPY WITH
  // =========================================

  CartItemModel copyWith({

    ProductModel? product,

    int? quantity,
  }) {

    return CartItemModel(

      product:
          product ?? this.product,

      quantity:
          quantity ?? this.quantity,
    );
  }
}

class CartProvider
    extends ChangeNotifier {

  // =========================================
  // ITEMS
  // =========================================

  final List<CartItemModel>
      _items = [];

  List<CartItemModel> get items =>

      List.unmodifiable(
        _items,
      );

  // =========================================
  // TOTAL ITEMS
  // =========================================

  int get totalItems {

    return _items.fold(

      0,

      (total, item) =>

          total + item.quantity,
    );
  }

  // =========================================
  // TOTAL PRICE
  // =========================================

  double get totalPrice {

    return _items.fold(

      0,

      (total, item) =>

          total + item.subtotal,
    );
  }

  // =========================================
  // UNIQUE PRODUCTS
  // =========================================

  int get totalUniqueProducts =>

      _items.length;

  // =========================================
  // EMPTY
  // =========================================

  bool get isEmpty =>

      _items.isEmpty;

  bool get isNotEmpty =>

      _items.isNotEmpty;

  // =========================================
  // ADD TO CART
  // =========================================

  void addToCart(
    ProductModel product,
  ) {

    if (product.stock <= 0) {
      return;
    }

    final index =
        _items.indexWhere(

      (item) =>

          item.product.id ==
          product.id,
    );

    // ===============================
    // EXISTING ITEM
    // ===============================

    if (index >= 0) {

      final currentItem =
          _items[index];

      if (currentItem.quantity <
          product.stock) {

        currentItem.quantity++;
      }

      notifyListeners();

      return;
    }

    // ===============================
    // NEW ITEM
    // ===============================

    _items.add(

      CartItemModel(

        product: product,

        quantity: 1,
      ),
    );

    notifyListeners();
  }

  // =========================================
  // REMOVE ITEM
  // =========================================

  void removeFromCart(
    String productId,
  ) {

    _items.removeWhere(

      (item) =>

          item.product.id ==
          productId,
    );

    notifyListeners();
  }

  // =========================================
  // INCREASE QUANTITY
  // =========================================

  void increaseQuantity(
    String productId,
  ) {

    final item =
        getItem(productId);

    if (item == null) {
      return;
    }

    if (item.quantity <
        item.product.stock) {

      item.quantity++;

      notifyListeners();
    }
  }

  // =========================================
  // DECREASE QUANTITY
  // =========================================

  void decreaseQuantity(
    String productId,
  ) {

    final index =
        _items.indexWhere(

      (item) =>

          item.product.id ==
          productId,
    );

    if (index < 0) {
      return;
    }

    final item =
        _items[index];

    if (item.quantity <= 1) {

      _items.removeAt(index);

    } else {

      item.quantity--;
    }

    notifyListeners();
  }

  // =========================================
  // UPDATE QUANTITY
  // =========================================

  void updateQuantity({

    required String productId,

    required int quantity,
  }) {

    final item =
        getItem(productId);

    if (item == null) {
      return;
    }

    if (quantity <= 0) {

      removeFromCart(
        productId,
      );

      return;
    }

    if (quantity >
        item.product.stock) {

      quantity =
          item.product.stock;
    }

    item.quantity =
        quantity;

    notifyListeners();
  }

  // =========================================
  // REPLACE PRODUCT
  // =========================================

  void replaceProduct({

    required ProductModel product,
  }) {

    final index =
        _items.indexWhere(

      (item) =>

          item.product.id ==
          product.id,
    );

    if (index < 0) {
      return;
    }

    final oldQty =
        _items[index]
            .quantity;

    _items[index] =
        CartItemModel(

      product: product,

      quantity:
          oldQty > product.stock

              ? product.stock

              : oldQty,
    );

    notifyListeners();
  }

  // =========================================
  // CHECK ITEM
  // =========================================

  bool isInCart(
    String productId,
  ) {

    return _items.any(

      (item) =>

          item.product.id ==
          productId,
    );
  }

  // =========================================
  // GET QUANTITY
  // =========================================

  int getQuantity(
    String productId,
  ) {

    final item =
        getItem(productId);

    return item?.quantity ?? 0;
  }

  // =========================================
  // GET ITEM
  // =========================================

  CartItemModel? getItem(
    String productId,
  ) {

    try {

      return _items.firstWhere(

        (item) =>

            item.product.id ==
            productId,
      );

    } catch (_) {

      return null;
    }
  }

  // =========================================
  // CLEAR CART
  // =========================================

  void clearCart() {

    _items.clear();

    notifyListeners();
  }

  // =========================================
  // MAP
  // =========================================

  List<Map<String, dynamic>>
      toMap() {

    return _items.map(

      (item) {

        return {

          'productId':
              item.product.id,

          'productName':
              item.product.name,

          'productImage':
              item.product.imageBase64,

          'productPrice':
              item.product.price,

          'quantity':
              item.quantity,

          'subtotal':
              item.subtotal,
        };
      },
    ).toList();
  }

  // =========================================
  // SUBTOTAL
  // =========================================

  double calculateSubtotal() {

    return totalPrice;
  }

  // =========================================
  // SHIPPING
  // =========================================

  double calculateShipping({

    double shippingCost = 10000,
  }) {

    if (_items.isEmpty) {
      return 0;
    }

    return shippingCost;
  }

  // =========================================
  // GRAND TOTAL
  // =========================================

  double calculateGrandTotal({

    double shippingCost = 10000,
  }) {

    return calculateSubtotal() +

        calculateShipping(
          shippingCost:
              shippingCost,
        );
  }

  // =========================================
  // DEBUG
  // =========================================

  @override
  String toString() {

    return '''

CartProvider(
  totalItems: $totalItems,
  totalPrice: $totalPrice,
  uniqueProducts: $totalUniqueProducts
)

''';
  }
}