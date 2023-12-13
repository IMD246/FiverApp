import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/res/theme/theme_manager.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final TextStyle? textStyleEnable;
  final void Function() onPressed;
  final double? radius;
  final double? width;
  final double? height;
  final ValueNotifier<bool> isEnable;
  final Color? background;
  final Color? backgroundIsEnable;
  final List<BoxShadow>? boxShadow;
  const CustomButton({
    super.key,
    required this.text,
    this.textStyle,
    this.textStyleEnable,
    required this.onPressed,
    this.radius,
    this.width,
    this.height,
    required this.isEnable,
    this.background,
    this.boxShadow,
    this.backgroundIsEnable,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isEnable,
      builder: (context, isEnable, child) {
        return InkWell(
          borderRadius: BorderRadius.circular(radius ?? 25.r),
          onTap: () => isEnable ? onPressed() : null,
          child: Container(
            width: width ?? 1.sw,
            height: height ?? 48.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isEnable
                  ? backgroundIsEnable ?? getColor().themeColorPrimary
                  : background ?? getColor().themeColorAAAAAAA.withOpacity(0.6),
              borderRadius: BorderRadius.circular(radius ?? 25.r),
              boxShadow: boxShadow,
            ),
            child: Text(
              text,
              style: isEnable ? textStyleEnable : textStyle,
            ),
          ),
        );
      },
    );
  }
}
