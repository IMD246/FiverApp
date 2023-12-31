import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/res/colors.dart';
import '../../../../core/res/theme/text_theme.dart';
import '../../../../core/res/theme/theme_manager.dart';
import '../../../../data/model/category_model.dart';
import '../shop_category_model.dart';

class SubCategoryList extends StatelessWidget {
  final ShopCategoryModel model;
  const SubCategoryList({
    super.key,
    required this.model,
  });

  Widget _categoryItem(CategoryModel item) {
    return GestureDetector(
      onTap: () {
        model.onGoToCategoryDetail(item);
      },
      child: Container(
        key: ValueKey(item.id),
        width: 343.w,
        height: 100.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 23.0.w),
                child: Text(
                  item.name ?? "",
                  style: text18.copyWith(
                    color: getColor().themeColor222222White,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.r),
                  bottomRight: Radius.circular(8.r),
                ),
                child: Image.network(
                  item.image ?? "",
                  height: 100.w,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryShimmerItem() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.w),
      width: 343.w,
      height: 100.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: colordb3022,
      ),
    );
  }

  Widget _categoryShimmerList() {
    return Shimmer.fromColors(
      baseColor: getColor().themeColorAAAAAAA.withOpacity(0.4),
      highlightColor: getColor().themeColorAAAAAAA.withOpacity(0.2),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _categoryShimmerItem(),
          _categoryShimmerItem(),
          _categoryShimmerItem(),
          _categoryShimmerItem(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 16.w),
              ValueListenableBuilder(
                valueListenable: model.subCategories,
                builder: (context, subCategories, child) {
                  if (subCategories.isEmpty) {
                    return _categoryShimmerList();
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: subCategories.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final category = subCategories[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.w),
                        child: _categoryItem(category),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
