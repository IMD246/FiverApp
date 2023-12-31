import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/res/colors.dart';
import '../../../../core/res/theme/text_theme.dart';
import '../../../../core/res/theme/theme_manager.dart';
import '../../../../data/model/category_model.dart';
import '../shop_category_model.dart';

class CategoryListCard extends StatelessWidget {
  const CategoryListCard({
    super.key,
    required this.model,
  });
  final ShopCategoryModel model;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.w,
      child: ValueListenableBuilder(
        valueListenable: model.categories,
        builder: (context, categories, child) {
          if (categories.isEmpty) {
            return _shimmerCategoryList();
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                categories.length,
                (index) {
                  final category = categories[index];
                  return ValueListenableBuilder(
                    valueListenable: model.selectedCategory,
                    builder: (context, selectedGenderIndex, child) {
                      return InkWell(
                        onTap: () {
                          model.updateSelectedCategory(category.id ?? -1);
                        },
                        child: _categoryItem(
                          selectedGenderIndex == category.id,
                          category,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _categoryItem(bool isSelected, CategoryModel category) {
    return Container(
      width: 125.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isSelected ? colordb3022 : Colors.transparent,
            width: 5.w,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: Text(
        category.name ?? "",
        style: text16.copyWith(
          color: getColor().themeColorBlackWhite,
        ),
      ),
    );
  }

  Widget _shimmerCategoryList() {
    return Shimmer.fromColors(
      baseColor: getColor().themeColorAAAAAAA.withOpacity(0.4),
      highlightColor: getColor().themeColorAAAAAAA.withOpacity(0.2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _shimmerCategoryItem(),
          _shimmerCategoryItem(),
          _shimmerCategoryItem(),
        ],
      ),
    );
  }

  Widget _shimmerCategoryItem() {
    return Container(
      width: 100.w,
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      alignment: Alignment.center,
      color: getColor().themeColorAAAAAAA,
    );
  }
}
