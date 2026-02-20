import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/home_screen.dart';
import 'screens/consultant_selection_screen.dart';
import 'screens/doctor_list_screen.dart';
import 'screens/doctor_detail_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/booking_confirmation_screen.dart';

void main() {
  runApp(const ProviderScope(child: ClinicBookingApp()));
}

class ClinicBookingApp extends StatelessWidget {
  const ClinicBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clinic Booking App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
      ),
      initialRoute: '/onboarding',
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/home': (context) => const HomeScreen(),
        '/consultant-selection': (context) => const ConsultantSelectionScreen(),
        '/doctor-list': (context) => const DoctorListScreen(),
        '/doctor-detail': (context) => const DoctorDetailScreen(),
        '/payment': (context) => const PaymentScreen(),
        '/booking-confirmation': (context) => const BookingConfirmationScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
