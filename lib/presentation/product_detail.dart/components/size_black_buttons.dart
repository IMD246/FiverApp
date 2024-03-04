import '../product_detail_model.dart';
import '../../widgets/add_to_favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/res/theme/text_theme.dart';
import '../../../core/res/theme/theme_manager.dart';

class SizeBlackButtons extends StatelessWidget {
  const SizeBlackButtons({super.key, required this.model});
  final ProductDetailModel model;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: model.loadingProductDetail,
      builder: (context, loadingProductDetail, child) {
        if (loadingProductDetail) {
          return _shimmer();
        }
        return Row(
          children: [
            Expanded(child: _button(() {}, "Size")),
            SizedBox(width: 16.w),
            Expanded(child: _button(() {}, "BLack")),
            SizedBox(width: 16.w),
            AddToFavoriteButton(
              onTap: () {},
            ),
          ],
        );
      },
    );
  }

  Widget _shimmer() {
    return Shimmer.fromColors(
      baseColor: getColor().themeColorAAAAAAA.withOpacity(0.4),
      highlightColor: getColor().themeColorAAAAAAA.withOpacity(0.2),
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: 138.w,
              height: 40.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: getColor().themeColorAAAAAAA,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Container(
              width: 138.w,
              height: 40.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: getColor().themeColorAAAAAAA,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            width: 36.w,
            height: 36.w,
          ),
        ],
      ),
    );
  }

  Widget _button(VoidCallback onTap, String title) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.r),
      onTap: onTap,
      child: Container(
        width: 138.w,
        height: 40.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: getColor().themeColor222222White,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: text14.medium,
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: getColor().themeColor222222White,
            ),
          ],
        ),
      ),
    );
  }
}
