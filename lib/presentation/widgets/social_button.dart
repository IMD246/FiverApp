import 'package:fiven/core/extensions/ext_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/enum.dart';
import '../../core/res/theme/theme_manager.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    this.action,
    this.socialIconType = SocialIconType.google,
  });
  final VoidCallback? action;
  final SocialIconType socialIconType;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        width: 92.w,
        height: 64.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          color: getColor().themeColorWhiteBlack,
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          socialIconType.getIcon(),
          width: 38.w,
          height: 38.w,
        ),
      ),
    );
  }
}
