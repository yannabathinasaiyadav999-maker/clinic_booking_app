import 'package:flutter_test/flutter_test.dart';
import 'package:clinic_booking_app/models/auth_models.dart';

void main() {
  group('Auth Models Tests', () {
    test('RegisterRequest should serialize correctly', () {
      final request = RegisterRequest(
        fullName: 'John Doe',
        email: 'john@example.com',
        phone: '1234567890',
        password: 'password123',
      );

      final json = request.toJson();
      
      expect(json['full_name'], 'John Doe');
      expect(json['email'], 'john@example.com');
      expect(json['phone'], '1234567890');
      expect(json['password'], 'password123');
    });

    test('RegisterRequest should deserialize correctly', () {
      final json = {
        'full_name': 'Jane Doe',
        'email': 'jane@example.com',
        'phone': '0987654321',
        'password': 'password456',
      };

      final request = RegisterRequest.fromJson(json);
      
      expect(request.fullName, 'Jane Doe');
      expect(request.email, 'jane@example.com');
      expect(request.phone, '0987654321');
      expect(request.password, 'password456');
    });

    test('AuthResponse should serialize correctly', () {
      final response = AuthResponse(
        status: true,
        message: 'Registration successful',
      );

      final json = response.toJson();
      
      expect(json['status'], true);
      expect(json['message'], 'Registration successful');
    });

    test('AuthResponse should deserialize correctly', () {
      final json = {
        'status': false,
        'message': 'Registration failed',
      };

      final response = AuthResponse.fromJson(json);
      
      expect(response.status, false);
      expect(response.message, 'Registration failed');
    });
  });
}
