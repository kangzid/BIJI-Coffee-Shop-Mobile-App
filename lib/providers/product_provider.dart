import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Category> _categories = [];
  List<Product> _products = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Category> get categories => _categories;
  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();
    try {
      _categories = await _apiService.getCategories();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();
    try {
      _products = await _apiService.getProducts();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Helper to get products by category
  List<Product> getProductsByCategory(String categoryName) {
    if (categoryName == 'All' || categoryName == 'Beverages') {
      // Assuming 'Beverages' is default or similar
      // Logic depends on how categories are filtered.
      // In original data, categories were simple strings in a list.
      // Now they are objects. We need to match ID or Name.
      return _products;
    }
    return _products.where((p) => p.category?.name == categoryName).toList();
  }
}
