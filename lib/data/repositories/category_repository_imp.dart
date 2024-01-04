import '../data_source/remote/network/network_url.dart';

import '../../core/base/base_service.dart';
import '../../domain/repositories/category_repository.dart';
import '../model/category_model.dart';

class CategoryRepositoryImp extends BaseSerivce implements CategoryRepository {
  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await get(
      GET_CATEGORY,
    );
    return List.from(
      (response.data as List).map((e) => CategoryModel.fromJson(e)).toList(),
    );
  }

  @override
  Future<List<CategoryModel>> getProductCategories() async {
    return [];
    // return [
    //   CategoryModel(id: 1,category: "T-shirts", urlImages: DImages.cat),
    //   CategoryModel(id: 2, category: "Crop tops", urlImages: DImages.cat1),
    //   CategoryModel(id: 3, category: "Blouses", urlImages: DImages.cat2),
    //   CategoryModel(id: 4, category: "Shoes", urlImages: DImages.cat3),
    // ];
  }
  
  @override
  Future<CategoryModel> getCategoryById(int id)async {
     final response = await get(
      "$GET_CATEGORY_BY_ID/$id",
    );
    return CategoryModel.fromJson(response.data);
  }
}
