import 'package:fiver/core/res/theme/text_theme.dart';
import 'package:fiver/core/res/theme/theme_manager.dart';
import 'package:fiver/presentation/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppbar({
    super.key,
    this.centerTitle = false,
    this.leading,
    required this.title,
    this.bgColor,
    this.trailing,
    this.isHideBackButton = false,
    this.action,
    this.elevation,
  });

  final bool centerTitle;
  final Widget? leading;
  final String title;
  final Color? bgColor;
  final List<Widget>? trailing;
  final bool isHideBackButton;
  final void Function()? action;
  final double? elevation;
  @override
  Size get preferredSize => Size.fromHeight(44.w);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      backgroundColor: bgColor ?? Colors.transparent,
      automaticallyImplyLeading: false,
      centerTitle: centerTitle,
      leading: leading ??
          (!isHideBackButton ? BackButtonWidget(action: action) : null),
      title: Text(
        title,
        style: text18.copyWith(
          color: getColor().themeColor222222White,
        ),
      ),
      actions: trailing,
    );
  }
}
