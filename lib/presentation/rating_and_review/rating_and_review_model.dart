// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:customize_picker/customize_picker.dart';
import 'package:fiver/core/base/base_model.dart';
import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:fiver/core/utils/media_util.dart';
import 'package:fiver/core/utils/util.dart';
import 'package:fiver/data/model/rating_model.dart';
import 'package:fiver/data/model/review_model.dart';
import 'package:fiver/domain/repositories/common_repository.dart';
import 'package:fiver/domain/repositories/review_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:open_filex/open_filex.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../core/di/locator_service.dart';
import '../../core/utils/isolate_util.dart';
import '../../core/utils/permission_handler_util.dart';

class RatingAndReviewModel extends BaseModel {
  late final String productId;
  final _commonRepo = locator<CommonRepository>();
  final _reviewRepo = locator<ReviewRepository>();

  final ScrollController scrollController = ScrollController();
  final ScrollController reviewsScrollController = ScrollController();

  ValueNotifier<RatingModel?> rating = ValueNotifier(null);

  ValueNotifier<List<ReviewModel>> reviews = ValueNotifier([]);

  final List<ReviewModel> _reviews = [];

  ValueNotifier<bool> isScrollToAppbar = ValueNotifier(false);

  ValueNotifier<bool> withPhotoReview = ValueNotifier(false);

  TextEditingController reviewCtr = TextEditingController();

  int page = 1;

  bool isLoadingMoreData = false;

  double rateStar = 0;

  ValueNotifier<bool> enableSendReview = ValueNotifier(false);

  ValueNotifier<List<AssetEntity>> imagesPicker = ValueNotifier([]);

  ValueNotifier<bool> loadingReview = ValueNotifier(false);

  void init(String productId) {
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
      _reviews.addAll(await _reviewRepo.getReviews(page: page));
      page++;
      setValueNotifier(reviews, _reviews);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      setValueNotifier(reviews, _reviews);
    }
    if (isLoading) {
      setValueNotifier(loadingReview, false);
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
    await _reviewRepo.sendHelpfulReview(isHelpful: review.isHelpful);
    notifyListeners();
    return review.isHelpful;
  }

  void onSendReview() async {
    onRequestReview();
    _resetSendReview();
  }

  Future<void> onRequestReview() async {
    try {
      final content = reviewCtr.text;
      final rate = rateStar;
      final images = imagesPicker.value;
      Isolate? imagesIsolate;
      final getImages = await IsolateUtil.isolateFunction(
        actionFuture: () => MediaUtils. compressImages(images),
        isolate: imagesIsolate,
      ) as List<File>;

      log("compressd images: ${getImages.length}");

      Isolate? base64Isolate;
      final base64Files = await IsolateUtil.isolateFunction(
        actionFuture: () => MediaUtils.toBase64Strings(getImages),
        isolate: base64Isolate,
      ) as List<String>;

      log("toBase64 files: ${base64Files.length}");
      log(content);
      log(rate.toString());

      final res = await _reviewRepo.sendReview(
        content: content,
        rate: rate,
        images: base64Files,
      );

      if (res) {
        EasyLoading.showSuccess("Send review successfully!");
      } else {
        EasyLoading.showSuccess("Send review failed!");
      }
    } catch (e) {
      showErrorException(e);
    }
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
    rating.dispose();
    reviews.dispose();
    isScrollToAppbar.dispose();
    withPhotoReview.dispose();
    reviewCtr.dispose();
    enableSendReview.dispose();
    imagesPicker.dispose();
    loadingReview.dispose();
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
    );
    if (filesResult != null) {
      setValueNotifier(imagesPicker, filesResult);
    }
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

  void _resetSendReview() {
    setValueNotifier(imagesPicker, <AssetEntity>[]);
    reviewCtr.clear();
    rateStar = 0;
    setValueNotifier(enableSendReview, false);
  }
}
