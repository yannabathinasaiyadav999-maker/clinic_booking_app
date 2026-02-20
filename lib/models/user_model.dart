import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

/// Model representing a user in the system
/// Handles dynamic JSON responses from the login API
@JsonSerializable()
class UserModel {
  /// Unique identifier for the user
  final int id;
  
  /// Full name of the user
  @JsonKey(name: 'full_name')
  final String fullName;
  
  /// Email address of the user
  final String email;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.email,
  });

  /// Creates a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Converts UserModel to JSON
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString() {
    return 'UserModel(id: $id, fullName: $fullName, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel &&
        other.id == id &&
        other.fullName == fullName &&
        other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ fullName.hashCode ^ email.hashCode;
}

/// Model representing the login response from the API
/// Handles both success and error responses dynamically
@JsonSerializable()
class LoginResponse {
  /// Indicates if the login was successful
  final bool status;
  
  /// Message from the API (success or error message)
  final String message;
  
  /// User data (only present on successful login)
  final UserModel? user;

  const LoginResponse({
    required this.status,
    required this.message,
    this.user,
  });

  /// Creates a LoginResponse from JSON
  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  /// Converts LoginResponse to JSON
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  @override
  String toString() {
    return 'LoginResponse(status: $status, message: $message, user: $user)';
  }
}
