import 'package:fiver/core/base/base_service.dart';
import 'package:fiver/core/res/images.dart';
import 'package:fiver/data/model/category_model.dart';
import 'package:fiver/domain/repositories/category_repository.dart';

class CategoryRepositoryImp extends BaseSerivce implements CategoryReopsitory {
  @override
  Future<List<CateogoryModel>> getCategories() async {
    return [
      CateogoryModel(category: "New", urlImages: DImages.cat),
      CateogoryModel(category: "Clothes", urlImages: DImages.cat1),
      CateogoryModel(category: "Shoes", urlImages: DImages.cat2),
      CateogoryModel(category: "Accesories", urlImages: DImages.cat3),
    ];
  }
}
