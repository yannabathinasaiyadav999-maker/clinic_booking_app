import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clinic_booking_app/providers/auth_provider.dart';

class SnackBarService {
  static void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  static void showInfo(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.info, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

// Auth service helper for handling responses and showing appropriate messages
class AuthServiceHelper {
  static void handleAuthResponse(
    BuildContext context,
    WidgetRef ref,
    void Function() onSuccess,
  ) {
    final authState = ref.read(authNotifierProvider);
    
    // Clear previous error
    ref.read(authNotifierProvider.notifier).clearError();
    
    // Show loading indicator if needed
    if (authState.isLoading) {
      return;
    }
    
    // Handle error
    if (authState.error != null) {
      SnackBarService.showError(context, authState.error!);
      ref.read(authNotifierProvider.notifier).clearError();
      return;
    }
    
    // Handle success response
    if (authState.response != null) {
      final response = authState.response!;
      
      if (response.status) {
        SnackBarService.showSuccess(context, response.message);
        ref.read(authNotifierProvider.notifier).clearResponse();
        onSuccess();
      } else {
        SnackBarService.showError(context, response.message);
        ref.read(authNotifierProvider.notifier).clearResponse();
      }
    }
  }
}
