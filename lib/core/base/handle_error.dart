import 'package:dio/dio.dart';

class HandleError implements Exception {
  var message = "";
  HandleError.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.sendTimeout:
        message = "Send timeout error!";
        break;
      case DioExceptionType.badCertificate:
        message = "Bad certificate error!";
        break;
      case DioExceptionType.badResponse:
        message = "Bad response error!";
        break;
      case DioExceptionType.cancel:
        message = "Cancel error!";
        break;
      case DioExceptionType.connectionError:
        message = "Connection error!";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout!";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout error!";
        break;
      default:
        message = "Unknown error!";
    }
  }
}
