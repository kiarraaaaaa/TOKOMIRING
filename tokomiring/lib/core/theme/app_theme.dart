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

        bodyLarge: TextStyle(
          color:
              AppColors.textPrimary,
        ),

        bodyMedium: TextStyle(
          color:
              AppColors.textPrimary,
        ),

        titleLarge: TextStyle(
          color:
              AppColors.textPrimary,

          fontWeight:
              FontWeight.bold,
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
      ),

      titleTextStyle:
          TextStyle(
        color:
            AppColors.dark,

        fontSize: 20,

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
          55,
        ),

        elevation: 0,

        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(
            18,
          ),
        ),

        textStyle:
            const TextStyle(
          fontSize: 16,

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
          55,
        ),

        foregroundColor:
            AppColors.primary,

        side:
            const BorderSide(
          color:
              AppColors.primary,
        ),

        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(
            18,
          ),
        ),

        textStyle:
            const TextStyle(
          fontSize: 16,

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
        horizontal: 20,
        vertical: 18,
      ),

      hintStyle:
          const TextStyle(
        color:
            AppColors.textSecondary,
      ),

      border:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          18,
        ),

        borderSide:
            BorderSide.none,
      ),

      enabledBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          18,
        ),

        borderSide:
            BorderSide.none,
      ),

      focusedBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          18,
        ),

        borderSide:
            const BorderSide(
          color:
              AppColors.primary,

          width: 2,
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

      elevation: 3,

      shadowColor:
          Colors.black12,

      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(
          24,
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
      ),

      behavior:
          SnackBarBehavior.floating,

      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(
          14,
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