import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/res/theme/text_theme.dart';
import '../../core/res/theme/theme_manager.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    this.onTap,
    required this.title,
    this.textColor,
    this.bgColor,
    this.width,
    this.height,
    this.borderColor,
  });
  final void Function()? onTap;
  final String title;
  final Color? textColor;
  final Color? bgColor;
  final double? width;
  final double? height;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(25.r),
      onTap: onTap,
      child: Container(
        width: width ?? 1.sw,
        height: height ?? 48.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.r),
            color: bgColor ?? getColor().themeColorRed,
            border: Border.all(
              color: borderColor ?? Colors.transparent,
            )),
        alignment: Alignment.center,
        child: Text(
          title,
          style: text14.medium.copyWith(
            color: textColor ?? getColor().themeColorWhiteBlack,
          ),
        ),
      ),
    );
  }
}
