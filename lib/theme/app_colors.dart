import 'package:flutter/material.dart';

class AppColors {
  // Brand colors
  static const Color primary = Color(0xFF298F50); // New Primary Color
  static const Color primaryLight = Color(0xFF4DBB7B);
  static const Color primaryDark = Color(0xFF1B6337);

  static const Color secondary = Color(0xFF32D74B);

  // Status colors
  static const Color success = Color(0xFF34C759);
  static const Color error = Color(0xFFFF453A);
  static const Color warning = Color(0xFFFF9F0A);
  static const Color info = Color(0xFF0A84FF);

  // Grayscale
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGrey = Color(0xFFF2F2F7);
  static const Color grey = Color(0xFF8E8E93);
  static const Color darkGrey = Color(0xFF2C2C2E);
  static const Color black = Color(0xFF000000);

  // Background & Surface
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // Text
  static const Color textDark = Color(0xFF1C1C1E);
  static const Color textGrey = Color(0xFF8E8E93);
  static const Color textLight = Color(0xFFFFFFFF);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient greenGradient = LinearGradient(
    colors: [Color(0xFF298F50), Color(0xFF67B26F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
