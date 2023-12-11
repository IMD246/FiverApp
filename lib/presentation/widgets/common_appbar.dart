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
  });

  final bool centerTitle;
  final Widget? leading;
  final String title;
  final Color? bgColor;
  final List<Widget>? trailing;
  @override
  Size get preferredSize => Size.fromHeight(44.w);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor ?? Colors.transparent,
      automaticallyImplyLeading: false,
      centerTitle: centerTitle,
      leading: leading ?? const BackButtonWidget(),
      title: Text(
        title,
        style: text18.copyWith(
          color: getColor().themeColorBlackWhite,
        ),
      ),
      actions: trailing,
    );
  }
}
