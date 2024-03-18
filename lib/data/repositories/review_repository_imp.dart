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
  Future<bool> sendReview({
    required String content,
    required num rate,
    required List<String> images,
  }) async {
    // TODO: implement sendReview
    throw UnimplementedError();
  }

  @override
  Future<RatingProductModel> getRatingReviews({required int product_id}) async{
    return await _remoteReviewRepo.getRatingReviews(product_id: product_id);
  }
}
