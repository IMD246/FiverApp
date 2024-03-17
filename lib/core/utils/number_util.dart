class NumberUtil {
  NumberUtil._();

  static String formatNumber(double number, {int fractionDigits = 1}) {
    return number.toStringAsFixed(fractionDigits);
  }
}