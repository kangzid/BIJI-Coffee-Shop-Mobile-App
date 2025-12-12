import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  bool get isAuthenticated =>
      _user != null; // Simple check, ideally check token validity

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.login(email, password);
      await _apiService.saveToken(response['access_token']);

      // Fetch user details immediately after login
      final userData = await _apiService.getUser();
      _user = User.fromJson(userData);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.register(name, email, password);
      await _apiService.saveToken(response['access_token']);

      // Fetch user details or use input data
      // Ideally fetch from API to get ID and ensure consistency
      try {
        final userData = await _apiService.getUser();
        _user = User.fromJson(userData);
      } catch (_) {
        // Fallback if /user fails immediately after register
        _user = User(id: 0, name: name, email: email);
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _apiService.logout();
    _user = null;
    notifyListeners();
  }

  // Try to load user if token exists (e.g. on app restart)
  Future<void> loadUser() async {
    try {
      final token = await _apiService.getToken();
      if (token != null) {
        final userData = await _apiService.getUser();
        _user = User.fromJson(userData);
        notifyListeners();
      }
    } catch (e) {
      // Token might be invalid or expired
      _user = null;
    }
  }
}
