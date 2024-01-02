import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../presentation/widgets/default_button.dart';

Future<bool?> bottomSheetPickOptionFile(BuildContext context) {
  return showModalBottomSheet<bool>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            DefaultButton(
              onTap: () => Navigator.of(context).pop(false),
              title: context.loc.camera,
            ),
            SizedBox(height: 16.w),
            DefaultButton(
              bgColor: Colors.blueAccent,
              onTap: () => Navigator.of(context).pop(true),
              title: context.loc.gallery,
            ),
          ],
        ),
      );
    },
  );
}
