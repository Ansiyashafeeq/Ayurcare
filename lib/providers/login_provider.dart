import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginProvider with ChangeNotifier {
  String _token = '';
  bool _isLoading = false;
  String? _errorMessage;

  String get token => _token;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> login(String email, String password, VoidCallback onSuccess) async {
    final url = Uri.parse('https://flutter-amr.noviindus.in/api/login'); // Adjust URL as per your API endpoint

    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final response = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
        },
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200 && responseData['token'] != null) {
        _token = responseData['token'];
        _isLoading = false;
        notifyListeners();

        onSuccess(); // Call onSuccess callback to navigate to home page
      } else {
        _isLoading = false;
        _errorMessage = 'Login failed. Please check your credentials.';
        notifyListeners();
      }
    } catch (error) {
      _isLoading = false;
      _errorMessage = 'An error occurred. Please try again later.';
      notifyListeners();
    }
  }
}
