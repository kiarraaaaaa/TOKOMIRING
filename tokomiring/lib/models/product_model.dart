// lib/models/product_model.dart

class ProductModel {

  final String id;

  final String name;

  final String description;

  final String category;

  // =====================================================
  // BASE64 IMAGE
  // =====================================================

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
          map['name'] ?? '',

      description:
          map['description'] ?? '',

      category:
          map['category'] ?? '',

      imageBase64:
          map['imageBase64'] ?? '',

      price:
          (map['price'] ?? 0)
              .toDouble(),

      stock:
          map['stock'] ?? 0,

      isAvailable:
          map['isAvailable'] ?? true,

      isPopular:
          map['isPopular'] ?? false,

      sold:
          map['sold'] ?? 0,

      createdAt:
          DateTime.tryParse(
                map['createdAt']
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

  bool get inStock =>
      stock > 0;

  bool get lowStock =>
      stock <= 5;

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
}