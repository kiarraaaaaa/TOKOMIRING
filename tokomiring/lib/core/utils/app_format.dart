// lib/core/utils/app_format.dart

import 'package:intl/intl.dart';

class AppFormat {
  static String currency(num value) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(value);
  }

  static String date(DateTime date) {
    return DateFormat(
      'dd MMM yyyy',
    ).format(date);
  }

  static String time(DateTime date) {
    return DateFormat(
      'HH:mm',
    ).format(date);
  }
}