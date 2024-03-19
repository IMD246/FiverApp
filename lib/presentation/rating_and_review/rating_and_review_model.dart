// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:isolate';

import 'package:customize_picker/customize_picker.dart';
import 'package:dio/dio.dart';
import 'package:fiver/core/base/base_model.dart';
import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:fiver/core/utils/media_util.dart';
import 'package:fiver/core/utils/util.dart';
import 'package:fiver/data/model/rating_product_model.dart';
import 'package:fiver/data/model/review_model.dart';
import 'package:fiver/domain/repositories/review_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:open_filex/open_filex.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../core/constant/api_constants.dart';
import '../../core/di/locator_service.dart';
import '../../core/utils/isolate_util.dart';
import '../../core/utils/permission_handler_util.dart';

class RatingAndReviewModel extends BaseModel {
  late final int productId;
  final _reviewRepo = locator<ReviewRepository>();

  final ScrollController scrollController = ScrollController();
  final ScrollController reviewsScrollController = ScrollController();

  ValueNotifier<RatingProductModel?> ratingProduct = ValueNotifier(null);

  ValueNotifier<List<ReviewProductModel>> reviews = ValueNotifier([]);

  final List<ReviewProductModel> _reviews = [];

  ValueNotifier<bool> isScrollToAppbar = ValueNotifier(false);

  ValueNotifier<bool> withPhotoReview = ValueNotifier(false);

  TextEditingController reviewCtr = TextEditingController();

  int page = 1;

  bool isLoadingMoreData = false;

  double rateStar = 0;

  ValueNotifier<bool> enableSendReview = ValueNotifier(false);

  ValueNotifier<List<AssetEntity>> imagesPicker = ValueNotifier([]);

  ValueNotifier<bool> loadingReview = ValueNotifier(false);

  int? lastPage;

  ValueNotifier<int?> totalReview = ValueNotifier(null);

  void init(int productId) {
    this.productId = productId;
    scrollController.addListener(_handlerShowTitleAppbar);
    reviewsScrollController.addListener(_scrollReviewListener);
    _getRating();
    _getReviews(isLoading: true);
  }

  void _updateEnableSendReview() {
    setValueNotifier(enableSendReview, rateStar != 0);
  }

  void _getReviews({
    bool isClear = false,
    bool isLoading = false,
  }) async {
    if (isLoading) {
      setValueNotifier(loadingReview, true);
    }
    try {
      if (isClear) {
        _reviews.clear();
        page = 1;
      }

      if (lastPage != null && page > lastPage!) {
        return;
      }

      _reviews.addAll(await _onHandleGetReviews());
      page++;
      setValueNotifier(reviews, [..._reviews]);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      setValueNotifier(reviews, _reviews);
    }
    if (isLoading) {
      setValueNotifier(loadingReview, false);
    }
    isLoadingMoreData = false;
  }

  Future<List<ReviewProductModel>> _onHandleGetReviews() async {
    if (lastPage != null && page > lastPage!) {
      return [];
    }
    final pagedList = await _reviewRepo.getReviews(
      productId: productId,
      page: page,
      limit: ApiConstant.PAGE_SIZE,
      lastPage: lastPage ?? 10000,
    );

    lastPage = pagedList.paginationModel?.lastPage;
    setValueNotifier(totalReview, pagedList.paginationModel?.total);

    return pagedList.data;
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
      final getRating = await _reviewRepo.getRatingReviews(
        product_id: productId,
      );
      setValueNotifier(ratingProduct, getRating);
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

  Future<bool> onHelpful(int id) async {
    final review = _reviews.firstWhere((element) => element.id == id);
    review.isHelpful = await _reviewRepo.sendHelpfulReview(reviewId: id);
    setValueNotifier(reviews, [..._reviews]);
    return review.isHelpful ?? false;
  }

  void onSendReview() async {
    onRequestReview();
  }

  void onRequestReview() {
    execute(
      needShowLoading: false,
          () async {
        final content = reviewCtr.text;
        final images = imagesPicker.value;

        Isolate? imagesIsolate;

        final getImages = await IsolateUtil.isolateFunction(
          actionFuture: () => MediaUtils.compressImages(images),
          isolate: imagesIsolate,
        ) as List<File>;

        Isolate? formDataIsolate;

        final multipartImages = await IsolateUtil.isolateFunction(
          actionFuture: () => MediaUtils.settingMultipartFiles(
             getImages
          ),
          isolate: formDataIsolate,
        ) as List<MultipartFile>;

        final result = await _reviewRepo.sendReview(
          productId: productId,
          content: content,
          rating: rateStar.toInt(),
          images: multipartImages,
        );

        _onAddReviewToTop(result);

        EasyLoading.showSuccess(currentContext.loc.send_review_success);

        _resetSendReview();
      },
    );
  }

  void onRatingUpdate(double value) {
    if (rateStar == value) return;
    rateStar = value;
    _updateEnableSendReview();
  }

  @override
  void disposeModel() {
    scrollController.removeListener(_handlerShowTitleAppbar);
    scrollController.dispose();
    reviewsScrollController.removeListener(_scrollReviewListener);
    reviewsScrollController.dispose();
    ratingProduct.dispose();
    reviews.dispose();
    isScrollToAppbar.dispose();
    withPhotoReview.dispose();
    reviewCtr.dispose();
    enableSendReview.dispose();
    imagesPicker.dispose();
    loadingReview.dispose();
    totalReview.dispose();
    super.disposeModel();
  }

  void onFiles(BuildContext context) {
    _onGallery(context);

    _updateEnableSendReview();
  }

  void _onGallery(BuildContext context) async {
    final permission =
    await PermissionHandlerUtil.checkAndRequestPermissionPhoto();

    if (!permission) return;

    final filesResult = await PickerHelper.pickAssets(
      requestType: RequestType.image,
      context: context,
      locale: currentContext.loc.localeName,
      maxSelect: 3,
      selectedAssetlist: imagesPicker.value,
    ) as List<AssetEntity>;


    for (final fileResult in filesResult) {
      final file = await fileResult.file;
      final checkFileIsInvalid = await MediaUtils.checkFileSizeIsInvalid(file);
      if(checkFileIsInvalid)
      {
        EasyLoading.showError(currentContext.loc.error_size_file(10));
        return;
      }
    }

    setValueNotifier(imagesPicker, filesResult);
  }

  void onDeleteFileItem(int index) {
    imagesPicker.value.removeAt(index);
  }

  void onOpenFile(String filePath) async {
    try {
      await OpenFilex.open(
        filePath,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void _onAddReviewToTop(ReviewProductModel review) {
    _reviews.insert(0, review);
    setValueNotifier(reviews, [..._reviews]);
    setValueNotifier(totalReview, totalReview.value! + 1);
    _getRating();
  }
  void _resetSendReview() {
    setValueNotifier(imagesPicker, <AssetEntity>[]);
    reviewCtr.clear();
    rateStar = 0;
    setValueNotifier(enableSendReview, false);
  }
}
