import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/extensions/ext_localization.dart';
import '../../../../core/res/icons.dart';
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
                SvgPicture.asset(
                  DIcons.filter,
                  width: 24.w,
                  height: 24.w,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(
                    getColor().themeColor222222White,
                    BlendMode.srcIn,
                  ),
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
