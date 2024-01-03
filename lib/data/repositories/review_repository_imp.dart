import 'package:fiver/core/base/base_service.dart';
import 'package:fiver/data/model/review_model.dart';
import 'package:fiver/data/repositories/remote/remote_review_repository.dart';
import 'package:fiver/domain/repositories/review_repository.dart';

import '../../core/constant/constants.dart';
import '../../core/di/locator_service.dart';

class ReviewRepositoryImp extends BaseSerivce implements ReviewRepository {
  final _remoteReviewRepo = locator<ReviewRepository>(
          instanceName: Constants.instanceRemoteReviewRepository)
      as RemoteReviewRepository;

  @override
  Future<List<ReviewModel>> getReviews({required int page}) async {
    return await _remoteReviewRepo.getReviews(page: page);
  }

  @override
  Future<bool> sendHelpfulReview({required bool isHelpful}) async {
    return await _remoteReviewRepo.sendHelpfulReview(isHelpful: isHelpful);
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
}
