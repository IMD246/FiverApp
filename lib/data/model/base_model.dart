class BaseModel {
  int? statusCode;

  String? errorMessage;

  String? errorCode;

  bool get success => statusCode == 200;

  BaseModel({
    this.statusCode,
    this.errorMessage,
    this.errorCode,
  });
}

abstract class BaseResponseModel<T> extends BaseModel {
  T fromJson(Map<String, dynamic> map);
}

abstract class BaseRequestModel {
  Map<String, dynamic> toJson();
}
