import '../../../core/extensions/ext_localization.dart';
import '../rating_and_review_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/res/theme/theme_manager.dart';
import '../../widgets/back_button.dart';

class Appbar extends StatelessWidget {
  const Appbar({super.key, required this.model});
  final RatingAndReviewModel model;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: model.isScrollToAppbar,
      builder: (context, isScrollToAppbar, child) {
        return SliverAppBar(
          key: UniqueKey(),
          leading: Padding(
            padding: EdgeInsets.only(left: 14.w),
            child: const BackButtonWidget(),
          ),
          centerTitle: true,
          leadingWidth: 0,
          pinned: true,
          backgroundColor: isScrollToAppbar ? Colors.white : Colors.transparent,
          elevation: isScrollToAppbar ? 0.5 : 0,
          expandedHeight: 100.w,
          title: Text(
            isScrollToAppbar ? context.loc.rating_and_reviews : "",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: getColor().themeColor222222White,
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.zero,
            centerTitle: true,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 14.w),
                    child: Text(
                      !isScrollToAppbar
                          ? context.loc.rating_and_reviews_title
                          : "",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.w,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
