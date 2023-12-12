import '../../../core/extensions/ext_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/res/colors.dart';
import '../../../core/res/theme/text_theme.dart';
import '../../../core/res/theme/theme_manager.dart';
import '../filter_model.dart';
import 'filter_container.dart';

class FilterRangeSlider extends StatelessWidget {
  const FilterRangeSlider({
    super.key,
    required this.model,
  });
  final FilterModel model;
  @override
  Widget build(BuildContext context) {
    return FilterContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "${context.loc.price_range}: ",
                style: text16.copyWith(
                  color: getColor().themeColor222222White,
                ),
              ),
              ValueListenableBuilder(
                valueListenable: model.rangePriceSelected,
                builder: (context, rangePrice, child) {
                  return Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: "["),
                        TextSpan(
                          text: "${rangePrice.start.toStringAsFixed(3)}\$",
                          style: text14.copyWith(
                            color: colordb3022,
                          ),
                        ),
                        const TextSpan(
                          text: " -> ",
                        ),
                        TextSpan(
                            text: "${rangePrice.end.toStringAsFixed(3)}\$",
                            style: text14.copyWith(
                              color: colordb3022,
                            )),
                        const TextSpan(text: "]"),
                      ],
                    ),
                    maxLines: 2,
                    style: text14.copyWith(
                      color: getColor().themeColorBlackWhite,
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 36.w),
          ValueListenableBuilder(
            valueListenable: model.rangePrice,
            builder: (context, rangePrice, child) {
              if (rangePrice == null) {
                return _shimmerSlider();
              }
              return ValueListenableBuilder(
                valueListenable: model.rangePriceSelected,
                builder: (context, rangePriceSelected, child) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      _minMaxPrice(rangePrice),
                      _slider(rangePrice, rangePriceSelected),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _shimmerSlider() {
    return Shimmer.fromColors(
      baseColor: getColor().themeColorAAAAAAA.withOpacity(0.4),
      highlightColor: getColor().themeColorAAAAAAA.withOpacity(0.2),
      child: Container(
        height: 16.w,
        width: double.infinity,
        decoration: BoxDecoration(
          color: getColor().themeColorAAAAAAA,
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }

  Widget _slider(RangeValues rangePrice, RangeValues rangePriceSelected) {
    return SliderTheme(
      data: SliderThemeData(
        inactiveTrackColor: colorABB4BD,
        trackHeight: 10.w,
        overlayShape: SliderComponentShape.noOverlay,
      ),
      child: RangeSlider(
        values: rangePriceSelected,
        min: rangePrice.start,
        max: rangePrice.end,
        activeColor: colordb3022,
        onChanged: model.updateRangeValues,
      ),
    );
  }

  Widget _minMaxPrice(RangeValues rangePrice) {
    return Positioned(
      top: -20.w,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "\$${rangePrice.start}",
            style: text14.medium.copyWith(
              color: getColor().themeColorBlack60White,
            ),
          ),
          Text(
            "\$${rangePrice.end}",
            style: text14.medium.copyWith(
              color: getColor().themeColorBlack60White,
            ),
          ),
        ],
      ),
    );
  }
}
