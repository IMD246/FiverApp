import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String formatToDateString({String type = "yyyy年MMMdd日 - HH:mm"}) {
    return DateFormat(type).format(this);
  }
}
