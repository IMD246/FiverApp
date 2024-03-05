class DateTimeUtils {
  DateTimeUtils._();

  static String setFormatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return "$day/$month/${date.year}";
  }

  static DateTime parseFormatToDate(String value) {
    final splits = value.split('/');
    final day = int.parse(splits[0]) ;
    final month = int.parse(splits[1]) ;
    final year = int.parse(splits[2]) ;
    
    return DateTime(year,month,day);
  }
}
