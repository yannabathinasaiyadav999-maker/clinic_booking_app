import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/demo_doctor_model.dart';

/// State class for demo booking flow
/// Manages the current state of the booking process
class BookingState {
  /// Currently selected consultant type
  final ConsultantType? selectedConsultantType;
  
  /// Currently selected doctor
  final Doctor? selectedDoctor;
  
  /// Selected date for appointment
  final DateTime? selectedDate;
  
  /// Selected time slot for appointment
  final String? selectedTimeSlot;
  
  /// Selected payment method
  final String? selectedPaymentMethod;
  
  /// List of filtered doctors based on selected consultant type
  final List<Doctor> filteredDoctors;
  
  /// Current booking information
  final BookingInfo? currentBooking;
  
  /// Loading state for async operations
  final bool isLoading;
  
  /// Error state for error handling
  final String? error;

  const BookingState({
    this.selectedConsultantType,
    this.selectedDoctor,
    this.selectedDate,
    this.selectedTimeSlot,
    this.selectedPaymentMethod,
    this.filteredDoctors = const [],
    this.currentBooking,
    this.isLoading = false,
    this.error,
  });

  /// Creates a copy of BookingState with updated values
  /// Used for immutable state updates
  BookingState copyWith({
    ConsultantType? selectedConsultantType,
    Doctor? selectedDoctor,
    DateTime? selectedDate,
    String? selectedTimeSlot,
    String? selectedPaymentMethod,
    List<Doctor>? filteredDoctors,
    BookingInfo? currentBooking,
    bool? isLoading,
    String? error,
    bool clearError = false,
    bool clearBooking = false,
  }) {
    return BookingState(
      selectedConsultantType: selectedConsultantType ?? this.selectedConsultantType,
      selectedDoctor: selectedDoctor ?? this.selectedDoctor,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTimeSlot: selectedTimeSlot ?? this.selectedTimeSlot,
      selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,
      filteredDoctors: filteredDoctors ?? this.filteredDoctors,
      currentBooking: clearBooking ? null : (currentBooking ?? this.currentBooking),
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  String toString() {
    return 'BookingState(selectedConsultantType: $selectedConsultantType, selectedDoctor: $selectedDoctor, selectedDate: $selectedDate, selectedTimeSlot: $selectedTimeSlot, isLoading: $isLoading, error: $error)';
  }
}

/// Notifier class for managing booking state
/// Handles all booking-related business logic and state transitions
class BookingNotifier extends StateNotifier<BookingState> {
  BookingNotifier() : super(const BookingState());

  /// Selects a consultant type and filters doctors accordingly
  /// 
  /// [consultantType] - The selected consultant type
  void selectConsultantType(ConsultantType consultantType) {
    // Filter doctors based on selected consultant type
    final filteredDoctors = demoDoctors
        .where((doctor) => doctor.consultantTypeId == consultantType.id)
        .toList();

    state = state.copyWith(
      selectedConsultantType: consultantType,
      filteredDoctors: filteredDoctors,
      clearError: true,
      clearBooking: true,
    );
  }

  /// Selects a doctor for booking
  /// 
  /// [doctor] - The selected doctor
  void selectDoctor(Doctor doctor) {
    state = state.copyWith(
      selectedDoctor: doctor,
      clearError: true,
      clearBooking: true,
    );
  }

  /// Selects a date for the appointment
  /// 
  /// [date] - The selected date
  void selectDate(DateTime date) {
    state = state.copyWith(
      selectedDate: date,
      clearError: true,
      clearBooking: true,
    );
  }

  /// Selects a time slot for the appointment
  /// 
  /// [timeSlot] - The selected time slot
  void selectTimeSlot(String timeSlot) {
    state = state.copyWith(
      selectedTimeSlot: timeSlot,
      clearError: true,
      clearBooking: true,
    );
  }

  /// Selects a payment method for the appointment
  /// 
  /// [paymentMethod] - The selected payment method
  void selectPaymentMethod(String paymentMethod) {
    state = state.copyWith(
      selectedPaymentMethod: paymentMethod,
      clearError: true,
    );
  }

  /// Creates a booking with current selections
  /// Validates that all required fields are selected
  /// 
  /// Returns true if booking is successful, false otherwise
  bool createBooking() {
    if (state.selectedDoctor == null ||
        state.selectedDate == null ||
        state.selectedTimeSlot == null) {
      state = state.copyWith(
        error: 'Please select doctor, date, and time slot',
      );
      return false;
    }

    final booking = BookingInfo(
      doctor: state.selectedDoctor!,
      date: _formatDate(state.selectedDate!),
      time: state.selectedTimeSlot!,
      fees: state.selectedDoctor!.fees,
      createdAt: DateTime.now(),
    );

    state = state.copyWith(
      currentBooking: booking,
      clearError: true,
    );

    return true;
  }

  /// Simulates payment processing
  /// In a real app, this would integrate with a payment gateway
  /// 
  /// Returns true if payment is successful, false otherwise
  Future<bool> processPayment() async {
    if (state.currentBooking == null) {
      state = state.copyWith(error: 'No booking found');
      return false;
    }

    // Simulate payment processing
    state = state.copyWith(isLoading: true);
    
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Simulate successful payment (90% success rate for demo)
    final isSuccess = DateTime.now().millisecond % 10 != 0;
    
    if (isSuccess) {
      state = state.copyWith(
        isLoading: false,
        clearError: true,
      );
      return true;
    } else {
      state = state.copyWith(
        isLoading: false,
        error: 'Payment failed. Please try again.',
      );
      return false;
    }
  }

  /// Resets the booking state
  /// Clears all selections and errors
  void resetBooking() {
    state = const BookingState();
  }

  /// Clears the current error state
  void clearError() {
    state = state.copyWith(clearError: true);
  }

  /// Formats date for display
  /// 
  /// [date] - The date to format
  /// Returns formatted date string
  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
  }

  /// Gets available time slots for the selected doctor
  /// Returns list of available time slots
  List<String> getAvailableTimeSlots() {
    if (state.selectedDoctor == null) {
      return demoTimeSlots;
    }
    return state.selectedDoctor!.availableSlots;
  }

  /// Checks if all required fields are selected for booking
  /// Returns true if ready for booking, false otherwise
  bool isReadyForBooking() {
    return state.selectedDoctor != null &&
           state.selectedDate != null &&
           state.selectedTimeSlot != null;
  }
}

/// Provider for the BookingNotifier
/// This is the main provider that widgets will consume
final bookingNotifierProvider = StateNotifierProvider<BookingNotifier, BookingState>((ref) {
  return BookingNotifier();
});

/// Helper providers for specific state values
/// These provide more granular access to booking state

/// Provider for selected consultant type
final selectedConsultantTypeProvider = Provider<ConsultantType?>((ref) {
  return ref.watch(bookingNotifierProvider).selectedConsultantType;
});

/// Provider for filtered doctors list
final filteredDoctorsProvider = Provider<List<Doctor>>((ref) {
  return ref.watch(bookingNotifierProvider).filteredDoctors;
});

/// Provider for selected doctor
final selectedDoctorProvider = Provider<Doctor?>((ref) {
  return ref.watch(bookingNotifierProvider).selectedDoctor;
});

/// Provider for selected date
final selectedDateProvider = Provider<DateTime?>((ref) {
  return ref.watch(bookingNotifierProvider).selectedDate;
});

/// Provider for selected time slot
final selectedTimeSlotProvider = Provider<String?>((ref) {
  return ref.watch(bookingNotifierProvider).selectedTimeSlot;
});

/// Provider for selected payment method
final selectedPaymentMethodProvider = Provider<String?>((ref) {
  return ref.watch(bookingNotifierProvider).selectedPaymentMethod;
});

/// Provider for current booking
final currentBookingProvider = Provider<BookingInfo?>((ref) {
  return ref.watch(bookingNotifierProvider).currentBooking;
});

/// Provider for booking loading state
final bookingLoadingProvider = Provider<bool>((ref) {
  return ref.watch(bookingNotifierProvider).isLoading;
});

/// Provider for booking error state
final bookingErrorProvider = Provider<String?>((ref) {
  return ref.watch(bookingNotifierProvider).error;
});

/// Provider for available time slots
final availableTimeSlotsProvider = Provider<List<String>>((ref) {
  final notifier = ref.read(bookingNotifierProvider.notifier);
  return notifier.getAvailableTimeSlots();
});

/// Provider for booking readiness
final isReadyForBookingProvider = Provider<bool>((ref) {
  final notifier = ref.read(bookingNotifierProvider.notifier);
  return notifier.isReadyForBooking();
});
