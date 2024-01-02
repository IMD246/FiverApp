import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/res/theme/text_theme.dart';
import '../../core/res/theme/theme_manager.dart';
import 'back_button.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppbar({
    super.key,
    this.centerTitle = true,
    this.leading,
    required this.title,
    this.bgColor,
    this.trailing,
    this.isHideBackButton = false,
    this.action,
    this.elevation,
    this.titleStyle,
  });

  final bool centerTitle;
  final Widget? leading;
  final String title;
  final Color? bgColor;
  final List<Widget>? trailing;
  final bool isHideBackButton;
  final void Function()? action;
  final double? elevation;
  final TextStyle? titleStyle;
  @override
  Size get preferredSize => Size.fromHeight(44.w);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation ?? 0,
      backgroundColor: bgColor,
      automaticallyImplyLeading: false,
      centerTitle: centerTitle,
      leading: leading ??
          (!isHideBackButton ? BackButtonWidget(action: action) : null),
      title: Text(
        title,
        style: titleStyle ??
            text18.copyWith(
              color: getColor().themeColor222222White,
            ),
      ),
      actions: [
        if (trailing != null) ...trailing!,
        SizedBox(width: 16.w),
      ],
    );
  }
}
