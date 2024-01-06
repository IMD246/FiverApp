import '../../../core/extensions/ext_localization.dart';
import '../rating_and_review_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/res/colors.dart';
import '../../../core/res/theme/text_theme.dart';
import '../../../core/res/theme/theme_manager.dart';
import '../../../data/model/rating_model.dart';
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
      valueListenable: model.rating,
      builder: (context, rating, child) {
        if (rating == null) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: EdgeInsets.fromLTRB(14.w, 12.w, 0.w, 22.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ratingsAndPercent(context, rating),
              Expanded(
                child: Column(
                  children: List.generate(
                    rating.starList.length,
                    (index) {
                      final star = rating.starList[index];
                      return _starItem(star, rating.ratings);
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

  Widget _ratingsAndPercent(BuildContext context, RatingModel rating) {
    return Column(
      children: [
        Text(
          rating.percentRatings.toString(),
          style: text34.bold.copyWith(
            color: getColor().themeColor222222White,
          ),
        ),
        SizedBox(height: 8.w),
        Text(
          "${rating.ratings} ${context.loc.ratings}",
          style: text14.copyWith(
            color: getColor().themeColorGrey,
          ),
        ),
      ],
    );
  }

  Widget _starItem(StarModel star, num ratings) {
    return Row(
      children: [
        StarWidget(
          width: 95.w,
          height: 14.w,
          length: star.starNumber,
        ),
        SizedBox(width: 8.w),
        Container(
          width: (8 + (144 * ((star.starRating * 100) / ratings)) / 100).w,
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
              star.starRating.toString(),
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
