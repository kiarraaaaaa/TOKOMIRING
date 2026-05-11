// lib/providers/product_provider.dart

import 'dart:async';

import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../services/database_service.dart';

class ProductProvider extends ChangeNotifier {
  final DatabaseService _databaseService =
      DatabaseService();

  // =====================================================
  // VARIABLES
  // =====================================================

  List<ProductModel> _products = [];

  List<ProductModel> _filteredProducts = [];

  bool _isLoading = false;

  bool _initialized = false;

  String? _errorMessage;

  String _selectedCategory = 'All';

  String _searchQuery = '';

  StreamSubscription? _productSubscription;

  // =====================================================
  // GETTERS
  // =====================================================

  List<ProductModel> get products =>
      _filteredProducts;

  bool get isLoading => _isLoading;

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
  // INIT PRODUCTS
  // =====================================================

  void initializeProducts() {
    if (_initialized) {
      return;
    }

    _initialized = true;

    _setLoading(true);

    _productSubscription?.cancel();

    _productSubscription =
        _databaseService
            .getProducts()
            .listen(
      (data) {
        _products = data;

        _applyFilters();

        _setLoading(false);
      },

      onError: (error) {
        _errorMessage =
            error.toString();

        _setLoading(false);
      },
    );
  }

  // =====================================================
  // REFRESH PRODUCTS
  // =====================================================

  Future<void> refreshProducts() async {
    try {
      _setLoading(true);

      final completer =
          Completer<void>();

      _productSubscription?.cancel();

      _productSubscription =
          _databaseService
              .getProducts()
              .listen(
        (data) {
          _products = data;

          _applyFilters();

          _setLoading(false);

          if (!completer.isCompleted) {
            completer.complete();
          }
        },

        onError: (error) {
          _errorMessage =
              error.toString();

          _setLoading(false);

          if (!completer.isCompleted) {
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
    }
  }

  // =====================================================
  // FILTER PRODUCTS
  // =====================================================

  void _applyFilters() {
    List<ProductModel> tempProducts =
        List.from(_products);

    // CATEGORY FILTER

    if (_selectedCategory != 'All') {
      tempProducts = tempProducts
          .where(
            (product) =>
                product.category
                    .toLowerCase() ==
                _selectedCategory
                    .toLowerCase(),
          )
          .toList();
    }

    // SEARCH FILTER

    if (_searchQuery.isNotEmpty) {
      tempProducts = tempProducts
          .where(
            (product) =>
                product.name
                    .toLowerCase()
                    .contains(
                      _searchQuery
                          .toLowerCase(),
                    ) ||
                product.description
                    .toLowerCase()
                    .contains(
                      _searchQuery
                          .toLowerCase(),
                    ),
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
  // SELECT CATEGORY
  // =====================================================

  void selectCategory(
    String category,
  ) {
    _selectedCategory = category;

    _applyFilters();
  }

  // =====================================================
  // CLEAR FILTERS
  // =====================================================

  void clearFilters() {
    _selectedCategory = 'All';

    _searchQuery = '';

    _applyFilters();
  }

  // =====================================================
  // GET PRODUCT BY ID
  // =====================================================

  ProductModel? getProductById(
    String productId,
  ) {
    try {
      return _products.firstWhere(
        (product) =>
            product.id ==
            productId,
      );
    } catch (e) {
      return null;
    }
  }

  // =====================================================
  // POPULAR PRODUCTS
  // =====================================================

  List<ProductModel>
      get popularProducts {
    return _products
        .where(
          (product) =>
              product.isPopular,
        )
        .toList();
  }

  // =====================================================
  // AVAILABLE PRODUCTS
  // =====================================================

  List<ProductModel>
      get availableProducts {
    return _products
        .where(
          (product) =>
              product.stock > 0 &&
              product.isAvailable,
        )
        .toList();
  }

  // =====================================================
  // LOW STOCK
  // =====================================================

  List<ProductModel>
      get lowStockProducts {
    return _products
        .where(
          (product) =>
              product.stock <= 5,
        )
        .toList();
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
          .addProduct(product);

      if (!_products
          .any((p) => p.id == product.id)) {
        _products.add(product);
      }

      _applyFilters();

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
          .updateProduct(product);

      int index =
          _products.indexWhere(
        (p) =>
            p.id ==
            product.id,
      );

      if (index != -1) {
        _products[index] =
            product;
      }

      _applyFilters();

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
  // DELETE PRODUCT
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
        (product) =>
            product.id ==
            productId,
      );

      _applyFilters();

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

      int index =
          _products.indexWhere(
        (product) =>
            product.id ==
            productId,
      );

      if (index != -1) {
        _products[index] =
            _products[index]
                .copyWith(
          stock: stock,
        );
      }

      _applyFilters();

      return true;
    } catch (e) {
      _errorMessage =
          e.toString();

      notifyListeners();

      return false;
    }
  }

  // =====================================================
  // PRIVATE HELPERS
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
    _productSubscription?.cancel();

    super.dispose();
  }
}