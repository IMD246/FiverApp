import '../../widgets/custom_button.dart';

import '../../../core/extensions/ext_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/res/colors.dart';
import '../../../core/res/images.dart';
import '../../../core/res/theme/text_theme.dart';
import '../../../core/res/theme/theme_manager.dart';
import '../../widgets/default_button.dart';
import '../filter_model.dart';
import 'filter_container.dart';

class FilterBottom extends StatelessWidget {
  const FilterBottom({
    super.key,
    required this.model,
  });
  final FilterModel model;
  @override
  Widget build(BuildContext context) {
    return FilterContainer(
      child: Column(
        children: [
          InkWell(
            onTap: model.onGoToBrandPage,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.loc.brand,
                      style: text16.copyWith(
                        color: getColor().themeColor222222White,
                      ),
                    ),
                    SizedBox(height: 3.w),
                    ValueListenableBuilder(
                      valueListenable: model.brandsSelected,
                      builder: (context, brands, child) {
                        return SizedBox(
                          width: 0.8.sw,
                          child: Text(
                            brands.isEmpty
                                ? context.loc.no_brands_selected
                                : model.getBrandsName(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: text11.copyWith(
                              color: getColor().themeColorBlackABB4BD,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Image.asset(
                  DImages.arrowRight,
                  color: getColor().themeColor222222White,
                ),
              ],
            ),
          ),
          SizedBox(height: 20.w),
          Row(
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
        ],
      ),
    );
  }
}
