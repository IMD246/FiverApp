import 'package:fiver/data/data_source/remote/api_reponse/data_response.dart';
import 'package:fiver/data/model/pagination_model.dart';

class PagedListModel<T> {
  List<T> data = [];

  PaginationModel? paginationModel;

  PagedListModel({
    required this.data,
    this.paginationModel,
  });

  PagedListModel.fromDataResponse(
      DataResponse response,
    T Function(dynamic json) fromJson,
  ) {
    data = (response.data as List).map((e) => fromJson(e)).toList();
    paginationModel = response.paginationModel;
  }
}
