import '../../core/base/base_service.dart';
import '../../core/res/images.dart';
import '../model/category_model.dart';
import '../../domain/repositories/category_repository.dart';

class CategoryRepositoryImp extends BaseSerivce implements CategoryRepository {
  @override
  Future<List<CategoryModel>> getCategories() async {
    return [
      CategoryModel(category: "New", urlImages: DImages.cat),
      CategoryModel(category: "Clothes", urlImages: DImages.cat1),
      CategoryModel(category: "Shoes", urlImages: DImages.cat2),
      CategoryModel(category: "Accesories", urlImages: DImages.cat3),
    ];
  }

  @override
  Future<List<CategoryModel>> getProductCategories() async {
    return [
      CategoryModel(category: "T-shirts", urlImages: DImages.cat),
      CategoryModel(category: "Crop tops", urlImages: DImages.cat1),
      CategoryModel(category: "Blouses", urlImages: DImages.cat2),
      CategoryModel(category: "Shoes", urlImages: DImages.cat3),
    ];
  }
}
