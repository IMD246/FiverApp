import '../../../core/res/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProductList extends StatelessWidget {
  const ShimmerProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return _shimmerProductList();
  }

  Widget _shimmerProductList() {
    return Shimmer.fromColors(
      baseColor: getColor().themeColorAAAAAAA.withOpacity(0.4),
      highlightColor: getColor().themeColorAAAAAAA.withOpacity(0.2),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.46,
        ),
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(8.w),
        itemCount: 4,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return _shimmerProductItem(index);
        },
      ),
    );
  }

  Widget _shimmerProductItem(int index) {
    return Padding(
      padding: EdgeInsets.only(right: (index % 2 != 0) ? 0 : 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 250.w,
            decoration: BoxDecoration(
              color: getColor().themeColorAAAAAAA,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          SizedBox(height: 10.w),
          Container(
            height: 20.w,
            color: getColor().themeColorAAAAAAA,
          ),
          SizedBox(height: 10.w),
          Container(
            height: 20.w,
            color: getColor().themeColorAAAAAAA,
          ),
          SizedBox(height: 10.w),
          Container(
            height: 20.w,
            color: getColor().themeColorAAAAAAA,
          ),
          SizedBox(height: 10.w),
          Container(
            height: 20.w,
            color: getColor().themeColorAAAAAAA,
          ),
          SizedBox(height: 10.w),
        ],
      ),
    );
  }
}
