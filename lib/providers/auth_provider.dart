import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clinic_booking_app/models/auth_models.dart';
import 'package:clinic_booking_app/models/user_model.dart';
import 'package:clinic_booking_app/services/auth_service.dart';

/// Authentication state class
/// Manages the current state of authentication including loading, error, and user data
class AuthState {
  /// Indicates if an authentication operation is in progress
  final bool isLoading;
  
  /// Error message from the last failed operation
  final String? error;
  
  /// Response from registration/forgot password operations
  final AuthResponse? response;
  
  /// Currently logged-in user (null if not authenticated)
  final UserModel? user;
  
  /// Indicates if user is authenticated
  final bool isAuthenticated;

  const AuthState({
    this.isLoading = false,
    this.error,
    this.response,
    this.user,
    this.isAuthenticated = false,
  });

  /// Creates a copy of AuthState with updated values
  /// Used for immutable state updates
  AuthState copyWith({
    bool? isLoading,
    String? error,
    AuthResponse? response,
    UserModel? user,
    bool? isAuthenticated,
    bool clearError = false,
    bool clearResponse = false,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      response: clearResponse ? null : (response ?? this.response),
      user: user ?? this.user,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

  @override
  String toString() {
    return 'AuthState(isLoading: $isLoading, error: $error, user: $user, isAuthenticated: $isAuthenticated)';
  }
}

/// Authentication notifier using StateNotifier
/// Manages authentication state and business logic
/// Follows clean architecture principles by separating state management from UI
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  /// Performs user login with email and password
  /// Updates state accordingly throughout the process
  /// 
  /// [email] - User's email address
  /// [password] - User's password
  Future<void> login({
    required String email,
    required String password,
  }) async {
    // Set loading state and clear previous errors
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      // Call authentication service
      final loginResponse = await AuthService.login(
        email: email,
        password: password,
      );
      
      // Update state based on response
      if (loginResponse.status && loginResponse.user != null) {
        // Successful login
        state = state.copyWith(
          isLoading: false,
          user: loginResponse.user,
          isAuthenticated: true,
        );
      } else {
        // Login failed with API error message
        state = state.copyWith(
          isLoading: false,
          error: loginResponse.message,
        );
      }
    } catch (e) {
      // Handle unexpected errors
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Performs user registration
  /// 
  /// [request] - Registration request containing user details
  Future<void> register(RegisterRequest request) async {
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final response = await AuthService.register(request);
      state = state.copyWith(
        isLoading: false,
        response: response,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Handles forgot password functionality
  /// 
  /// [email] - User's email address
  Future<void> forgotPassword(String email) async {
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final response = await AuthService.forgotPassword(email);
      state = state.copyWith(
        isLoading: false,
        response: response,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Logs out the current user
  /// Clears authentication state and user data
  void logout() {
    state = const AuthState();
  }

  /// Clears the current error state
  void clearError() {
    state = state.copyWith(clearError: true);
  }

  /// Clears the current response state
  void clearResponse() {
    state = state.copyWith(clearResponse: true);
  }
}

/// Provider for the AuthNotifier
/// This is the main provider that widgets will consume
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

/// Helper providers for specific state values
/// These provide more granular access to authentication state

/// Provider for loading state
final authLoadingProvider = Provider<bool>((ref) {
  return ref.watch(authNotifierProvider).isLoading;
});

/// Provider for error state
final authErrorProvider = Provider<String?>((ref) {
  return ref.watch(authNotifierProvider).error;
});

/// Provider for response state (for registration/forgot password)
final authResponseProvider = Provider<AuthResponse?>((ref) {
  return ref.watch(authNotifierProvider).response;
});

/// Provider for current user
final currentUserProvider = Provider<UserModel?>((ref) {
  return ref.watch(authNotifierProvider).user;
});

/// Provider for authentication status
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authNotifierProvider).isAuthenticated;
});
