import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/res/colors.dart';
import '../../core/res/theme/theme_manager.dart';

class CheckBoxWidget extends StatelessWidget {
  const CheckBoxWidget({
    super.key,
    this.checkColor,
    this.activeColor,
    this.scale,
    required this.value,
    this.onChanged,
  });
  final Color? checkColor;
  final Color? activeColor;
  final double? scale;
  final bool value;
  final void Function(bool? value)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale ?? 1.2,
      child: Checkbox(
        activeColor: activeColor ?? colorEF3651,
        checkColor: checkColor ?? colorWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.r),
        ),
        side: MaterialStateBorderSide.resolveWith(
          (states) => BorderSide(
            width: 1.0.w,
            color:
                value ? Colors.transparent : getColor().themeColorBlackWhite,
          ),
        ),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
