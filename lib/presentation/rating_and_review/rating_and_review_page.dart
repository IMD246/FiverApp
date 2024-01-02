import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fiver/core/base/base_state.dart';
import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:fiver/core/res/theme/text_theme.dart';
import 'package:fiver/presentation/rating_and_review/rating_and_review_model.dart';

import '../../core/res/colors.dart';
import 'components/components.dart';

class RatingAndReviewPage extends StatefulWidget {
  const RatingAndReviewPage({super.key});

  @override
  State<RatingAndReviewPage> createState() => _RatingAndReviewPageState();
}

class _RatingAndReviewPageState
    extends BaseState<RatingAndReviewModel, RatingAndReviewPage> {
  @override
  void initState() {
    super.initState();
    model.init();
  }

  @override
  Widget buildContentView(BuildContext context, RatingAndReviewModel model) {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: model.refresh,
          child: CustomScrollView(
            controller: model.scrollController,
            slivers: <Widget>[
              Appbar(model: model),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(14.w, 14.w, 30.w, 14.w),
                      child: Rating(model: model),
                    ),
                    ReviewList(model: model)
                  ],
                ),
              ),
            ],
          ),
        ),
        _blurBottom(),
      ],
    );
  }

  Widget _blurBottom() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: IgnorePointer(
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.black.withOpacity(0)],
                  stops: const [0.4, 0.75]).createShader(rect);
            },
            blendMode: BlendMode.dstOut,
            child: Container(
              height: 0.3.sh,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Color? get bgColorScaffold => const Color(0xfff9f9f9);

  @override
  bool get isNeedSafeAreaBuildContent => true;

  @override
  bool get isNeedSafeAreaBuildViewByState => false;

  @override
  FloatingActionButtonLocation? get floatingActionButtonLocation =>
      FloatingActionButtonLocation.endDocked;

  @override
  Widget? get floatingActionButton => Padding(
        padding: EdgeInsets.only(bottom: 14.w),
        child: GestureDetector(
          onTap: () async {
            _bottomSheetSendReview(context: context, model: model);
          },
          child: Container(
            width: 160.w,
            height: 36.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.r),
              color: const Color(0xffdb3022),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.edit,
                  color: colorWhite,
                ),
                SizedBox(width: 6.w),
                Text(
                  context.loc.write_a_review,
                  style: text11.copyWith(
                    color: colorWhite,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Future _bottomSheetSendReview({
    required BuildContext context,
    required RatingAndReviewModel model,
  }) {
    return showModalBottomSheet<dynamic>(
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
      clipBehavior: Clip.antiAliasWithSaveLayer,
      constraints: BoxConstraints(maxHeight: 0.87.sh),
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (bottomSheetContext) => StatefulBuilder(
        builder: (context, setState) {
          return WriteReview(model: model);
        },
      ),
    );
  }
}
