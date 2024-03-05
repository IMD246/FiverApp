import '../../core/base/base_service.dart';
import '../../core/constant/constants.dart';
import '../../core/di/locator_service.dart';
import '../../domain/repositories/review_repository.dart';
import '../model/review_model.dart';
import 'remote/remote_review_repository.dart';

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
