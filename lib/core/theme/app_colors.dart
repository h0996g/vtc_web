import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF001624);
  static const Color secondary = Color(0xFFFFC000);
  static const Color background = Color(0xFF142735);

  // Additional colors for enhanced design
  static const Color accent = Color(0xFF2E4057);
  static const Color cardBackground = Color(0xFF1A2B3D);
  static const Color textSecondary = Color(0xFFB0BEC5);
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53E3E);

  static const BoxDecoration backgroundGradient = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [primary, background, Color(0xFF0A1A2A)],
    ),
  );
}
