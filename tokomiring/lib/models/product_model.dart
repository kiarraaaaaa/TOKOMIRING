class ProductModel {

  final String id;

  final String name;

  final String description;

  final String category;

  final String imageBase64;

  final double price;

  final int stock;

  final bool isAvailable;

  final bool isPopular;

  final int sold;

  final DateTime createdAt;

  ProductModel({

    required this.id,

    required this.name,

    required this.description,

    required this.category,

    required this.imageBase64,

    required this.price,

    required this.stock,

    required this.isAvailable,

    required this.isPopular,

    required this.sold,

    required this.createdAt,
  });

  // =====================================================
  // FROM MAP
  // =====================================================

  factory ProductModel.fromMap(

    Map<dynamic, dynamic> map,

    String id,
  ) {

    return ProductModel(

      id:
          id,

      name:
          map['name']
                  ?.toString() ??
              '',

      description:
          map['description']
                  ?.toString() ??
              '',

      category:
          map['category']
                  ?.toString() ??
              'Others',

      imageBase64:
          map['imageBase64']
                  ?.toString() ??
              '',

      price:
          _safeDouble(
        map['price'],
      ),

      stock:
          _safeInt(
        map['stock'],
      ),

      isAvailable:
          map['isAvailable'] ??
              true,

      isPopular:
          map['isPopular'] ??
              false,

      // ===============================================
      // SOLD AUTO SAFE
      // ===============================================

      sold:
          _safeInt(
        map['sold'] ?? 0,
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

      'id':
          id,

      'name':
          name,

      'description':
          description,

      'category':
          category,

      'imageBase64':
          imageBase64,

      'price':
          price,

      'stock':
          stock,

      'isAvailable':
          isAvailable,

      'isPopular':
          isPopular,

      // ===============================================
      // SOLD REALTIME
      // ===============================================

      'sold':
          sold,

      'createdAt':
          createdAt
              .toIso8601String(),
    };
  }

  // =====================================================
  // CHECK STOCK
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

    return 'Rp ${price.toStringAsFixed(0)}';
  }

  // =====================================================
  // COPY WITH
  // =====================================================

  ProductModel copyWith({

    String? id,

    String? name,

    String? description,

    String? category,

    String? imageBase64,

    double? price,

    int? stock,

    bool? isAvailable,

    bool? isPopular,

    int? sold,

    DateTime? createdAt,

  }) {

    return ProductModel(

      id:
          id ?? this.id,

      name:
          name ?? this.name,

      description:
          description ??
              this.description,

      category:
          category ??
              this.category,

      imageBase64:
          imageBase64 ??
              this.imageBase64,

      price:
          price ?? this.price,

      stock:
          stock ?? this.stock,

      isAvailable:
          isAvailable ??
              this.isAvailable,

      isPopular:
          isPopular ??
              this.isPopular,

      sold:
          sold ?? this.sold,

      createdAt:
          createdAt ??
              this.createdAt,
    );
  }

  // =====================================================
  // REALTIME PRODUCT JSON DEBUG
  // =====================================================

  @override
  String toString() {

    return 'ProductModel(id: $id, name: $name, stock: $stock, sold: $sold)';
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