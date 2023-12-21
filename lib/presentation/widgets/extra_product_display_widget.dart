import '../../core/extensions/ext_localization.dart';
import '../../core/extensions/ext_num.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/res/colors.dart';
import '../../core/res/theme/text_theme.dart';
import '../../core/res/theme/theme_manager.dart';

class ExtraProductDisplayWidget extends StatelessWidget {
  const ExtraProductDisplayWidget({
    super.key,
    required this.isNew,
    required this.salePercent,
    required this.width,
  });
  final bool isNew;
  final num salePercent;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: SizedBox(
        width: width,
        child: isNew || salePercent > 0
            ? Row(
                children: [
                  if (isNew)
                    Container(
                      alignment: Alignment.center,
                      width: 48.w,
                      height: 28.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(29.r),
                        color: getColor().themeColor222222White,
                      ),
                      child: Text(
                        isNew
                            ? context.loc.new_title.toUpperCase()
                            : salePercent > 0
                                ? salePercent.displaySalePercent()
                                : "",
                        style: text11.copyWith(
                          color: getColor().themeColorWhiteBlack,
                        ),
                      ),
                    ),
                  if (isNew && salePercent > 0)
                    SizedBox(width: width - (48.w * 2) - 10.w),
                  if (salePercent > 0)
                    Container(
                      alignment: Alignment.center,
                      width: 48.w,
                      height: 28.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(29.r),
                        color: colordb3022,
                      ),
                      child: Text(
                        salePercent > 0 ? salePercent.displaySalePercent() : "",
                        style: text11.copyWith(
                          color: getColor().themeColorWhiteBlack,
                        ),
                      ),
                    ),
                ],
              )
            : null,
      ),
    );
  }
}
