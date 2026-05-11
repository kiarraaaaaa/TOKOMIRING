// lib/models/order_model.dart

class OrderItemModel {
  final String productId;
  final String productName;
  final String productImage;

  final double productPrice;

  final int quantity;

  final double subtotal;

  OrderItemModel({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.quantity,
    required this.subtotal,
  });

  // =====================================================
  // FROM MAP
  // =====================================================

  factory OrderItemModel.fromMap(
    Map<dynamic, dynamic> map,
  ) {
    return OrderItemModel(
      productId:
          map['productId'] ?? '',

      productName:
          map['productName'] ?? '',

      productImage:
          map['productImage'] ?? '',

      productPrice:
          (map['productPrice'] ?? 0)
              .toDouble(),

      quantity:
          map['quantity'] ?? 0,

      subtotal:
          (map['subtotal'] ?? 0)
              .toDouble(),
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

      'subtotal':
          subtotal,
    };
  }
}

// =======================================================
// ORDER MODEL
// =======================================================

class OrderModel {

  final String orderId;

  final String userId;

  final String customerName;

  final String customerPhone;

  final String address;

  final List<OrderItemModel>
      items;

  final double totalPrice;

  final int totalItems;

  final String paymentMethod;

  final String paymentProof;

  final String status;

  final bool isValidated;

  final DateTime createdAt;

  final DateTime updatedAt;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.customerName,
    required this.customerPhone,
    required this.address,
    required this.items,
    required this.totalPrice,
    required this.totalItems,
    required this.paymentMethod,
    required this.paymentProof,
    required this.status,
    required this.isValidated,
    required this.createdAt,
    required this.updatedAt,
  });

  // =====================================================
  // FROM MAP
  // =====================================================

  factory OrderModel.fromMap(
    Map<dynamic, dynamic> map,
    String orderId,
  ) {

    List<OrderItemModel>
        parsedItems = [];

    // ===================================================
    // SAFE PARSE ITEMS
    // ===================================================

    if (map['items'] != null) {

      final rawItems =
          map['items'];

      // ===============================================
      // IF LIST
      // ===============================================

      if (rawItems is List) {

        parsedItems = rawItems

            .where(
              (item) => item != null,
            )

            .map(
              (item) {

                return OrderItemModel
                    .fromMap(
                  Map<dynamic, dynamic>
                      .from(item),
                );
              },
            )

            .toList();
      }

      // ===============================================
      // IF MAP
      // ===============================================

      else if (rawItems is Map) {

        parsedItems = rawItems.values

            .map(
              (item) {

                return OrderItemModel
                    .fromMap(
                  Map<dynamic, dynamic>
                      .from(item),
                );
              },
            )

            .toList();
      }
    }

    return OrderModel(
      orderId:
          orderId,

      userId:
          map['userId'] ?? '',

      customerName:
          map['customerName'] ?? '',

      customerPhone:
          map['customerPhone'] ?? '',

      address:
          map['address'] ?? '',

      items:
          parsedItems,

      totalPrice:
          (map['totalPrice'] ?? 0)
              .toDouble(),

      totalItems:
          map['totalItems'] ?? 0,

      paymentMethod:
          map['paymentMethod'] ??
              'Cash',

      paymentProof:
          map['paymentProof'] ?? '',

      status:
          map['status'] ??
              'Waiting Admin Validation',

      isValidated:
          map['isValidated'] ??
              false,

      createdAt:
          DateTime.tryParse(
                map['createdAt']
                        ?.toString() ??
                    '',
              ) ??
              DateTime.now(),

      updatedAt:
          DateTime.tryParse(
                map['updatedAt']
                        ?.toString() ??
                    '',
              ) ??
              DateTime.now(),
    );
  }

  // =====================================================
  // TO MAP
  // =====================================================

  Map<String, dynamic> toMap() {
    return {
      'orderId':
          orderId,

      'userId':
          userId,

      'customerName':
          customerName,

      'customerPhone':
          customerPhone,

      'address':
          address,

      'items':
          items
              .map(
                (e) => e.toMap(),
              )
              .toList(),

      'totalPrice':
          totalPrice,

      'totalItems':
          totalItems,

      'paymentMethod':
          paymentMethod,

      'paymentProof':
          paymentProof,

      'status':
          status,

      'isValidated':
          isValidated,

      'createdAt':
          createdAt
              .toIso8601String(),

      'updatedAt':
          updatedAt
              .toIso8601String(),
    };
  }

  // =====================================================
  // COPY WITH
  // =====================================================

  OrderModel copyWith({
    String? orderId,
    String? userId,
    String? customerName,
    String? customerPhone,
    String? address,
    List<OrderItemModel>? items,
    double? totalPrice,
    int? totalItems,
    String? paymentMethod,
    String? paymentProof,
    String? status,
    bool? isValidated,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {

    return OrderModel(
      orderId:
          orderId ?? this.orderId,

      userId:
          userId ?? this.userId,

      customerName:
          customerName ??
              this.customerName,

      customerPhone:
          customerPhone ??
              this.customerPhone,

      address:
          address ?? this.address,

      items:
          items ?? this.items,

      totalPrice:
          totalPrice ??
              this.totalPrice,

      totalItems:
          totalItems ??
              this.totalItems,

      paymentMethod:
          paymentMethod ??
              this.paymentMethod,

      paymentProof:
          paymentProof ??
              this.paymentProof,

      status:
          status ?? this.status,

      isValidated:
          isValidated ??
              this.isValidated,

      createdAt:
          createdAt ??
              this.createdAt,

      updatedAt:
          updatedAt ??
              this.updatedAt,
    );
  }
}