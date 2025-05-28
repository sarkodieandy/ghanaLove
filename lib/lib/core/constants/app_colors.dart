import 'package:flutter/material.dart';

class AppColors {
  // Dating app primary colors
  static const Color primaryRed = Color(0xFFFF5E9C); // 💖 Pink for buttons
  static const Color primaryBlack = Color(0xFF1A1A1A); // Deep black
  static const Color primaryGreen = Color(0xFF4CAF50);

  // Gradient for buttons
  static const LinearGradient kenteGradient = LinearGradient(
    colors: [primaryRed, primaryRed], // 💖 Pink solid gradient
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    transform: GradientRotation(0.1),
  );

  static const LinearGradient premiumGradient = LinearGradient(
    colors: [Color(0xFF9C27B0), primaryBlack], // Purple to black
    stops: [0.2, 0.8],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Neutral tones
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGrey = Color(0xFFF8F8F8);
  static const Color mediumGrey = Color(0xFFBDBDBD);
  static const Color darkGrey = Color.fromARGB(255, 194, 188, 188);

  // Semantic colors
  static const Color success = Color(0xFF66BB6A);
  static const Color error = primaryRed;
  static const Color warning = Color(0xFFFFA000);
  static const Color info = Color(0xFF64B5F6);

  // ✅ All text colors now white
  static const Color textPrimary = Color.fromARGB(255, 14, 13, 13);
  static const Color textSecondary = Color.fromARGB(255, 19, 18, 18);
  static const Color textOnPrimary = Color.fromARGB(255, 20, 17, 17);
  static const Color textOnDark = Color.fromARGB(255, 14, 13, 13);

  // Backgrounds
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color backgroundDark = Color.fromARGB(255, 29, 21, 21);
  static const Color cardBackground = white;

  // Dating-specific accents
  static const Color flirtPink = primaryRed;
  static const Color premiumPurple = Color(0xFF9C27B0);
  static const Color onlineGreen = Color(0xFF4CD964);

  // Chat bubble for sender
  static const Color chatBubbleMe = Color(0xFFE0F7FA);
}
