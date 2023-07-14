import 'package:intl/intl.dart';

String formatCurrency({
  String locale = "id",
  String symbol = "Rp",
  int decimalDigits = 0,
  required int value,
}) {
  return NumberFormat.currency(
    locale: locale,
    symbol: symbol,
    decimalDigits: decimalDigits,
  ).format(value);
}
