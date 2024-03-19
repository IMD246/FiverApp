import 'package:dio/dio.dart';
import 'package:fiver/data/model/rating_product_model.dart';

import '../../data/model/paged_list_model.dart';
import '../../data/model/review_model.dart';

abstract class ReviewRepository {
  Future<PagedListModel<ReviewProductModel>> getReviews({
    required int productId,
    required int page,
    required int limit,
    required int lastPage,
  });

  Future<bool> sendHelpfulReview({
    required int reviewId,
  });

  Future<ReviewProductModel> sendReview({
    required int productId,
    required String content,
    required int rating,
    required List<MultipartFile> images,
  });

  Future<RatingProductModel> getRatingReviews({
    required int product_id,
  });
}
