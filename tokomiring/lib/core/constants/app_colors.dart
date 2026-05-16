// =====================================================
// lib/core/constants/app_colors.dart
// FINAL PREMIUM COLOR SYSTEM
// =====================================================

import 'package:flutter/material.dart';

class AppColors {

  // =====================================================
  // BRAND COLORS
  // =====================================================

  static const Color primary =
      Color(0xff2563EB);

  static const Color primaryDark =
      Color(0xff1D4ED8);

  static const Color primaryLight =
      Color(0xff60A5FA);

  static const Color secondary =
      Color(0xff7C3AED);

  static const Color secondaryDark =
      Color(0xff6D28D9);

  // =====================================================
  // BACKGROUND
  // =====================================================

  static const Color background =
      Color(0xffF8FAFC);

  static const Color scaffold =
      Color(0xffF1F5F9);

  static const Color card =
      Color(0xffFFFFFF);

  static const Color cardDark =
      Color(0xff0F172A);

  static const Color softBlue =
      Color(0xffEFF6FF);

  static const Color softGrey =
      Color(0xffF8FAFC);

  // =====================================================
  // TEXT
  // =====================================================

  static const Color dark =
      Color(0xff0F172A);

  static const Color textPrimary =
      Color(0xff0F172A);

  static const Color textSecondary =
      Color(0xff64748B);

  static const Color textMuted =
      Color(0xff94A3B8);

  static const Color grey =
      Color(0xff64748B);

  static const Color white =
      Colors.white;

  // =====================================================
  // STATUS
  // =====================================================

  static const Color success =
      Color(0xff22C55E);

  static const Color successLight =
      Color(0xffDCFCE7);

  static const Color warning =
      Color(0xffF59E0B);

  static const Color warningLight =
      Color(0xffFEF3C7);

  static const Color danger =
      Color(0xffEF4444);

  static const Color dangerLight =
      Color(0xffFEE2E2);

  static const Color pending =
      Color(0xffF97316);

  static const Color lowStock =
      Color(0xffDC2626);

  static const Color disabled =
      Color(0xffCBD5E1);

  // =====================================================
  // BORDER & SHADOW
  // =====================================================

  static const Color border =
      Color(0xffE2E8F0);

  static const Color borderLight =
      Color(0xffF1F5F9);

  static const Color shadow =
      Color(0xffE5E7EB);

  static const Color divider =
      Color(0xffE2E8F0);

  // =====================================================
  // GLASS / PREMIUM
  // =====================================================

  static Color glass =
      Colors.white.withOpacity(
        0.10,
      );

  static Color glassBorder =
      Colors.white.withOpacity(
        0.14,
      );

  static Color darkGlass =
      Colors.black.withOpacity(
        0.06,
      );

  // =====================================================
  // GRADIENTS
  // =====================================================

  static const LinearGradient
      primaryGradient =
      LinearGradient(

    begin: Alignment.topLeft,

    end: Alignment.bottomRight,

    colors: [

      Color(0xff2563EB),

      Color(0xff1D4ED8),
    ],
  );

  static const LinearGradient
      secondaryGradient =
      LinearGradient(

    begin: Alignment.topLeft,

    end: Alignment.bottomRight,

    colors: [

      Color(0xff7C3AED),

      Color(0xff6D28D9),
    ],
  );

  static const LinearGradient
      successGradient =
      LinearGradient(

    begin: Alignment.topLeft,

    end: Alignment.bottomRight,

    colors: [

      Color(0xff22C55E),

      Color(0xff16A34A),
    ],
  );

  static const LinearGradient
      dangerGradient =
      LinearGradient(

    begin: Alignment.topLeft,

    end: Alignment.bottomRight,

    colors: [

      Color(0xffEF4444),

      Color(0xffDC2626),
    ],
  );

  // =====================================================
  // SHADOWS
  // =====================================================

  static List<BoxShadow>
      softShadow = [

    BoxShadow(

      color:
          Colors.black.withOpacity(
        0.04,
      ),

      blurRadius: 14,

      offset:
          const Offset(
        0,
        6,
      ),
    ),
  ];

  static List<BoxShadow>
      mediumShadow = [

    BoxShadow(

      color:
          Colors.black.withOpacity(
        0.07,
      ),

      blurRadius: 18,

      offset:
          const Offset(
        0,
        10,
      ),
    ),
  ];

  static List<BoxShadow>
      premiumBlueShadow = [

    BoxShadow(

      color:
          primary.withOpacity(
        0.16,
      ),

      blurRadius: 24,

      offset:
          const Offset(
        0,
        10,
      ),
    ),
  ];
}