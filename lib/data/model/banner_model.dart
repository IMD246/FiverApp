class BannerModel {
  String urlImage;
  String content;
  BannerModel({
    required this.urlImage,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      'urlImage': urlImage,
      'content': content,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      urlImage: map['urlImage'] ?? '',
      content: map['content'] ?? '',
    );
  }
}
