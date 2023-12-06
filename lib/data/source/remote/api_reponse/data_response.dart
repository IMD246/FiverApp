class DataResponse {
  dynamic data;
  int code;
  bool success;
  DataResponse(this.data, {this.code = -1, this.success = true});

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'code': code,
      'success': success,
    };
  }
}
