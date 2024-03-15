import '../../../model/pagination_model.dart';

class DataResponse {
  dynamic data;
  int code;
  bool success;
  PaginationModel? paginationModel;

  DataResponse(
    this.data, {
    this.code = -1,
    this.success = true,
    this.paginationModel,
  });

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'code': code,
      'success': success,
      'paginationModel': paginationModel,
    };
  }
}
