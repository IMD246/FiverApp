import 'package:fiver/data/model/banner_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/res/theme/theme_manager.dart';

class CategoryBanner extends StatelessWidget {
  const CategoryBanner({super.key, required this.banner});
  final ValueNotifier<BannerModel?> banner;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: banner,
      builder: (context, banner, child) {
        if (banner == null) {
          return _shimmerBanner();
        }
        return Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 16.w, horizontal: 16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
          ),
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              banner.image,
              width: 1.sw,
              height: 200.w,
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }

  Widget _shimmerBanner() {
    return Shimmer.fromColors(
      baseColor: getColor().themeColorAAAAAAA.withOpacity(0.4),
      highlightColor: getColor().themeColorAAAAAAA.withOpacity(0.2),
      child: Container(
        width: 1.sw,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: getColor().themeColorAAAAAAA,
        ),
        height: 100.w,
        margin: EdgeInsets.symmetric(vertical: 16.w, horizontal: 16.w),
      ),
    );
  }
}
