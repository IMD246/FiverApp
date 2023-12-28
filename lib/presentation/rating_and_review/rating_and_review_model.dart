import 'package:fiver/core/base/base_model.dart';
import 'package:fiver/core/utils/util.dart';
import 'package:fiver/data/model/rating_model.dart';
import 'package:fiver/data/model/review_model.dart';
import 'package:fiver/domain/repositories/common_repository.dart';
import 'package:fiver/domain/repositories/review_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../core/di/locator_service.dart';

class RatingAndReviewModel extends BaseModel {
  final _commonRepo = locator<CommonRepository>();
  final _reviewRepo = locator<ReviewRepository>();

  final ScrollController scrollController = ScrollController();
  final ScrollController reviewsScrollController = ScrollController();

  ValueNotifier<RatingModel?> rating = ValueNotifier(null);

  ValueNotifier<List<ReviewModel>> reviews = ValueNotifier([]);

  final List<ReviewModel> _reviews = [];

  ValueNotifier<bool> isScrollToAppbar = ValueNotifier(false);

  ValueNotifier<bool> withPhotoReview = ValueNotifier(false);

  int page = 1;

  bool isLoadingMoreData = false;

  void init() {
    scrollController.addListener(_handlerShowTitleAppbar);
    reviewsScrollController.addListener(_scrollReviewListener);
    _getRating();
    _getReviews();
  }

  void _getReviews({bool isClear = false}) async {
    try {
      if (isClear) {
        _reviews.clear();
        page = 1;
      }
      _reviews.addAll(await _reviewRepo.getReviews(page: page));
      page++;
      setValueNotifier(reviews, _reviews);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      setValueNotifier(reviews, _reviews);
    }
    notifyListeners();
    isLoadingMoreData = false;
  }

  Future<void> refresh() async {
    page = 1;
    _getRating();
    _getReviews(isClear: true);
  }

  void _scrollReviewListener() {
    final isScrollUp = reviewsScrollController.position.userScrollDirection ==
        ScrollDirection.forward;
    if (reviewsScrollController.position.extentAfter < 100 && !isScrollUp) {
      _loadMoreData();
    }
  }

  void _loadMoreData() {
    if (isLoadingMoreData) return;
    isLoadingMoreData = true;
    _getReviews();
  }

  void _getRating() async {
    try {
      final getRating = await _commonRepo.getRating();
      setValueNotifier(rating, getRating);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  void _handlerShowTitleAppbar() {
    if (scrollController.position.pixels >= 40) {
      if (!isScrollToAppbar.value) {
        setValueNotifier(isScrollToAppbar, true);
      }
    } else if (scrollController.position.pixels >= 0 &&
        scrollController.position.pixels <= 35) {
      if (isScrollToAppbar.value) {
        setValueNotifier(isScrollToAppbar, false);
      }
    }
  }

  void onChangedWithPhotoReview(bool value) {
    setValueNotifier(withPhotoReview, value);
  }

  Future<bool> onHelpful(String uid) async {
    final review = _reviews.firstWhere((element) => element.uid == uid);
    review.isHelpful = !review.isHelpful;
    notifyListeners();
    return review.isHelpful;
  }

  void sendReview() {}

  @override
  void disposeModel() {
    isScrollToAppbar.dispose();
    scrollController.removeListener(_handlerShowTitleAppbar);
    scrollController.dispose();
    withPhotoReview.dispose();
    rating.dispose();
    reviews.dispose();
    reviewsScrollController.removeListener(_scrollReviewListener);
    reviewsScrollController.dispose();
    super.disposeModel();
  }
}
