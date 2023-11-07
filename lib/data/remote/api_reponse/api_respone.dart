class ApiResponse {
  ApiResponse(
      {this.data,
      required this.code,
      required this.success,
      required this.message});

  String code;
  bool success;
  String message;
  dynamic data;

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        code: json["code"] ?? "",
        success: json["success"] ?? true,
        data: json.containsKey("data") ? json["data"] : null,
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() =>
      {"code": code, "success": success, "data": data, "message": message};
}
