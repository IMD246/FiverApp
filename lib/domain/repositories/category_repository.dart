import 'package:fiver/data/model/category_model.dart';

abstract class CategoryReopsitory {
  Future<List<CateogoryModel>> getCategories();
}
