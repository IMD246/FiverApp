import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/extensions/ext_localization.dart';
import '../../../core/res/colors.dart';
import '../../../core/res/theme/text_theme.dart';
import '../../../core/res/theme/theme_manager.dart';
import '../filter_model.dart';
import 'filter_container.dart';

class FilterColorList extends StatelessWidget {
  const FilterColorList({
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
          Text(
            context.loc.colors,
            style: text16.copyWith(
              color: getColor().themeColor222222White,
            ),
          ),
          SizedBox(height: 36.w),
          SizedBox(
            height: 44.w,
            child: ValueListenableBuilder(
              valueListenable: model.colors,
              builder: (context, colors, child) {
                if (colors.isEmpty) {
                  return _shimmerListColor();
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: colors.length,
                  itemBuilder: (context, index) {
                    final color = colors[index];
                    return GestureDetector(
                      onTap: () => model.updateColorsSelected(color),
                      child: _colorItem(color, model),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _shimmerListColor() {
    return Shimmer.fromColors(
      baseColor: getColor().themeColorAAAAAAA.withOpacity(0.4),
      highlightColor: getColor().themeColorAAAAAAA.withOpacity(0.2),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _shimmerColorItem(),
          _shimmerColorItem(),
          _shimmerColorItem(),
          _shimmerColorItem(),
          _shimmerColorItem(),
          _shimmerColorItem(),
          _shimmerColorItem(),
        ],
      ),
    );
  }

  Widget _shimmerColorItem() {
    return Container(
      height: 40.w,
      width: 40.w,
      margin: EdgeInsets.only(right: 20.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: getColor().themeColorAAAAAAA,
      ),
    );
  }

  Widget _colorItem(Color color, FilterModel model) {
    return ValueListenableBuilder(
      valueListenable: model.colorsSelected,
      builder: (context, _, child) {
        return Container(
          key: ValueKey(color.value),
          height: 44.w,
          width: 44.w,
          margin: EdgeInsets.only(right: 20.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: model.checkMatchedColors(color)
                  ? getColor().themeColor222222White
                  : Colors.transparent,
            ),
          ),
          alignment: Alignment.center,
          child: child!,
        );
      },
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color == colorF6F6F6 ? getColor().themeColorF6F6F6 : color,
        ),
      ),
    );
  }
}
