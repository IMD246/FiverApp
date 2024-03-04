import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/extensions/ext_localization.dart';
import '../../../../core/res/colors.dart';
import '../../../../core/res/images.dart';
import '../../../../core/res/theme/text_theme.dart';
import '../../../../core/res/theme/theme_manager.dart';
import '../../../../data/model/sort_by_model.dart';
import '../shop_category_detail_model.dart';

class ViewBy extends StatelessWidget {
  const ViewBy({
    super.key,
    required this.model,
  });
  final ShopCategoryDetailModel model;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        _bottomSheetViewBy(model, context).then((value) {
          model.updateSortBy(value);
        });
      },
      child: Image.asset(
        DImages.viewBy,
        width: 24.w,
        height: 24.w,
        fit: BoxFit.scaleDown,
        color: getColor().themeColorBlackWhite,
        colorBlendMode: BlendMode.srcIn,
      ),
    );
  }

  Future<SortByModel?> _bottomSheetViewBy(
    ShopCategoryDetailModel model,
    BuildContext context,
  ) {
    SortByModel? currentSortBy = model.sortBySelected.value;
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            34.r,
          ),
          topRight: Radius.circular(
            34.r,
          ),
        ),
      ),
      backgroundColor: getColor().bgColorWhiteBlack,
      context: context,
      builder: (context) => PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          if (didPop) {
            return;
          }
          Navigator.pop(context, currentSortBy);
        },
        child: SafeArea(
          child: StatefulBuilder(
            builder: (context, setState) {
              return SizedBox(
                height: 0.46.sh,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 16.w,
                    ),
                    Center(
                      child: Text(
                        context.loc.sort_by,
                        style: text18.copyWith(
                          color: getColor().themeColorBlackWhite,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 33.w),
                    _sortByList(
                      model,
                      (sortBy) {
                        setState(
                          () {
                            if (currentSortBy?.id == sortBy.id) {
                              currentSortBy = null;
                            } else {
                              currentSortBy = sortBy;
                            }
                          },
                        );
                      },
                      currentSortBy,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _sortByList(
    ShopCategoryDetailModel model,
    void Function(SortByModel sortBy) onTap,
    SortByModel? currentSortBy,
  ) {
    final sortByList = model.sortByList.value;
    return Expanded(
        child: sortByList.isEmpty
            ? _shimmerSortByList()
            : ListView.builder(
                itemCount: sortByList.length,
                itemBuilder: (context, index) {
                  final sortBy = sortByList[index];
                  return InkWell(
                    onTap: () {
                      onTap(sortBy);
                    },
                    child: _sortByItem(
                      currentSortBy?.id == sortBy.id,
                      sortBy,
                    ),
                  );
                },
              ));
  }

  Widget _sortByItem(bool isSelected, SortByModel sortBy) {
    return Container(
      key: ValueKey(sortBy.id),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      alignment: Alignment.center,
      height: 48.w,
      decoration: BoxDecoration(
        color: isSelected ? colordb3022 : null,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          sortBy.name,
          style: text16.copyWith(
            color: isSelected ? colorWhite : getColor().themeColor222222White,
          ),
        ),
      ),
    );
  }

  Widget _shimmerSortByList() {
    return Shimmer.fromColors(
      baseColor: getColor().themeColorAAAAAAA.withOpacity(0.4),
      highlightColor: getColor().themeColorAAAAAAA.withOpacity(0.2),
      child: ListView(
        children: [
          _shimmerSortByItem(),
          _shimmerSortByItem(),
          _shimmerSortByItem(),
          _shimmerSortByItem(),
          _shimmerSortByItem(),
        ],
      ),
    );
  }

  Widget _shimmerSortByItem() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.w),
      width: 100.w,
      height: 48.w,
      alignment: Alignment.center,
      color: getColor().themeColor222222White,
    );
  }
}
