import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Brand Colors
  static const Color primaryBlue = Color(0xFF1D4ED8); // Bright Royal Blue for CTAs
  static const Color primaryDark = Color(0xFF1E293B); // Dark blue
  static const Color secondaryBlue = Color(0xFFEFF6FF); // Very light blue for category pills/backgrounds
  static const Color splashBackground = Color(0xFF0F172A); // Deep navy for splash screen
  
  // Backgrounds
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color white = Color(0xFFFFFFFF);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  
  // Status Colors
  static const Color statusApproved = Color(0xFF10B981); // Green
  static const Color statusPending = Color(0xFFF59E0B); // Amber
  static const Color statusRejected = Color(0xFFEF4444); // Red
  static const Color statusPublished = Color(0xFF3B82F6); // Blue
  
  // Borders
  static const Color borderLight = Color(0xFFE2E8F0);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primaryBlue,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
      textTheme: GoogleFonts.plusJakartaSansTextTheme().copyWith(
        displayLarge: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
        displayMedium: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
        displaySmall: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
        headlineMedium: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700),
        titleLarge: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700),
        titleMedium: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700),
        bodyLarge: const TextStyle(color: AppColors.textPrimary),
        bodyMedium: const TextStyle(color: AppColors.textPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          minimumSize: const Size(double.infinity, 56),
          side: const BorderSide(color: AppColors.borderLight, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
        ),
        hintStyle: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w400),
        labelStyle: const TextStyle(color: AppColors.textSecondary),
        prefixIconColor: AppColors.textSecondary,
        suffixIconColor: AppColors.textSecondary,
      ),
      cardTheme: CardThemeData(
        color: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: AppColors.borderLight),
        ),
        margin: EdgeInsets.zero,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
        ),
      ),
    );
  }
}
