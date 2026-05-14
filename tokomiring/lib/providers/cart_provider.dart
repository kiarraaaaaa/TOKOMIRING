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

  // =====================================================
  // SUBTOTAL
  // =====================================================

  double get subtotal =>

      product.price *
          quantity;

  // =====================================================
  // PRODUCT ID
  // =====================================================

  String get productId =>

      product.id;

  // =====================================================
  // PRODUCT NAME
  // =====================================================

  String get productName =>

      product.name;

  // =====================================================
  // PRODUCT IMAGE
  // =====================================================

  String get productImage =>

      product.imageBase64;

  // =====================================================
  // PRODUCT PRICE
  // =====================================================

  double get productPrice =>

      product.price;

  // =====================================================
  // COPY WITH
  // =====================================================

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

  // =====================================================
  // CART ITEMS
  // =====================================================

  final List<CartItemModel>
      _items = [];

  List<CartItemModel> get items =>

      List.unmodifiable(
        _items,
      );

  // =====================================================
  // TOTAL ITEMS
  // =====================================================

  int get totalItems {

    int total = 0;

    for (final item
        in _items) {

      total += item.quantity;
    }

    return total;
  }

  // =====================================================
  // TOTAL PRICE
  // =====================================================

  double get totalPrice {

    double total = 0;

    for (final item
        in _items) {

      total += item.subtotal;
    }

    return total;
  }

  // =====================================================
  // TOTAL UNIQUE PRODUCTS
  // =====================================================

  int get totalUniqueProducts =>

      _items.length;

  // =====================================================
  // EMPTY CHECK
  // =====================================================

  bool get isEmpty =>

      _items.isEmpty;

  bool get isNotEmpty =>

      _items.isNotEmpty;

  // =====================================================
  // ADD TO CART
  // =====================================================

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

    if (index >= 0) {

      final currentItem =
          _items[index];

      if (currentItem.quantity <
          product.stock) {

        currentItem.quantity++;

        notifyListeners();
      }

      return;
    }

    _items.add(

      CartItemModel(

        product:
            product,

        quantity:
            1,
      ),
    );

    notifyListeners();
  }

  // =====================================================
  // REMOVE ITEM
  // =====================================================

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

  // =====================================================
  // INCREASE QUANTITY
  // =====================================================

  void increaseQuantity(
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

    if (item.quantity <
        item.product.stock) {

      item.quantity++;

      notifyListeners();
    }
  }

  // =====================================================
  // DECREASE QUANTITY
  // =====================================================

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

  // =====================================================
  // UPDATE QUANTITY
  // =====================================================

  void updateQuantity({

    required String productId,

    required int quantity,

  }) {

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

    if (quantity <= 0) {

      _items.removeAt(index);

      notifyListeners();

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

  // =====================================================
  // REPLACE PRODUCT
  // =====================================================

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

      product:
          product,

      quantity:
          oldQty >
                  product.stock
              ? product.stock
              : oldQty,
    );

    notifyListeners();
  }

  // =====================================================
  // CHECK PRODUCT
  // =====================================================

  bool isInCart(
    String productId,
  ) {

    return _items.any(

      (item) =>

          item.product.id ==
          productId,
    );
  }

  // =====================================================
  // GET QUANTITY
  // =====================================================

  int getQuantity(
    String productId,
  ) {

    final index =
        _items.indexWhere(

      (item) =>

          item.product.id ==
          productId,
    );

    if (index >= 0) {

      return _items[index]
          .quantity;
    }

    return 0;
  }

  // =====================================================
  // GET ITEM
  // =====================================================

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

  // =====================================================
  // CLEAR CART
  // =====================================================

  void clearCart() {

    _items.clear();

    notifyListeners();
  }

  // =====================================================
  // CART MAP
  // =====================================================

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
              item.product
                  .imageBase64,

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

  // =====================================================
  // CART TOTAL SUBTOTAL
  // =====================================================

  double calculateSubtotal() {

    double total = 0;

    for (final item
        in _items) {

      total += item.subtotal;
    }

    return total;
  }

  // =====================================================
  // SHIPPING
  // =====================================================

  double calculateShipping({

    double shippingCost = 10000,

  }) {

    if (_items.isEmpty) {

      return 0;
    }

    return shippingCost;
  }

  // =====================================================
  // GRAND TOTAL
  // =====================================================

  double calculateGrandTotal({

    double shippingCost = 10000,

  }) {

    return calculateSubtotal() +

        calculateShipping(
          shippingCost:
              shippingCost,
        );
  }

  // =====================================================
  // DEBUG
  // =====================================================

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