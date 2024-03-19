import 'package:dio/dio.dart';
import 'package:fiver/data/model/rating_product_model.dart';

import '../../core/base/base_service.dart';
import '../../core/constant/constants.dart';
import '../../core/di/locator_service.dart';
import '../../domain/repositories/review_repository.dart';
import '../model/paged_list_model.dart';
import '../model/review_model.dart';
import 'remote/remote_review_repository.dart';

class ReviewRepositoryImp extends BaseSerivce implements ReviewRepository {
  final _remoteReviewRepo = locator<ReviewRepository>(
          instanceName: Constants.instanceRemoteReviewRepository)
      as RemoteReviewRepository;

  @override
  Future<PagedListModel<ReviewProductModel>> getReviews({
    required int productId,
    required int limit,
    required int page,
    required int lastPage,
  }) async {
    return await _remoteReviewRepo.getReviews(
      productId: productId,
      limit: limit,
      page: page,
      lastPage: lastPage,
    );
  }

  @override
  Future<bool> sendHelpfulReview({required int reviewId}) async {
    return await _remoteReviewRepo.sendHelpfulReview(reviewId: reviewId);
  }

  @override
  Future<ReviewProductModel> sendReview({
    required int productId,
    required String content,
    required int rating,
    required List<MultipartFile> images,
  }) async {
    return await _remoteReviewRepo.sendReview(
      productId: productId,
      content: content,
      rating: rating,
      images: images,
    );
  }

  @override
  Future<RatingProductModel> getRatingReviews({required int product_id}) async{
    return await _remoteReviewRepo.getRatingReviews(product_id: product_id);
  }
}
