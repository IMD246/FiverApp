class CateogoryModel {
  final String category;
  final String urlImages;
  CateogoryModel({
    required this.category,
    required this.urlImages,
  });

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'urlImages': urlImages,
    };
  }

  factory CateogoryModel.fromMap(Map<String, dynamic> map) {
    return CateogoryModel(
      category: map['category'] ?? '',
      urlImages: map['urlImages'] ?? '',
    );
  }
}
