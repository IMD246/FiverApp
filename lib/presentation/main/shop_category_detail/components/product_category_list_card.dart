import '../../../../data/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/res/colors.dart';
import '../../../../core/res/theme/text_theme.dart';
import '../../../../core/res/theme/theme_manager.dart';
import '../shop_category_detail_model.dart';

class ProductCategoryListCard extends StatelessWidget {
  const ProductCategoryListCard({
    super.key,
    required this.model,
  });
  final ShopCategoryDetailModel model;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.w,
      child: Padding(
        padding: EdgeInsets.only(left: 16.w, top: 10.w),
        child: ValueListenableBuilder(
          valueListenable: model.productCategories,
          builder: (context, productCategories, child) {
            if (productCategories.isEmpty) {
              return _shimmerProductCategoryList();
            }
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productCategories.length,
              itemBuilder: (context, index) {
                final productCategory = productCategories[index];
                return InkWell(
                  onTap: () {
                    model.updateProductCategoryIndex(index);
                  },
                  child: _productCategoryItem(productCategory, index),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _shimmerProductCategoryList() {
    return Shimmer.fromColors(
      baseColor: getColor().themeColorAAAAAAA.withOpacity(0.4),
      highlightColor: getColor().themeColorAAAAAAA.withOpacity(0.2),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _shimmerProductCategoryItem(),
          _shimmerProductCategoryItem(),
          _shimmerProductCategoryItem(),
          _shimmerProductCategoryItem(),
        ],
      ),
    );
  }

  Widget _shimmerProductCategoryItem() {
    return Container(
      width: 100.w,
      height: 44.w,
      margin: EdgeInsets.only(right: 8.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(29.w),
        color: getColor().themeColor222222White,
      ),
    );
  }

  Widget _productCategoryItem(
    CategoryModel productCategory,
    int index,
  ) {
    return ValueListenableBuilder(
      valueListenable: model.productCategoryIndex,
      builder: (context, productCategoryIndex, child) {
        return Container(
          key: ValueKey(productCategory.uid),
          constraints: BoxConstraints(
            minWidth: 100.w,
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          margin: EdgeInsets.only(right: 8.w),
          height: 30.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(29.w),
            color: getColor().themeColor222222White,
          ),
          child: Text(
            productCategory.category,
            style: text14.medium.copyWith(
              color: productCategoryIndex == index
                  ? colordb3022
                  : getColor().themeColorWhiteBlack,
            ),
          ),
        );
      },
    );
  }
}
