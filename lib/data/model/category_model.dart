import 'package:fiver/data/model/banner_model.dart';

class CategoryModel {
  int? id;
  String? name;
  String? image;
  int? order;
  List<CategoryModel>? childs;
  BannerModel? banner;

  CategoryModel({
    this.id,
    this.name,
    this.image,
    this.order,
    this.childs,
    this.banner,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    order = json['order'];
    if (json['childs'] != null) {
      childs = <CategoryModel>[];
      json['childs'].forEach((v) {
        childs!.add(CategoryModel.fromJson(v));
      });
    }
    banner =
        json['banner'] != null ? BannerModel.fromJson(json['banner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['order'] = order;
    if (childs != null) {
      data['childs'] = childs!.map((v) => v.toJson()).toList();
    }
    if (banner != null) {
      data['banner'] = banner!.toJson();
    }
    return data;
  }
}
