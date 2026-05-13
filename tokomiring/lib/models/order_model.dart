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

  factory OrderItemModel.fromMap(
    Map<dynamic, dynamic> map,
  ) {

    return OrderItemModel(

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
              '',

      productPrice:
          _safeDouble(
        map['productPrice'],
      ),

      quantity:
          _safeInt(
        map['quantity'],
      ),

      subtotal:
          _safeDouble(
        map['subtotal'],
      ),
    );
  }

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

  OrderItemModel copyWith({

    String? productId,

    String? productName,

    String? productImage,

    double? productPrice,

    int? quantity,

    double? subtotal,

  }) {

    return OrderItemModel(

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
          productPrice ??
              this.productPrice,

      quantity:
          quantity ??
              this.quantity,

      subtotal:
          subtotal ??
              this.subtotal,
    );
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

  final DateTime? completedAt;

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

    this.completedAt,
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

    final rawItems =
        map['items'];

    if (rawItems != null) {

      try {

        if (rawItems is List) {

          parsedItems =
              rawItems

                  .where(
                    (
                      item,
                    ) {

                      return item !=
                          null;
                    },
                  )

                  .map(
                    (
                      item,
                    ) {

                      return OrderItemModel
                          .fromMap(

                        Map<dynamic,
                            dynamic>.from(
                          item,
                        ),
                      );
                    },
                  )

                  .toList();
        }

        else if (rawItems
            is Map) {

          parsedItems =
              rawItems.values

                  .where(
                    (
                      item,
                    ) {

                      return item !=
                          null;
                    },
                  )

                  .map(
                    (
                      item,
                    ) {

                      return OrderItemModel
                          .fromMap(

                        Map<dynamic,
                            dynamic>.from(
                          item,
                        ),
                      );
                    },
                  )

                  .toList();
        }

      } catch (_) {

        parsedItems = [];
      }
    }

    return OrderModel(

      orderId:
          orderId,

      userId:
          map['userId']
                  ?.toString() ??
              '',

      customerName:
          map['customerName']
                  ?.toString() ??
              '',

      customerPhone:
          map['customerPhone']
                  ?.toString() ??
              '',

      address:
          map['address']
                  ?.toString() ??
              '',

      items:
          parsedItems,

      totalPrice:
          _safeDouble(
        map['totalPrice'],
      ),

      totalItems:
          _safeInt(
        map['totalItems'],
      ),

      paymentMethod:
          map['paymentMethod']
                  ?.toString() ??
              'Cash',

      paymentProof:
          map['paymentProof']
                  ?.toString() ??
              '',

      status:
          map['status']
                  ?.toString() ??
              'Waiting Admin Validation',

      isValidated:
          map['isValidated'] ??
              false,

      createdAt:
          _safeDate(
        map['createdAt'],
      ),

      updatedAt:
          _safeDate(
        map['updatedAt'],
      ),

      completedAt:
          map['completedAt'] ==
                  null

              ? null

              : _safeDate(
                  map['completedAt'],
                ),
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
                (
                  e,
                ) {

                  return e.toMap();
                },
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

      'completedAt':
          completedAt
              ?.toIso8601String(),
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

    DateTime? completedAt,
  }) {

    return OrderModel(

      orderId:
          orderId ??
              this.orderId,

      userId:
          userId ??
              this.userId,

      customerName:
          customerName ??
              this.customerName,

      customerPhone:
          customerPhone ??
              this.customerPhone,

      address:
          address ??
              this.address,

      items:
          items ??
              this.items,

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
          status ??
              this.status,

      isValidated:
          isValidated ??
              this.isValidated,

      createdAt:
          createdAt ??
              this.createdAt,

      updatedAt:
          updatedAt ??
              this.updatedAt,

      completedAt:
          completedAt ??
              this.completedAt,
    );
  }

  @override
  String toString() {

    return 'OrderModel(orderId: $orderId, customer: $customerName, total: $totalPrice)';
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

    return DateTime.parse(
      value.toString(),
    );

  } catch (_) {

    return DateTime.now();
  }
}