// lib/core/utils/app_format.dart

import 'package:intl/intl.dart';

class AppFormat {

  // =====================================================
  // CURRENCY
  // =====================================================

  static String currency(
    num value,
  ) {

    return NumberFormat.currency(
      locale: 'id_ID',

      symbol: 'Rp ',

      decimalDigits: 0,
    ).format(value);
  }

  // =====================================================
  // DATE
  // =====================================================

  static String date(
    DateTime date,
  ) {

    return DateFormat(
      'dd MMM yyyy',
    ).format(date);
  }

  // =====================================================
  // SHORT DATE
  // =====================================================

  static String shortDate(
    DateTime date,
  ) {

    return DateFormat(
      'dd/MM/yyyy',
    ).format(date);
  }

  // =====================================================
  // TIME
  // =====================================================

  static String time(
    DateTime date,
  ) {

    return DateFormat(
      'HH:mm',
    ).format(date);
  }

  // =====================================================
  // DATE TIME
  // =====================================================

  static String dateTime(
    DateTime date,
  ) {

    return DateFormat(
      'dd MMM yyyy • HH:mm',
    ).format(date);
  }

  // =====================================================
  // NUMBER FORMAT
  // =====================================================

  static String number(
    num value,
  ) {

    return NumberFormat.decimalPattern(
      'id_ID',
    ).format(value);
  }

  // =====================================================
  // PERCENT FORMAT
  // =====================================================

  static String percent(
    num value,
  ) {

    return '${value.toStringAsFixed(0)}%';
  }

  // =====================================================
  // STATUS FORMAT
  // =====================================================

  static String orderStatus(
    String status,
  ) {

    switch (status.toLowerCase()) {

      case 'waiting admin validation':
        return 'Waiting Validation';

      case 'processing':
        return 'Processing';

      case 'shipping':
        return 'Shipping';

      case 'completed':
        return 'Completed';

      case 'cancelled':
        return 'Cancelled';

      default:
        return status;
    }
  }

  // =====================================================
  // CAPITALIZE
  // =====================================================

  static String capitalize(
    String text,
  ) {

    if (text.isEmpty) {
      return text;
    }

    return text[0]
            .toUpperCase() +
        text.substring(1);
  }
}