import '../../data/model/review_model.dart';

abstract class ReviewRepository {
  Future<List<ReviewModel>> getReviews({
    required int page,
  });

  Future<bool> sendHelpfulReview({required bool isHelpful});

  Future<bool> sendReview({
    required String content,
    required num rate,
    required List<String> images,
  });
}
