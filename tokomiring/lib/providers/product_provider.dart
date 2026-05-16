// =====================================================
// lib/providers/product_provider.dart
// FINAL CLEAN OPTIMIZED PREMIUM VERSION
// FIXED REALTIME + NOTIFY + REFRESH VERSION
// =====================================================

import 'dart:async';

import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../services/database_service.dart';

class ProductProvider
    extends ChangeNotifier {

  // =========================================
  // SERVICES
  // =========================================

  final DatabaseService
      _databaseService =
      DatabaseService();

  // =========================================
  // VARIABLES
  // =========================================

  List<ProductModel>
      _products = [];

  List<ProductModel>
      _filteredProducts = [];

  bool _isLoading = false;

  bool _initialized = false;

  bool _isSearching = false;

  String? _errorMessage;

  String _selectedCategory =
      'All';

  String _searchQuery = '';

  StreamSubscription?
      _productSubscription;

  final Set<String>
      _wishlistIds = {};

  // =========================================
  // GETTERS
  // =========================================

  List<ProductModel> get products =>

      List.unmodifiable(
        _filteredProducts,
      );

  List<ProductModel>
      get allProducts =>

          List.unmodifiable(
            _products,
          );

  bool get isLoading =>
      _isLoading;

  bool get initialized =>
      _initialized;

  bool get isSearching =>
      _isSearching;

  String? get errorMessage =>
      _errorMessage;

  String get selectedCategory =>
      _selectedCategory;

  String get searchQuery =>
      _searchQuery;

  // =========================================
  // CATEGORIES
  // =========================================

  final List<String>
      categories = [

    'All',

    'Food',

    'Drinks',

    'Snacks',

    'Electronics',

    'Household',

    'Others',
  ];

  // =========================================
  // FAVORITES
  // =========================================

  List<ProductModel>
      get favoriteProducts {

    return _products.where(

      (product) {

        return _wishlistIds
            .contains(
          product.id,
        );
      },
    ).toList();
  }

  List<ProductModel>
      get favorites =>

          favoriteProducts;

  bool isFavorite(
    ProductModel product,
  ) {

    return _wishlistIds
        .contains(
      product.id,
    );
  }

  void toggleFavorite(
    ProductModel product,
  ) {

    if (_wishlistIds
        .contains(
      product.id,
    )) {

      _wishlistIds.remove(
        product.id,
      );

    } else {

      _wishlistIds.add(
        product.id,
      );
    }

    notifyListeners();
  }

  void clearWishlist() {

    _wishlistIds.clear();

    notifyListeners();
  }

  // =========================================
  // ANALYTICS
  // =========================================

  int get totalProducts =>

      _products.length;

  int get totalStock {

    return _products.fold(

      0,

      (
        total,
        product,
      ) {

        return total +
            product.stock;
      },
    );
  }

  int get totalSoldItems {

    return _products.fold(

      0,

      (
        total,
        product,
      ) {

        return total +
            product.sold;
      },
    );
  }

  int get totalFavorites =>

      _wishlistIds.length;

  double get totalInventoryValue {

    return _products.fold(

      0,

      (
        total,
        product,
      ) {

        return total +
            (
              product.price *
              product.stock
            );
      },
    );
  }

  // =========================================
  // PRODUCT FILTERS
  // =========================================

  List<ProductModel>
      get topSellingProducts {

    final copied =
        List<ProductModel>.from(
      _products,
    );

    copied.sort(

      (a, b) {

        return b.sold
            .compareTo(
          a.sold,
        );
      },
    );

    return copied;
  }

  List<ProductModel>
      get popularProducts {

    return _products.where(

      (product) {

        return product
            .isPopular;
      },
    ).toList();
  }

  List<ProductModel>
      get availableProducts {

    return _products.where(

      (product) {

        return product.stock >
                0 &&
            product.isAvailable;
      },
    ).toList();
  }

  List<ProductModel>
      get soldOutProducts {

    return _products.where(

      (product) {

        return product.stock <=
            0;
      },
    ).toList();
  }

  List<ProductModel>
      get lowStockProducts {

    return _products.where(

      (product) {

        return product.stock >
                0 &&
            product.stock <=
                5;
      },
    ).toList();
  }

  // =========================================
  // INITIALIZE
  // =========================================

  void initializeProducts() {

    if (_initialized) {
      return;
    }

    _initialized = true;

    _setLoading(true);

    _clearError();

    _productSubscription
        ?.cancel();

    _productSubscription =

        _databaseService
            .getProducts()
            .listen(

      (data) {

        _products = data;

        _products.sort(

          (a, b) {

            return b.createdAt
                .compareTo(
              a.createdAt,
            );
          },
        );

        _applyFilters();

        _setLoading(false);

        notifyListeners();
      },

      onError: (error) {

        _errorMessage =
            error.toString();

        _setLoading(false);

        notifyListeners();
      },
    );
  }

  // =========================================
  // REFRESH
  // =========================================

  Future<void>
      refreshProducts()
      async {

    try {

      _setLoading(true);

      final completer =
          Completer<void>();

      await _productSubscription
          ?.cancel();

      _productSubscription =

          _databaseService
              .getProducts()
              .listen(

        (data) {

          _products = data;

          _products.sort(

            (a, b) {

              return b.createdAt
                  .compareTo(
                a.createdAt,
              );
            },
          );

          _applyFilters();

          _setLoading(false);

          notifyListeners();

          if (!completer
              .isCompleted) {

            completer.complete();
          }
        },

        onError: (error) {

          _errorMessage =
              error.toString();

          _setLoading(false);

          notifyListeners();

          if (!completer
              .isCompleted) {

            completer
                .completeError(
              error,
            );
          }
        },
      );

      await completer.future;

    } catch (e) {

      _errorMessage =
          e.toString();

      _setLoading(false);

      notifyListeners();
    }
  }

  // =========================================
  // APPLY FILTER
  // =========================================

  void _applyFilters() {

    List<ProductModel>
        tempProducts =
        List.from(
      _products,
    );

    // ===============================
    // CATEGORY
    // ===============================

    if (_selectedCategory !=
        'All') {

      tempProducts = tempProducts
          .where(

        (product) {

          return product
                  .category
                  .toLowerCase() ==

              _selectedCategory
                  .toLowerCase();
        },
      ).toList();
    }

    // ===============================
    // SEARCH
    // ===============================

    if (_searchQuery
        .trim()
        .isNotEmpty) {

      final query =
          _searchQuery
              .toLowerCase();

      tempProducts = tempProducts
          .where(

        (product) {

          return product.name
                  .toLowerCase()
                  .contains(
                    query,
                  ) ||

              product.description
                  .toLowerCase()
                  .contains(
                    query,
                  ) ||

              product.category
                  .toLowerCase()
                  .contains(
                    query,
                  );
        },
      ).toList();
    }

    _filteredProducts =
        tempProducts;

    notifyListeners();
  }

  // =========================================
  // SEARCH
  // =========================================

  void searchProducts(
    String query,
  ) {

    _isSearching = true;

    _searchQuery =
        query.trim();

    _applyFilters();

    _isSearching = false;

    notifyListeners();
  }

  // =========================================
  // CATEGORY
  // =========================================

  void selectCategory(
    String category,
  ) {

    _selectedCategory =
        category;

    _applyFilters();
  }

  // =========================================
  // CLEAR FILTERS
  // =========================================

  void clearFilters() {

    _selectedCategory =
        'All';

    _searchQuery = '';

    _applyFilters();
  }

  // =========================================
  // PRODUCT BY ID
  // =========================================

  ProductModel? getProductById(
    String productId,
  ) {

    try {

      return _products.firstWhere(

        (product) {

          return product.id ==
              productId;
        },
      );

    } catch (_) {

      return null;
    }
  }

  // =========================================
  // STOCK CHECK
  // =========================================

  bool hasEnoughStock({

    required String productId,

    required int quantity,
  }) {

    final product =
        getProductById(
      productId,
    );

    if (product == null) {
      return false;
    }

    return product.stock >=
        quantity;
  }

  // =========================================
  // ADD PRODUCT
  // =========================================

  Future<bool> addProduct(
    ProductModel product,
  ) async {

    try {

      _setLoading(true);

      _clearError();

      await _databaseService
          .addProduct(
        product,
      );

      final exist =
          _products.any(

        (p) {

          return p.id ==
              product.id;
        },
      );

      if (!exist) {

        _products.add(
          product,
        );
      }

      _applyFilters();

      notifyListeners();

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

  // =========================================
  // UPDATE PRODUCT
  // =========================================

  Future<bool> updateProduct(
    ProductModel product,
  ) async {

    try {

      _setLoading(true);

      _clearError();

      await _databaseService
          .updateProduct(
        product,
      );

      final index =
          _products.indexWhere(

        (p) {

          return p.id ==
              product.id;
        },
      );

      if (index != -1) {

        _products[index] =
            product;
      }

      _applyFilters();

      notifyListeners();

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

  // =========================================
  // DELETE PRODUCT
  // =========================================

  Future<bool> deleteProduct(
    String productId,
  ) async {

    try {

      _setLoading(true);

      _clearError();

      await _databaseService
          .deleteProduct(
        productId,
      );

      _products.removeWhere(

        (product) {

          return product.id ==
              productId;
        },
      );

      _wishlistIds.remove(
        productId,
      );

      _applyFilters();

      notifyListeners();

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

  // =========================================
  // UPDATE STOCK
  // =========================================

  Future<bool> updateStock({

    required String productId,

    required int stock,
  }) async {

    try {

      final safeStock =
          stock < 0
              ? 0
              : stock;

      await _databaseService
          .updateStock(

        productId:
            productId,

        stock:
            safeStock,
      );

      final index =
          _products.indexWhere(

        (product) {

          return product.id ==
              productId;
        },
      );

      if (index != -1) {

        _products[index] =
            _products[index]
                .copyWith(

          stock:
              safeStock,

          isAvailable:
              safeStock > 0,
        );
      }

      _applyFilters();

      notifyListeners();

      return true;

    } catch (e) {

      _errorMessage =
          e.toString();

      notifyListeners();

      return false;
    }
  }

  // =========================================
  // REDUCE STOCK
  // =========================================

  Future<bool> reduceStock({

    required String productId,

    required int quantity,
  }) async {

    try {

      final product =
          getProductById(
        productId,
      );

      if (product == null) {

        _errorMessage =
            'Product not found';

        notifyListeners();

        return false;
      }

      if (quantity <= 0) {

        _errorMessage =
            'Invalid quantity';

        notifyListeners();

        return false;
      }

      if (product.stock <
          quantity) {

        _errorMessage =
            'Stock not enough';

        notifyListeners();

        return false;
      }

      final newStock =
          product.stock -
              quantity;

      final newSold =
          product.sold +
              quantity;

      await _databaseService
          .updateProduct(
            product.copyWith(
              stock: newStock,
              sold: newSold,
              isAvailable: newStock > 0,
            ),
          );

      final index =
          _products.indexWhere(

        (p) {

          return p.id ==
              productId;
        },
      );

      if (index != -1) {

        _products[index] =
            _products[index]
                .copyWith(

          stock:
              newStock,

          sold:
              newSold,

          isAvailable:
              newStock > 0,
        );
      }

      _applyFilters();

      notifyListeners();

      return true;

    } catch (e) {

      _errorMessage =
          e.toString();

      notifyListeners();

      return false;
    }
  }

  // =========================================
  // RESTORE STOCK
  // =========================================

  Future<bool> restoreStock({

    required String productId,

    required int quantity,
  }) async {

    try {

      final product =
          getProductById(
        productId,
      );

      if (product == null) {
        return false;
      }

      final newStock =
          product.stock +
              quantity;

      int newSold =
          product.sold -
              quantity;

      if (newSold < 0) {
        newSold = 0;
      }

      await _databaseService
          .updateProduct(
            product.copyWith(
              stock: newStock,
              sold: newSold,
              isAvailable: true,
            ),
          );

      final index =
          _products.indexWhere(

        (p) {

          return p.id ==
              productId;
        },
      );

      if (index != -1) {

        _products[index] =
            _products[index]
                .copyWith(

          stock:
              newStock,

          sold:
              newSold,

          isAvailable:
              true,
        );
      }

      _applyFilters();

      notifyListeners();

      return true;

    } catch (e) {

      _errorMessage =
          e.toString();

      notifyListeners();

      return false;
    }
  }

  // =========================================
  // PRIVATE
  // =========================================

  void _setLoading(
    bool value,
  ) {

    _isLoading =
        value;

    notifyListeners();
  }

  void _clearError() {

    _errorMessage =
        null;
  }

  // =========================================
  // DISPOSE
  // =========================================

  @override
  void dispose() {

    _productSubscription
        ?.cancel();

    super.dispose();
  }
}