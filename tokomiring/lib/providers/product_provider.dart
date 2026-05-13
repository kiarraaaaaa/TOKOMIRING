// =====================================================
// FULL REVISED VERSION
// lib/providers/product_provider.dart
// FIX:
// ✅ REALTIME TOP SELLING
// ✅ REALTIME SOLD UPDATE
// ✅ REALTIME REPORTS
// ✅ AUTO REFRESH PRODUCTS
// ✅ CHART LIVE UPDATE
// =====================================================

import 'dart:async';

import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../services/database_service.dart';

class ProductProvider
    extends ChangeNotifier {

  final DatabaseService
      _databaseService =
      DatabaseService();

  // =====================================================
  // VARIABLES
  // =====================================================

  List<ProductModel> _products =
      [];

  List<ProductModel>
      _filteredProducts = [];

  bool _isLoading =
      false;

  bool _initialized =
      false;

  String? _errorMessage;

  String _selectedCategory =
      'All';

  String _searchQuery = '';

  StreamSubscription?
      _productSubscription;

  // =====================================================
  // GETTERS
  // =====================================================

  List<ProductModel> get products {

    return _filteredProducts;
  }

  bool get isLoading =>
      _isLoading;

  String? get errorMessage =>
      _errorMessage;

  String get selectedCategory =>
      _selectedCategory;

  String get searchQuery =>
      _searchQuery;

  // =====================================================
  // CATEGORIES
  // =====================================================

  final List<String> categories = [

    'All',

    'Food',

    'Drinks',

    'Snacks',

    'Electronics',

    'Household',

    'Others',
  ];

  // =====================================================
  // TOP SELLING
  // =====================================================

  List<ProductModel>
      get topSellingProducts {

    final copied =
        List<ProductModel>.from(
      _products,
    );

    copied.sort(
      (
        a,
        b,
      ) {

        return b.sold.compareTo(
          a.sold,
        );
      },
    );

    return copied;
  }

  // =====================================================
  // TOTAL SOLD ITEMS
  // =====================================================

  int get totalSoldItems {

    int total = 0;

    for (var product
        in _products) {

      total += product.sold;
    }

    return total;
  }

  // =====================================================
  // TOTAL PRODUCTS
  // =====================================================

  int get totalProducts =>
      _products.length;

  // =====================================================
  // INITIALIZE
  // =====================================================

  void initializeProducts() {

    if (_initialized) {
      return;
    }

    _initialized = true;

    _setLoading(true);

    _productSubscription
        ?.cancel();

    // ===================================================
    // REALTIME LISTENER
    // ===================================================

    _productSubscription =
        _databaseService
            .getProducts()
            .listen(

      (data) {

        _products = data;

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

  // =====================================================
  // FORCE REFRESH
  // =====================================================

  Future<void>
      refreshProducts() async {

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

            completer.completeError(
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

  // =====================================================
  // FILTER
  // =====================================================

  void _applyFilters() {

    List<ProductModel>
        tempProducts =
        List.from(
      _products,
    );

    // ===================================================
    // CATEGORY
    // ===================================================

    if (_selectedCategory !=
        'All') {

      tempProducts = tempProducts
          .where(
            (
              product,
            ) {

              return product
                      .category
                      .toLowerCase() ==
                  _selectedCategory
                      .toLowerCase();
            },
          )
          .toList();
    }

    // ===================================================
    // SEARCH
    // ===================================================

    if (_searchQuery
        .isNotEmpty) {

      tempProducts = tempProducts
          .where(
            (
              product,
            ) {

              return product.name
                      .toLowerCase()
                      .contains(
                        _searchQuery
                            .toLowerCase(),
                      ) ||

                  product
                      .description
                      .toLowerCase()
                      .contains(
                        _searchQuery
                            .toLowerCase(),
                      ) ||

                  product.category
                      .toLowerCase()
                      .contains(
                        _searchQuery
                            .toLowerCase(),
                      );
            },
          )
          .toList();
    }

    _filteredProducts =
        tempProducts;

    notifyListeners();
  }

  // =====================================================
  // SEARCH
  // =====================================================

  void searchProducts(
    String query,
  ) {

    _searchQuery = query;

    _applyFilters();
  }

  // =====================================================
  // CATEGORY
  // =====================================================

  void selectCategory(
    String category,
  ) {

    _selectedCategory =
        category;

    _applyFilters();
  }

  // =====================================================
  // CLEAR FILTERS
  // =====================================================

  void clearFilters() {

    _selectedCategory =
        'All';

    _searchQuery = '';

    _applyFilters();
  }

  // =====================================================
  // PRODUCT BY ID
  // =====================================================

  ProductModel? getProductById(
    String productId,
  ) {

    try {

      return _products.firstWhere(
        (
          product,
        ) {

          return product.id ==
              productId;
        },
      );

    } catch (_) {

      return null;
    }
  }

  // =====================================================
  // POPULAR
  // =====================================================

  List<ProductModel>
      get popularProducts {

    return _products.where(
      (
        product,
      ) {

        return product.isPopular;
      },
    ).toList();
  }

  // =====================================================
  // AVAILABLE
  // =====================================================

  List<ProductModel>
      get availableProducts {

    return _products.where(
      (
        product,
      ) {

        return product.stock >
                0 &&
            product.isAvailable;
      },
    ).toList();
  }

  // =====================================================
  // LOW STOCK
  // =====================================================

  List<ProductModel>
      get lowStockProducts {

    return _products.where(
      (
        product,
      ) {

        return product.stock <=
            5;
      },
    ).toList();
  }

  // =====================================================
  // ADD PRODUCT
  // =====================================================

  Future<bool> addProduct(
    ProductModel product,
  ) async {

    try {

      _setLoading(true);

      _errorMessage = null;

      await _databaseService
          .addProduct(
        product,
      );

      final exist =
          _products.any(
        (
          p,
        ) {

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

  // =====================================================
  // UPDATE PRODUCT
  // =====================================================

  Future<bool> updateProduct(
    ProductModel product,
  ) async {

    try {

      _setLoading(true);

      _errorMessage = null;

      await _databaseService
          .updateProduct(
        product,
      );

      final index =
          _products.indexWhere(
        (
          p,
        ) {

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

  // =====================================================
  // DELETE
  // =====================================================

  Future<bool> deleteProduct(
    String productId,
  ) async {

    try {

      _setLoading(true);

      _errorMessage = null;

      await _databaseService
          .deleteProduct(
        productId,
      );

      _products.removeWhere(
        (
          product,
        ) {

          return product.id ==
              productId;
        },
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

  // =====================================================
  // UPDATE STOCK
  // =====================================================

  Future<bool> updateStock({

    required String productId,

    required int stock,

  }) async {

    try {

      await _databaseService
          .updateStock(

        productId:
            productId,

        stock: stock,
      );

      final index =
          _products.indexWhere(
        (
          product,
        ) {

          return product.id ==
              productId;
        },
      );

      if (index != -1) {

        _products[index] =
            _products[index]
                .copyWith(
          stock: stock,
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

  // =====================================================
  // UPDATE SOLD
  // =====================================================

  Future<void> increaseSold({

    required String productId,

    required int quantity,

  }) async {

    try {

      final index =
          _products.indexWhere(
        (
          product,
        ) {

          return product.id ==
              productId;
        },
      );

      if (index == -1) {
        return;
      }

      final current =
          _products[index];

      final updated =
          current.copyWith(

        sold:
            current.sold +
                quantity,
      );

      _products[index] =
          updated;

      await _databaseService
          .updateProduct(
        updated,
      );

      _applyFilters();

      notifyListeners();

    } catch (_) {}
  }

  // =====================================================
  // PRIVATE
  // =====================================================

  void _setLoading(
    bool value,
  ) {

    _isLoading = value;

    notifyListeners();
  }

  // =====================================================
  // DISPOSE
  // =====================================================

  @override
  void dispose() {

    _productSubscription
        ?.cancel();

    super.dispose();
  }
}