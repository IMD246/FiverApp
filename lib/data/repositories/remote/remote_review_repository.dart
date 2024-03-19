
import 'package:dio/dio.dart';
import 'package:fiver/core/utils/collection_util.dart';
import 'package:fiver/data/data_source/remote/network/network_url.dart';
import 'package:fiver/data/model/rating_product_model.dart';

import '../../../core/base/base_service.dart';
import '../../model/paged_list_model.dart';
import '../../model/review_model.dart';
import '../../../domain/repositories/review_repository.dart';

class RemoteReviewRepository extends BaseSerivce implements ReviewRepository {
  @override
  Future<bool> sendHelpfulReview({required int reviewId}) async {
    final res = await post(
      REVIEW_HELPFUL,
      data: {
        'review_id': reviewId,
      },
    );
    return res.data;
  }

  @override
  Future<ReviewProductModel> sendReview({
    required int productId,
    required String content,
    required int rating,
    required List<MultipartFile> images,
  }) async {
    final formData = FormData.fromMap({
      'product_id': productId,
      'rating': rating,
    });

    if (!content.isNullOrEmpty) {
      formData.fields.add(MapEntry('content', content));
    }

    formData.files.addAll(
      images.map(
        (image) => MapEntry('images[]', image),
      ),
    );

    final res = await post(
      SEND_REVIEW,
      data: formData,
    );

    return ReviewProductModel.fromJson(res.data);
  }

  @override
  Future<RatingProductModel> getRatingReviews({required int product_id}) async {
    final res = await get(
      GET_PRODUCT_RATING,
      params: {
        'product_id': product_id,
      },
    );

    return RatingProductModel.fromJson(res.data);
  }

  @override
  Future<PagedListModel<ReviewProductModel>> getReviews({
    required int productId,
    required int limit,
    required int page,
    required int lastPage,
  }) async {
    final res = await get(
      GET_PRODUCT_REVIEW,
      params: {
        'product_id': productId,
        'limit': limit,
        'page': page,
      },
    );

    final pagedList = PagedListModel.fromDataResponse(
      res,
      (json) => ReviewProductModel.fromJson(json),
    );

    return pagedList;
  }
}
