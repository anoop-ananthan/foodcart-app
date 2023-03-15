import 'package:intl/intl.dart';

String formatAsIndianCurrency(double value) {
  final formatter = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
  );
  return formatter.format(value);
}
