import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/ext_localization.dart';
import '../../../core/res/colors.dart';
import '../../../core/res/theme/text_theme.dart';
import '../../../core/res/theme/theme_manager.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/default_button.dart';
import '../brand_model.dart';
import 'filter_container.dart';

class FilterBottom extends StatelessWidget {
  const FilterBottom({
    super.key,
    required this.model,
  });
  final BrandModel model;
  @override
  Widget build(BuildContext context) {
    return FilterContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: DefaultButton(
              onTap: model.onDiscard,
              title: context.loc.discard,
              bgColor: Colors.transparent,
              borderColor: getColor().themeColorBlackWhite,
              textColor: getColor().themeColorBlackWhite,
            ),
          ),
          SizedBox(width: 23.w),
          Expanded(
            child: CustomButton(
              isEnable: model.isReadyOnApply,
              onPressed: model.onApply,
              text: context.loc.apply,
              backgroundIsEnable: colordb3022,
              textStyleEnable: text14.medium.copyWith(
                color: colorWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
