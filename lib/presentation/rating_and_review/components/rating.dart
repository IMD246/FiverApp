import 'package:fiver/core/utils/number_util.dart';

import '../../../core/extensions/ext_localization.dart';
import '../../../data/model/rating_product_model.dart';
import '../rating_and_review_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/res/colors.dart';
import '../../../core/res/theme/text_theme.dart';
import '../../../core/res/theme/theme_manager.dart';
import '../../widgets/star_widget.dart';

class Rating extends StatelessWidget {
  const Rating({
    super.key,
    required this.model,
  });

  final RatingAndReviewModel model;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: model.ratingProduct,
      builder: (context, ratingProduct, child) {
        if (ratingProduct == null) {
          return const SizedBox.shrink();
        }
        final List<_StarModel> totalRatingStar = [
          _StarModel(
            starNumber: 5,
            starRatingTotal: (ratingProduct.totalRatingStar5 ?? 0).toInt(),
            starRatingPercent: (ratingProduct.totalRatingStar5Percent ?? 0.0).toDouble(),
          ),
          _StarModel(
            starNumber: 4,
            starRatingTotal: (ratingProduct.totalRatingStar4 ?? 0).toInt(),
            starRatingPercent: (ratingProduct.totalRatingStar4Percent ?? 0.0).toDouble(),
          ),
          _StarModel(
            starNumber: 3,
            starRatingTotal: (ratingProduct.totalRatingStar3 ?? 0).toInt(),
            starRatingPercent: (ratingProduct.totalRatingStar3Percent ?? 0.0).toDouble(),
          ),
          _StarModel(
            starNumber: 2,
            starRatingTotal: (ratingProduct.totalRatingStar2 ?? 0).toInt(),
            starRatingPercent: (ratingProduct.totalRatingStar2Percent ?? 0.0).toDouble(),
          ),
          _StarModel(
            starNumber: 1,
            starRatingTotal: (ratingProduct.totalRatingStar1 ?? 0).toInt(),
            starRatingPercent: (ratingProduct.totalRatingStar1Percent ?? 0.0).toDouble(),
          ),
        ];
        return Padding(
          padding: EdgeInsets.fromLTRB(14.w, 12.w, 0.w, 22.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ratingsAndPercent(context, ratingProduct),
              Expanded(
                child: Column(
                  children: List.generate(
                    totalRatingStar.length,
                    (index) {
                      final star = totalRatingStar[index];
                      return _starItem(star);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _ratingsAndPercent(
      BuildContext context, RatingProductModel ratingProduct) {
    return Column(
      children: [
        Text(
          NumberUtil.formatNumber((ratingProduct.totalRatingAvg ?? 0).toDouble()),
          style: text34.bold.copyWith(
            color: getColor().themeColor222222White,
          ),
        ),
        SizedBox(height: 8.w),
        Text(
          "${ratingProduct.totalRating} ${context.loc.ratings}",
          style: text14.copyWith(
            color: getColor().themeColorGrey,
          ),
        ),
      ],
    );
  }

  Widget _starItem(_StarModel star) {
    return Row(
      children: [
        StarWidget(
          width: 95.w,
          height: 14.w,
          length: star.starNumber,
        ),
        SizedBox(width: 8.w),
        Container(
          constraints: BoxConstraints(
            maxWidth: 80.w,
          ),
          width: (8 + (72 * star.starRatingPercent) / 100).w,
          height: 8.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            color: colordb3022,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              star.starRatingTotal.toString(),
              style: text12.copyWith(
                color: getColor().themeColor222222White,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StarModel {
  final int starNumber;
  final int starRatingTotal;
  final double starRatingPercent;
  _StarModel({
    required this.starNumber,
    required this.starRatingTotal,
    required this.starRatingPercent
  });
}