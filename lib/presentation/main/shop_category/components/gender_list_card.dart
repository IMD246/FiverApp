import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/res/colors.dart';
import '../../../../core/res/theme/text_theme.dart';
import '../../../../core/res/theme/theme_manager.dart';
import '../../../../data/model/gender_model.dart';
import '../shop_category_model.dart';

class GenderListCard extends StatelessWidget {
  const GenderListCard({
    super.key,
    required this.model,
  });
  final ShopCategoryModel model;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.w,
      child: ValueListenableBuilder(
        valueListenable: model.genders,
        builder: (context, genders, child) {
          if (genders.isEmpty) {
            return _shimmerGenderList();
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                genders.length,
                (index) {
                  final gender = genders[index];
                  return ValueListenableBuilder(
                    valueListenable: model.selectedGenderIndex,
                    builder: (context, selectedGenderIndex, child) {
                      return InkWell(
                        onTap: () {
                          model.updateSelectedGenderIndex(index);
                        },
                        child: _genderItem(
                          selectedGenderIndex == index,
                          gender,
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

  Widget _genderItem(bool isSelected, GenderModel gender) {
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
        gender.gender,
        style: text16.copyWith(
          color: getColor().themeColorBlackWhite,
        ),
      ),
    );
  }

  Widget _shimmerGenderList() {
    return Shimmer.fromColors(
      baseColor: getColor().themeColorAAAAAAA.withOpacity(0.4),
      highlightColor: getColor().themeColorAAAAAAA.withOpacity(0.2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _shimmerGenderItem(),
          _shimmerGenderItem(),
          _shimmerGenderItem(),
        ],
      ),
    );
  }

  Widget _shimmerGenderItem() {
    return Container(
      width: 100.w,
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      alignment: Alignment.center,
      color: getColor().themeColorAAAAAAA,
    );
  }
}
