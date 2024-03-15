import '../../../model/pagination_model.dart';

class ApiResponse {
  ApiResponse({
    this.data,
    required this.code,
    required this.success,
    required this.message,
    this.paginationModel,
  });

  int code;
  bool success;
  String message;
  dynamic data;
  PaginationModel? paginationModel;

  factory ApiResponse.fromJson(Map<String, dynamic> json, int code) =>
      ApiResponse(
        code: code,
        success: json["success"] ?? true,
        data: json.containsKey("data") ? json["data"] : null,
        message: json["message"] ?? "",
        paginationModel: json.containsKey("pagination")
            ? PaginationModel.fromJson(json["pagination"])
            : null,
      );

  Map<String, dynamic> toJson() =>
      {"code": code, "success": success, "data": data, "message": message};
}
