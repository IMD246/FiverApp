import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/ext_localization.dart';
import '../../../../core/res/theme/text_theme.dart';
import '../../../../core/res/theme/theme_manager.dart';

class FilterProductByCategory extends StatelessWidget {
  const FilterProductByCategory({
    super.key,
    required this.onTap,
  });
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 114.w,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Icon(
                  Icons.filter_list,
                  color: getColor().themeColor222222White,
                  size: 20.w,
                ),
                SizedBox(width: 7.w),
                Text(
                  context.loc.filter,
                  style: text11.copyWith(
                    color: getColor().themeColor222222White,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
