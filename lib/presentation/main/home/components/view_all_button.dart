import '../../../../core/extensions/ext_localization.dart';
import '../../../../core/res/theme/text_theme.dart';
import 'package:flutter/material.dart';

class ViewAllButton extends StatelessWidget {
  const ViewAllButton({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        context.loc.view_all,
        style: text11,
      ),
    );
  }
}
