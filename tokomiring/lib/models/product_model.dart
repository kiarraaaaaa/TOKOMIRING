// lib/models/product_model.dart

class ProductModel {
  final String id;
  final String name;
  final String description;
  final String category;
  final String imageUrl;
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
    required this.imageUrl,
    required this.price,
    required this.stock,
    required this.isAvailable,
    required this.isPopular,
    required this.sold,
    required this.createdAt,
  });

  factory ProductModel.fromMap(
    Map<dynamic, dynamic> map,
    String id,
  ) {
    return ProductModel(
      id: id,

      name: map['name'] ?? '',

      description: map['description'] ?? '',

      category: map['category'] ?? '',

      imageUrl: map['imageUrl'] ?? '',

      price: (map['price'] ?? 0).toDouble(),

      stock: map['stock'] ?? 0,

      isAvailable: map['isAvailable'] ?? true,

      isPopular: map['isPopular'] ?? false,

      sold: map['sold'] ?? 0,

      createdAt: DateTime.tryParse(
            map['createdAt'] ?? '',
          ) ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,

      'name': name,

      'description': description,

      'category': category,

      'imageUrl': imageUrl,

      'price': price,

      'stock': stock,

      'isAvailable': isAvailable,

      'isPopular': isPopular,

      'sold': sold,

      'createdAt': createdAt.toIso8601String(),
    };
  }

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    String? imageUrl,
    double? price,
    int? stock,
    bool? isAvailable,
    bool? isPopular,
    int? sold,
    DateTime? createdAt,
  }) {
    return ProductModel(
      id: id ?? this.id,

      name: name ?? this.name,

      description: description ?? this.description,

      category: category ?? this.category,

      imageUrl: imageUrl ?? this.imageUrl,

      price: price ?? this.price,

      stock: stock ?? this.stock,

      isAvailable: isAvailable ?? this.isAvailable,

      isPopular: isPopular ?? this.isPopular,

      sold: sold ?? this.sold,

      createdAt: createdAt ?? this.createdAt,
    );
  }
}