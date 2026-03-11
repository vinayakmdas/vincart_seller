import 'package:ecommerce_seller/features/product_management/model/product_model.dart';
import 'package:flutter/foundation.dart';

import '../services/product_service.dart';

enum ProductLoadState { idle, loading, loaded, error }

class ProductProvider extends ChangeNotifier {
  final ProductService _service = ProductService();

  List<ProductModels> _allProducts = [];
  ProductLoadState _state = ProductLoadState.idle;
  String _errorMessage = '';
  String _searchQuery = '';
  int _currentPage = 1;
  final int itemsPerPage = 3;

  // --- Getters ---
  ProductLoadState get state => _state;
  String get errorMessage => _errorMessage;
  int get currentPage => _currentPage;

  List<ProductModels> get filteredProducts => _allProducts
      .where((p) =>
          p.productName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.brandId.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.category.toLowerCase().contains(_searchQuery.toLowerCase()))
      .toList();

  List<ProductModels> get pagedProducts {
    final all = filteredProducts;
    final start = (_currentPage - 1) * itemsPerPage;
    final end = (start + itemsPerPage).clamp(0, all.length);
    return all.sublist(start.clamp(0, all.length), end);
  }

  int get totalPages =>
      (filteredProducts.length / itemsPerPage).ceil().clamp(1, double.infinity).toInt();

  int get totalCount => _allProducts.length;

  int get showingFrom =>
      filteredProducts.isEmpty ? 0 : (_currentPage - 1) * itemsPerPage + 1;

  int get showingTo =>
      (_currentPage * itemsPerPage).clamp(0, filteredProducts.length);

  // --- Actions ---
  Future<void> loadProducts() async {
    _state = ProductLoadState.loading;
    notifyListeners();
    try {
      _allProducts = await _service.fetchProducts();
      _state = ProductLoadState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _state = ProductLoadState.error;
    }
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _currentPage = 1;
    notifyListeners();
  }

  void goToPage(int page) {
    if (page >= 1 && page <= totalPages) {
      _currentPage = page;
      notifyListeners();
    }
  }

  void nextPage() => goToPage(_currentPage + 1);
  void previousPage() => goToPage(_currentPage - 1);

  Future<void> deleteProduct(String productId) async {
    try {
      await _service.deleteProduct(productId);
      _allProducts.removeWhere((p) => p.productId == productId);
      // Adjust page if needed
      if (_currentPage > totalPages) _currentPage = totalPages;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}