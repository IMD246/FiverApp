import 'package:intl/intl.dart';

String formatCurrency(
    {required dynamic currency, String? locale, bool isSymbol = true}) {
  return NumberFormat.currency(
    locale: locale ?? 'zh',
    decimalDigits: 0,
    symbol: isSymbol ? '\$' : '',
  ).format(currency);
}

String formatDotNumber(
    {required dynamic number, String? locale, bool isSymbol = true}) {
  if (number is num || number is double) {
    return "${number.toStringAsFixed(2)}".replaceAll(".", ",");
  }
  return "$number";
}

String formatMoney(num number, {String? locale}) {
  final isNotInt = (number - number.truncate()) != 0;
  final formatNumber = isNotInt
      ? number.toStringAsFixed(2).replaceAll(".", ",")
      : number.toInt().toString();
  return formatNumber;
}
