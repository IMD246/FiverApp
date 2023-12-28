import 'package:uuidv6/uuidv6.dart';

class ReviewModel {
  final String uid = uuidv6();
  final String name;
  final num rateStar;
  final DateTime createdDate;
  final String content;
  final List<String> images;
  bool isHelpful;
  final String avatar;

  ReviewModel({
    required this.name,
    required this.rateStar,
    required this.createdDate,
    required this.content,
    required this.images,
    required this.isHelpful,
    required this.avatar,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'rateStar': rateStar,
      'createdDate': createdDate.millisecondsSinceEpoch,
      'content': content,
      'images': images,
      'isHelpful': isHelpful,
      'avatar': avatar,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      name: map['name'] ?? '',
      rateStar: map['rateStar'] ?? 0,
      createdDate: DateTime.fromMillisecondsSinceEpoch(map['createdDate']),
      content: map['content'] ?? '',
      images: List<String>.from(map['images']),
      isHelpful: map['isHelpful'] ?? false,
      avatar: map['avatar'] ?? '',
    );
  }
}
