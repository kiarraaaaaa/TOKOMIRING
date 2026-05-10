// lib/core/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme =
      ThemeData(
    useMaterial3: true,

    brightness: Brightness.light,

    scaffoldBackgroundColor:
        const Color(0xffF8FAFC),

    primaryColor:
        const Color(0xff2563EB),

    colorScheme: ColorScheme.fromSeed(
      seedColor:
          const Color(0xff2563EB),
    ),

    textTheme:
        GoogleFonts.poppinsTextTheme(),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,

      elevation: 0,

      centerTitle: true,

      iconTheme: IconThemeData(
        color: Colors.black,
      ),

      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    elevatedButtonTheme:
        ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            const Color(0xff2563EB),

        foregroundColor: Colors.white,

        minimumSize:
            const Size(double.infinity, 55),

        elevation: 4,

        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(18),
        ),

        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight:
              FontWeight.bold,
        ),
      ),
    ),

    outlinedButtonTheme:
        OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize:
            const Size(double.infinity, 55),

        side: const BorderSide(
          color: Color(0xff2563EB),
        ),

        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(18),
        ),

        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight:
              FontWeight.bold,
        ),
      ),
    ),

    inputDecorationTheme:
        InputDecorationTheme(
      filled: true,

      fillColor: Colors.white,

      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 18,
      ),

      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(18),

        borderSide: BorderSide.none,
      ),

      enabledBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(18),

        borderSide: BorderSide.none,
      ),

      focusedBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(18),

        borderSide: const BorderSide(
          color: Color(0xff2563EB),
          width: 2,
        ),
      ),
    ),

cardTheme: CardThemeData(
  color: Colors.white,

  elevation: 5,

  shadowColor: Colors.black12,

  shape: RoundedRectangleBorder(
    borderRadius:
        BorderRadius.circular(24),
  ),
),

    snackBarTheme:
        const SnackBarThemeData(
      behavior:
          SnackBarBehavior.floating,
    ),

    dividerColor:
        Colors.grey.shade200,
  );
}
