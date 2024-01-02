import 'package:fiver/core/base/base_service.dart';
import 'package:fiver/data/model/review_model.dart';
import 'package:fiver/domain/repositories/review_repository.dart';

class RemoteReviewRepository extends BaseSerivce implements ReviewRepository {
  @override
  Future<List<ReviewModel>> getReviews({required int page}) async {
    final reviews = [
      ReviewModel(
        name: "Kim Shine",
        rateStar: 3.75,
        createdDate: DateTime.now(),
        content:
            "I loved this dress so much as soon as I tried it on I knew I had to buy it in another color. I am 5'3 about 155lbs and I carry all my weight in my upper body. When I put it on I felt like it thinned me put and I got so many compliments.",
        images: [
          "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg",
          "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg",
          "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg"
        ],
        isHelpful: true,
        avatar:
            'https://anhcuoiviet.vn/wp-content/uploads/2022/11/avatar-dep-dang-yeu-nu-5.jpg',
      ),
      ReviewModel(
          name: "Matilda Brown",
          rateStar: 3,
          createdDate: DateTime.now(),
          content:
              "I loved this dress so much as soon as I tried it on I knew I had to buy it in another color. I am 5'3 about 155lbs and I carry all my weight in my upper body. When I put it on I felt like it thinned me put and I got so many compliments.",
          images: [],
          isHelpful: false,
          avatar:
              'https://anhcuoiviet.vn/wp-content/uploads/2022/11/avatar-dep-dang-yeu-nu-5.jpg'),
      ReviewModel(
          name: "Kim Shine",
          rateStar: 0,
          createdDate: DateTime.now(),
          content:
              "The dress is great! Very classy and comfortable. It fit perfectly! I'm 5'7 and 130 pounds. I am a 34B chest. This dress would be too long for those who are shorter but could be hemmed. I wouldn't recommend it for those big chested as I am smaller chested and it fit me perfectly. The underarms were not too wide and the dress was made well.",
          images: [
            "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg",
            "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg",
          ],
          isHelpful: false,
          avatar:
              'https://anhcuoiviet.vn/wp-content/uploads/2022/11/avatar-dep-dang-yeu-nu-5.jpg'),
    ];
    return reviews;
  }

  @override
  Future<bool> sendHelpfulReview({required bool isHelpful}) async {
    return true;
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
