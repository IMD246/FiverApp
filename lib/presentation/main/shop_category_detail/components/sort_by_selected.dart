import '../../../../data/model/sort_by_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/res/icons.dart';
import '../../../../core/res/theme/text_theme.dart';
import '../../../../core/res/theme/theme_manager.dart';
import '../shop_category_detail_model.dart';

class SortBySelected extends StatelessWidget {
  const SortBySelected({
    super.key,
    required this.model,
  });
  final ShopCategoryDetailModel model;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: model.sortBy,
        builder: (context, sortBy, child) {
          if (sortBy == null) {
            return const SizedBox.shrink();
          }
          bool sortByPrice = sortBy.name.toLowerCase().contains("price");
          if (sortByPrice) {
            return _sortByPrice(sortBy);
          }
          return Text(
            sortBy.name,
            style: text12.bold.copyWith(
              color: getColor().themeColor222222White,
              decoration: TextDecoration.underline,
              decorationThickness: 8.w,
            ),
          );
        },
      ),
    );
  }

  Widget _sortByPrice(SortByModel sortBy) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            model.reverseSortBy(sortBy);
          },
          child: SvgPicture.asset(
            DIcons.reverseSortBy,
            width: 20.w,
            height: 20.w,
            colorFilter: ColorFilter.mode(
              getColor().themeColor222222White,
              BlendMode.srcIn,
            ),
          ),
        ),
        SizedBox(width: 6.w),
        Text(
          sortBy.name,
          style: text11.bold.copyWith(
            color: getColor().themeColor222222White,
          ),
        ),
      ],
    );
  }
}
