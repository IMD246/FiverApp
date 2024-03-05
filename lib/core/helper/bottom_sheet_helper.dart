import '../extensions/ext_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../presentation/widgets/default_button.dart';
import '../res/colors.dart';

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

Future<void> commonBottomSheet({
  required BuildContext context,
  required Widget widget,
}) {
  return showModalBottomSheet<void>(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.r),
        topRight: Radius.circular(16.r),
      ),
    ),
    backgroundColor: colorF9F9F9,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.8,
    ),
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 50),
        child: SingleChildScrollView(child: widget),
      );
    },
  );
}
