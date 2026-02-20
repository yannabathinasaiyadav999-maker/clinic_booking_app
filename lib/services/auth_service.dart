import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clinic_booking_app/models/user_model.dart';
import 'package:clinic_booking_app/models/auth_models.dart';

/// Service layer for handling authentication operations
/// Provides clean abstraction over API calls with proper error handling
class AuthService {
  /// Base URL for API endpoints
  /// Uses 10.0.2.2 for Android emulator to access localhost
  static const String baseUrl = 'http://10.0.2.2:3000';
  
  /// Request timeout duration
  static const Duration timeout = Duration(seconds: 30);
  
  /// Default headers for API requests
  static Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  /// Performs user login with email and password
  /// 
  /// [email] - User's email address
  /// [password] - User's password
  /// 
  /// Returns [LoginResponse] on success
  /// Throws [Exception] with appropriate error message on failure
  /// 
  /// Error handling includes:
  /// - Network connectivity issues
  /// - Invalid response format
  /// - HTTP errors (4xx, 5xx)
  /// - API-specific error messages
  static Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      // Create login request payload
      final loginRequest = LoginRequest(
        email: email.trim(),
        password: password,
      );

      // Make POST request to login endpoint
      final response = await http
          .post(
            Uri.parse('$baseUrl/login'),
            headers: headers,
            body: jsonEncode(loginRequest.toJson()),
          )
          .timeout(timeout);

      // Handle successful HTTP response (2xx status codes)
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return LoginResponse.fromJson(responseData);
      } else {
        // Handle HTTP errors
        throw Exception('HTTP Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } on http.ClientException {
      // Handle network connectivity issues
      throw Exception('Network error. Please check your internet connection.');
    } on FormatException {
      // Handle invalid JSON response
      throw Exception('Invalid response format from server.');
    } catch (e) {
      // Handle any other unexpected errors
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  /// Performs user registration
  /// 
  /// [request] - Registration request containing user details
  /// 
  /// Returns [AuthResponse] on success
  /// Throws [Exception] with appropriate error message on failure
  static Future<AuthResponse> register(RegisterRequest request) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/register'),
            headers: headers,
            body: jsonEncode(request.toJson()),
          )
          .timeout(timeout);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return AuthResponse.fromJson(responseData);
      } else {
        throw Exception('HTTP Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } on http.ClientException {
      throw Exception('Network error. Please check your internet connection.');
    } on FormatException {
      throw Exception('Invalid response format from server.');
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  /// Handles forgot password functionality
  /// 
  /// [email] - User's email address for password reset
  /// 
  /// Returns [AuthResponse] on success
  /// Throws [Exception] with appropriate error message on failure
  static Future<AuthResponse> forgotPassword(String email) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/forgot-password'),
            headers: headers,
            body: jsonEncode({'email': email.trim()}),
          )
          .timeout(timeout);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return AuthResponse.fromJson(responseData);
      } else {
        throw Exception('HTTP Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } on http.ClientException {
      throw Exception('Network error. Please check your internet connection.');
    } on FormatException {
      throw Exception('Invalid response format from server.');
    } catch (e) {
      throw Exception('Password reset failed: ${e.toString()}');
    }
  }
}
