import '../extensions/ext_localization.dart';
import 'package:flutter/material.dart';

import '../res/colors.dart';

Future<DateTime?> commonShowDatePicker({
  required BuildContext context,
  DateTime? firstDate,
  DateTime? lastDate,
}) {
  return showDatePicker(
    context: context,
    firstDate: firstDate ?? DateTime(1900),
    lastDate: lastDate ??
        DateTime(
          DateTime.now().year - 13,
        ),
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    confirmText: context.loc.ok,
    cancelText: context.loc.cancel,
    builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            primary: colorEF3651,
            onPrimary: colorWhite,
          ),
        ),
        child: child!,
      );
    },
    locale: Locale(context.loc.language_code),
  );
}
