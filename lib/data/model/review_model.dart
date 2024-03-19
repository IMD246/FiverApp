import 'dart:io';

class ReviewProductModel {
  int? id;
  int? userId;
  int? rating;
  String? content;
  int? productId;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isHelpful;
  Author? author;
  List<String>? images;

  ReviewProductModel({
    this.id,
    this.userId,
    this.rating,
    this.content,
    this.productId,
    this.createdAt,
    this.updatedAt,
    this.isHelpful,
    this.author,
    this.images,
  });

  ReviewProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? -1;
    userId = json['user_id'] ?? -1;
    rating = json['rating'] ?? 0;
    content = json['content'] ?? "";
    productId = json['product_id'] ?? -1;
    createdAt =
        json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
    updatedAt =
        json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null;
    isHelpful = json['is_helpful'] ?? false;
    if (json['user'] != null) {
      author = Author.fromJson(json['user']);
    } else {
      author = null;
    }
    if (json['final_images'] != null) {
      images = json['final_images'].cast<String>();
    } else {
      images = [];
    }
  }

  ReviewProductModel.copyWith(ReviewProductModel model) {
    id = model.id;
    userId = model.userId;
    rating = model.rating;
    content = model.content;
    productId = model.productId;
    createdAt = model.createdAt;
    updatedAt = model.updatedAt;
    isHelpful = model.isHelpful;
    author = model.author;
    images = model.images;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['rating'] = rating;
    data['content'] = content;
    data['product_id'] = productId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_helpful'] = isHelpful;
    if (author != null) {
      data['user'] = author!.toJson();
    }
    data['final_images'] = images;
    return data;
  }

  ReviewProductModel copyWith({
    required String content,
    required int rating,
    required List<File> images,
  }) {
    return ReviewProductModel(
      id: id,
      userId: userId,
      rating: rating,
      content: content,
      productId: productId,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isHelpful: isHelpful,
      author: author,
    );
  }
}

class Author {
  int? id;
  String? fullName;
  String? avatar;

  Author({this.id, this.fullName, this.avatar});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['avatar'] = avatar;
    return data;
  }
}
