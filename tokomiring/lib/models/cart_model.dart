// lib/models/cart_model.dart

import 'product_model.dart';

class CartModel {

  final String productId;

  final String productName;

  final String productImage;

  final double productPrice;

  final int quantity;

  final int stock;

  final double subtotal;

  final DateTime createdAt;

  CartModel({

    required this.productId,

    required this.productName,

    required this.productImage,

    required this.productPrice,

    required this.quantity,

    required this.stock,

    required this.subtotal,

    required this.createdAt,
  });

  // =====================================================
  // FROM PRODUCT
  // =====================================================

  factory CartModel.fromProduct({

    required ProductModel product,

    int quantity = 1,

  }) {

    return CartModel(

      productId:
          product.id,

      productName:
          product.name,

      productImage:
          product.imageBase64,

      productPrice:
          product.price,

      quantity:
          quantity,

      stock:
          product.stock,

      subtotal:
          product.price *
              quantity,

      createdAt:
          DateTime.now(),
    );
  }

  // =====================================================
  // FROM MAP
  // =====================================================

  factory CartModel.fromMap(
    Map<dynamic, dynamic> map,
  ) {

    return CartModel(

      productId:
          map['productId']
                  ?.toString() ??
              '',

      productName:
          map['productName']
                  ?.toString() ??
              '',

      productImage:
          map['productImage']
                  ?.toString() ??

              map['imageBase64']
                      ?.toString() ??
                  '',

      productPrice:
          _safeDouble(
        map['productPrice'] ??

            map['price'],
      ),

      quantity:
          _safeInt(
        map['quantity'],
      ),

      stock:
          _safeInt(
        map['stock'],
      ),

      subtotal:
          _safeDouble(
        map['subtotal'],
      ),

      createdAt:
          _safeDate(
        map['createdAt'],
      ),
    );
  }

  // =====================================================
  // TO MAP
  // =====================================================

  Map<String, dynamic> toMap() {

    return {

      'productId':
          productId,

      'productName':
          productName,

      'productImage':
          productImage,

      'productPrice':
          productPrice,

      'quantity':
          quantity,

      'stock':
          stock,

      'subtotal':
          subtotal,

      'createdAt':
          createdAt
              .toIso8601String(),
    };
  }

  // =====================================================
  // TOTAL PRICE
  // =====================================================

  double get totalPrice {

    return productPrice *
        quantity;
  }

  // =====================================================
  // STOCK CHECK
  // =====================================================

  bool get inStock {

    return stock > 0;
  }

  bool get lowStock {

    return stock <= 5;
  }

  // =====================================================
  // FORMAT PRICE
  // =====================================================

  String get formattedPrice {

    return 'Rp ${productPrice.toStringAsFixed(0)}';
  }

  String get formattedSubtotal {

    return 'Rp ${subtotal.toStringAsFixed(0)}';
  }

  // =====================================================
  // COPY WITH
  // =====================================================

  CartModel copyWith({

    String? productId,

    String? productName,

    String? productImage,

    double? productPrice,

    int? quantity,

    int? stock,

    double? subtotal,

    DateTime? createdAt,

  }) {

    final updatedPrice =
        productPrice ??
            this.productPrice;

    final updatedQty =
        quantity ??
            this.quantity;

    return CartModel(

      productId:
          productId ??
              this.productId,

      productName:
          productName ??
              this.productName,

      productImage:
          productImage ??
              this.productImage,

      productPrice:
          updatedPrice,

      quantity:
          updatedQty,

      stock:
          stock ?? this.stock,

      subtotal:
          subtotal ??

              (updatedPrice *
                  updatedQty),

      createdAt:
          createdAt ??
              this.createdAt,
    );
  }

  // =====================================================
  // EQUALITY
  // =====================================================

  @override
  bool operator ==(
    Object other,
  ) {

    if (identical(
      this,
      other,
    )) {

      return true;
    }

    return other is CartModel &&

        other.productId ==
            productId &&

        other.quantity ==
            quantity;
  }

  // =====================================================
  // HASHCODE
  // =====================================================

  @override
  int get hashCode {

    return productId.hashCode ^

        quantity.hashCode;
  }

  // =====================================================
  // DEBUG
  // =====================================================

  @override
  String toString() {

    return '''

CartModel(
  productId: $productId,
  productName: $productName,
  quantity: $quantity,
  subtotal: $subtotal
)

''';
  }
}

// =======================================================
// SAFE PARSERS
// =======================================================

double _safeDouble(
  dynamic value,
) {

  if (value == null) {
    return 0;
  }

  if (value is double) {
    return value;
  }

  if (value is int) {
    return value.toDouble();
  }

  return double.tryParse(
        value.toString(),
      ) ??
      0;
}

int _safeInt(
  dynamic value,
) {

  if (value == null) {
    return 0;
  }

  if (value is int) {
    return value;
  }

  return int.tryParse(
        value.toString(),
      ) ??
      0;
}

DateTime _safeDate(
  dynamic value,
) {

  if (value == null) {

    return DateTime.now();
  }

  try {

    if (value is int) {

      return DateTime
          .fromMillisecondsSinceEpoch(
        value,
      );
    }

    return DateTime.parse(
      value.toString(),
    );

  } catch (_) {

    return DateTime.now();
  }
}