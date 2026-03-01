import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// App Theme Configuration
/// Modern Material 3 design system for medical consultation app
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // ==================== COLORS ====================
  
  /// Primary Medical Blue
  static const Color medicalBlue = Color(0xFF1976D2);
  static const Color medicalBlueLight = Color(0xFF42A5F5);
  static const Color medicalBlueDark = Color(0xFF1565C0);
  
  /// Secondary Soft Teal
  static const Color softTeal = Color(0xFF26A69A);
  static const Color softTealLight = Color(0xFF4DB6AC);
  static const Color softTealDark = Color(0xFF00897B);
  
  /// Neutral Colors
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF5F5F5);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  
  /// Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textDisabled = Color(0xFFBDBDBD);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  
  /// Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  
  /// Special Colors
  static const Color rating = Color(0xFFFFC107);
  static const Color available = Color(0xFF4CAF50);
  static const Color unavailable = Color(0xFFFF5252);

  // ==================== TYPOGRAPHY ====================
  
  /// Text Styles using Google Fonts (Poppins)
  static const TextStyle headline1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: textPrimary,
    height: 1.2,
  );
  
  static const TextStyle headline2 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    height: 1.3,
  );
  
  static const TextStyle headline3 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    height: 1.3,
  );
  
  static const TextStyle headline4 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    height: 1.4,
  );
  
  static const TextStyle headline5 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: textPrimary,
    height: 1.4,
  );
  
  static const TextStyle subtitle1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: textPrimary,
    height: 1.5,
  );
  
  static const TextStyle subtitle2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: textSecondary,
    height: 1.5,
  );
  
  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: textPrimary,
    height: 1.5,
  );
  
  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: textSecondary,
    height: 1.5,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: textSecondary,
    height: 1.4,
  );
  
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textOnPrimary,
    height: 1.2,
  );

  // ==================== SPACING SYSTEM ====================
  
  /// 8px grid system
  static const double spacing2 = 2.0;
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing40 = 40.0;
  static const double spacing48 = 48.0;
  static const double spacing64 = 64.0;

  // ==================== BORDER RADIUS ====================
  
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 20.0;
  static const double radiusXXLarge = 24.0;

  // ==================== ELEVATION ====================
  
  static const double elevationNone = 0.0;
  static const double elevationSmall = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationLarge = 8.0;
  static const double elevationXLarge = 12.0;

  // ==================== MATERIAL 3 LIGHT THEME ====================
  
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      
      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: medicalBlue,
        secondary: softTeal,
        surface: surfaceWhite,
        background: backgroundLight,
        error: error,
        onPrimary: textOnPrimary,
        onSecondary: textOnPrimary,
        onSurface: textPrimary,
        onBackground: textPrimary,
        onError: textOnPrimary,
      ),
      
      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: surfaceWhite,
        foregroundColor: textPrimary,
        elevation: elevationSmall,
        centerTitle: true,
        titleTextStyle: headline4,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      
      // Card Theme
      cardTheme: const CardThemeData(
        color: surfaceWhite,
        elevation: elevationSmall,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radiusMedium)),
        ),
        margin: EdgeInsets.all(spacing8),
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: medicalBlue,
          foregroundColor: textOnPrimary,
          elevation: elevationMedium,
          padding: const EdgeInsets.symmetric(
            horizontal: spacing24,
            vertical: spacing16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
          textStyle: button,
        ),
      ),
      
      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: medicalBlue,
          side: const BorderSide(color: medicalBlue),
          padding: const EdgeInsets.symmetric(
            horizontal: spacing24,
            vertical: spacing16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
          textStyle: button,
        ),
      ),
      
      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: medicalBlue,
          padding: const EdgeInsets.symmetric(
            horizontal: spacing24,
            vertical: spacing16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
          textStyle: button,
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: BorderSide(color: textDisabled.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: medicalBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: spacing16,
          vertical: spacing16,
        ),
        hintStyle: body2.copyWith(color: textDisabled),
        labelStyle: body2.copyWith(color: medicalBlue),
      ),
      
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surfaceWhite,
        selectedItemColor: medicalBlue,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: elevationMedium,
        selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      ),
      
      // Text Theme
      textTheme: const TextTheme(
        displayLarge: headline1,
        displayMedium: headline2,
        displaySmall: headline3,
        headlineLarge: headline4,
        headlineMedium: headline5,
        headlineSmall: subtitle1,
        titleLarge: subtitle1,
        titleMedium: subtitle2,
        titleSmall: body1,
        bodyLarge: body1,
        bodyMedium: body2,
        bodySmall: caption,
        labelLarge: button,
        labelMedium: button,
        labelSmall: caption,
      ),
      
      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: surfaceLight,
        selectedColor: medicalBlue.withOpacity(0.1),
        disabledColor: textDisabled,
        labelStyle: body2.copyWith(color: textPrimary),
        secondaryLabelStyle: body2.copyWith(color: medicalBlue),
        padding: const EdgeInsets.symmetric(
          horizontal: spacing12,
          vertical: spacing8,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
        ),
      ),
    );
  }

  // ==================== GRADIENTS ====================
  
  /// Primary gradient for buttons and important elements
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [medicalBlue, medicalBlueLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// Secondary gradient for accents
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [softTeal, softTealLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// Background gradient for screens
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [backgroundLight, surfaceWhite],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  /// Card gradient for special elements
  static const LinearGradient cardGradient = LinearGradient(
    colors: [surfaceWhite, surfaceLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
