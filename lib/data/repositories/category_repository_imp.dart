import '../../core/base/base_service.dart';
import '../../core/res/images.dart';
import '../../domain/repositories/category_repository.dart';
import '../model/category_model.dart';

class CategoryRepositoryImp extends BaseSerivce implements CategoryRepository {
  @override
  Future<List<CategoryModel>> getCategories() async {
    return [
      CategoryModel(id: 1,category: "New", urlImages: DImages.cat),
      CategoryModel(id: 2, category: "Clothes", urlImages: DImages.cat1),
      CategoryModel(id: 3,category: "Shoes", urlImages: DImages.cat2),
      CategoryModel(id: 4,category: "Accesories", urlImages: DImages.cat3),
    ];
  }

  @override
  Future<List<CategoryModel>> getProductCategories() async {
    return [
      CategoryModel(id: 1,category: "T-shirts", urlImages: DImages.cat),
      CategoryModel(id: 2, category: "Crop tops", urlImages: DImages.cat1),
      CategoryModel(id: 3, category: "Blouses", urlImages: DImages.cat2),
      CategoryModel(id: 4, category: "Shoes", urlImages: DImages.cat3),
    ];
  }
}
