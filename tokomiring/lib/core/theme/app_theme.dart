// lib/core/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

class AppTheme {

  static ThemeData lightTheme =
      ThemeData(

    useMaterial3: true,

    brightness:
        Brightness.light,

    visualDensity:
        VisualDensity.adaptivePlatformDensity,

    // ===================================================
    // SCAFFOLD
    // ===================================================

    scaffoldBackgroundColor:
        AppColors.background,

    primaryColor:
        AppColors.primary,

    colorScheme:
        ColorScheme.fromSeed(

      seedColor:
          AppColors.primary,

      primary:
          AppColors.primary,

      secondary:
          AppColors.secondary,
    ),

    // ===================================================
    // TEXT THEME
    // ===================================================

    textTheme:
        GoogleFonts.poppinsTextTheme(

      const TextTheme(

        displayLarge: TextStyle(
          fontSize: 34,
          fontWeight:
              FontWeight.bold,
          color:
              AppColors.textPrimary,
        ),

        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight:
              FontWeight.bold,
          color:
              AppColors.textPrimary,
        ),

        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight:
              FontWeight.bold,
          color:
              AppColors.textPrimary,
        ),

        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight:
              FontWeight.w600,
          color:
              AppColors.textPrimary,
        ),

        bodyLarge: TextStyle(
          fontSize: 15,
          color:
              AppColors.textPrimary,
        ),

        bodyMedium: TextStyle(
          fontSize: 13,
          color:
              AppColors.textPrimary,
        ),

        bodySmall: TextStyle(
          fontSize: 11,
          color:
              AppColors.textSecondary,
        ),
      ),
    ),

    // ===================================================
    // APP BAR
    // ===================================================

    appBarTheme:
        const AppBarTheme(

      backgroundColor:
          AppColors.white,

      foregroundColor:
          AppColors.dark,

      elevation: 0,

      centerTitle: true,

      scrolledUnderElevation:
          0,

      iconTheme:
          IconThemeData(

        color:
            AppColors.dark,

        size: 22,
      ),

      titleTextStyle:
          TextStyle(

        color:
            AppColors.dark,

        fontSize: 18,

        fontWeight:
            FontWeight.bold,
      ),
    ),

    // ===================================================
    // ELEVATED BUTTON
    // ===================================================

    elevatedButtonTheme:
        ElevatedButtonThemeData(

      style:
          ElevatedButton.styleFrom(

        backgroundColor:
            AppColors.primary,

        foregroundColor:
            AppColors.white,

        disabledBackgroundColor:
            AppColors.disabled,

        minimumSize:
            const Size(
          double.infinity,
          48,
        ),

        elevation: 0,

        padding:
            const EdgeInsets.symmetric(

          horizontal: 18,

          vertical: 14,
        ),

        shape:
            RoundedRectangleBorder(

          borderRadius:
              BorderRadius.circular(
            16,
          ),
        ),

        textStyle:
            const TextStyle(

          fontSize: 14,

          fontWeight:
              FontWeight.bold,
        ),
      ),
    ),

    // ===================================================
    // OUTLINED BUTTON
    // ===================================================

    outlinedButtonTheme:
        OutlinedButtonThemeData(

      style:
          OutlinedButton.styleFrom(

        minimumSize:
            const Size(
          double.infinity,
          48,
        ),

        foregroundColor:
            AppColors.primary,

        side:
            const BorderSide(
          color:
              AppColors.primary,
        ),

        padding:
            const EdgeInsets.symmetric(

          horizontal: 18,

          vertical: 14,
        ),

        shape:
            RoundedRectangleBorder(

          borderRadius:
              BorderRadius.circular(
            16,
          ),
        ),

        textStyle:
            const TextStyle(

          fontSize: 14,

          fontWeight:
              FontWeight.bold,
        ),
      ),
    ),

    // ===================================================
    // INPUT
    // ===================================================

    inputDecorationTheme:
        InputDecorationTheme(

      filled: true,

      fillColor:
          AppColors.white,

      contentPadding:
          const EdgeInsets.symmetric(

        horizontal: 18,

        vertical: 16,
      ),

      hintStyle:
          const TextStyle(

        color:
            AppColors.textSecondary,

        fontSize: 13,
      ),

      border:
          OutlineInputBorder(

        borderRadius:
            BorderRadius.circular(
          16,
        ),

        borderSide:
            BorderSide.none,
      ),

      enabledBorder:
          OutlineInputBorder(

        borderRadius:
            BorderRadius.circular(
          16,
        ),

        borderSide:
            BorderSide.none,
      ),

      focusedBorder:
          OutlineInputBorder(

        borderRadius:
            BorderRadius.circular(
          16,
        ),

        borderSide:
            const BorderSide(

          color:
              AppColors.primary,

          width: 1.8,
        ),
      ),
    ),

    // ===================================================
    // CARD
    // ===================================================

    cardTheme:
        CardThemeData(

      color:
          AppColors.card,

      elevation: 2,

      shadowColor:
          Colors.black12,

      margin:
          const EdgeInsets.all(
        6,
      ),

      shape:
          RoundedRectangleBorder(

        borderRadius:
            BorderRadius.circular(
          20,
        ),
      ),
    ),

    // ===================================================
    // SNACKBAR
    // ===================================================

    snackBarTheme:
        SnackBarThemeData(

      backgroundColor:
          AppColors.dark,

      contentTextStyle:
          const TextStyle(

        color:
            AppColors.white,

        fontSize: 13,
      ),

      behavior:
          SnackBarBehavior.floating,

      shape:
          RoundedRectangleBorder(

        borderRadius:
            BorderRadius.circular(
          12,
        ),
      ),
    ),

    // ===================================================
    // DIVIDER
    // ===================================================

    dividerColor:
        AppColors.border,
  );
}