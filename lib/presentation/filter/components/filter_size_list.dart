import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/extensions/ext_localization.dart';
import '../../../core/res/colors.dart';
import '../../../core/res/theme/text_theme.dart';
import '../../../core/res/theme/theme_manager.dart';
import '../../../data/model/size_model.dart';
import '../filter_model.dart';
import 'filter_container.dart';

class FilterSizeList extends StatefulWidget {
  const FilterSizeList({
    super.key,
    required this.model,
  });
  final FilterModel model;

  @override
  State<FilterSizeList> createState() => _FilterSizeListState();
}

class _FilterSizeListState extends State<FilterSizeList> {
  @override
  Widget build(BuildContext context) {
    return FilterContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.loc.sizes,
            style: text16.copyWith(
              color: getColor().themeColor222222White,
            ),
          ),
          SizedBox(height: 36.w),
          SizedBox(
            height: 40.w,
            child: ValueListenableBuilder(
              valueListenable: widget.model.sizes,
              builder: (context, sizes, child) {
                if (sizes.isEmpty) {
                  return _shimmerSizeList();
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: sizes.length,
                  itemBuilder: (context, index) {
                    final size = sizes[index];
                    return GestureDetector(
                      onTap: () {
                        widget.model.updateSize(size.id);
                        setState(() {});
                      },
                      child: _sizeItem(size),
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

  Widget _shimmerSizeList() {
    return Shimmer.fromColors(
      baseColor: getColor().themeColorAAAAAAA.withOpacity(0.4),
      highlightColor: getColor().themeColorAAAAAAA.withOpacity(0.2),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _shimmerSizeItem(),
          _shimmerSizeItem(),
          _shimmerSizeItem(),
          _shimmerSizeItem(),
          _shimmerSizeItem(),
        ],
      ),
    );
  }

  Widget _shimmerSizeItem() {
    return Container(
      height: 40.w,
      width: 40.w,
      margin: EdgeInsets.only(right: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: getColor().themeColorAAAAAAA,
      ),
    );
  }

  Widget _sizeItem(SizeModel size) {
    return Container(
      key: ValueKey(size.id),
      width: 40.w,
      height: 40.w,
      margin: EdgeInsets.only(right: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: getColor().themeColorBlackWhite,
        ),
        color: widget.model.checkMatchedSizes(size.id)
            ? colordb3022
            : getColor().bgColorWhiteBlack,
      ),
      alignment: Alignment.center,
      child: Text(
        size.sizeName,
        style: text14.medium.copyWith(
          color: widget.model.checkMatchedSizes(size.id)
              ? getColor().themeColorWhiteBlack
              : getColor().themeColor222222White,
        ),
      ),
    );
  }
}
