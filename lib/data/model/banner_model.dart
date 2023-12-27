class BannerModel {
  final int id;
  final String name;
  final String bannerLink;
  final String image;

  BannerModel({
    required this.id,
    required this.name,
    required this.bannerLink,
    required this.image,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] ?? -1,
      name: json['name'] ?? "",
      bannerLink: json['banner_link'] ?? "",
      image: json['image'] ?? "",
    );
  }
}
