import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  // Brand Colors
  static const Color primary = AppColors.primary;
  static const Color secondary = AppColors.secondary;

  // Background Colors
  static const Color backgroundLight = AppColors.backgroundLight;
  static const Color backgroundDark = AppColors.backgroundDark;

  // Surface Colors
  static const Color surfaceLight = AppColors.surfaceLight;
  static const Color surfaceDark = AppColors.surfaceDark;

  // Text Colors
  static const Color textDark = AppColors.textDark;
  static const Color textLight = AppColors.textLight;
  static const Color textGrey = AppColors.textGrey;

  // Gradients
  static const LinearGradient primaryGradient = AppColors.primaryGradient;

  static const LinearGradient greenGradient = AppColors.greenGradient;

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primary,
      scaffoldBackgroundColor: backgroundLight,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        secondary: secondary,
        surface: surfaceLight,
        error: AppColors.error,
      ),
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: textDark,
        displayColor: textDark,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: textLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          elevation: 0,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceLight,
        hintStyle: const TextStyle(color: textGrey, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.textGrey.withOpacity(0.1),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
      ),
    );
  }
}
