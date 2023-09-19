import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fiven/base/handle_error.dart';
import 'package:fiven/constant/enum.dart';
import 'package:fiven/data/model/base_model.dart';
import 'package:get_it/get_it.dart';

import '../constant/constants.dart';

class RestClient {
  late final Dio dio;

  init(
    String baseUrl, {
    Duration? connectTimeOut,
    Duration? sendTimeOut,
    Duration? receiveTimeOut,
    String? token,
  }) {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: connectTimeOut ?? Constants.connectTimeOut,
      sendTimeout: sendTimeOut ?? Constants.sendTimeOut,
      receiveTimeout: receiveTimeOut ?? Constants.receiveTimeOut,
    );
    dio = Dio(baseOptions);
    final RequestOptions requestOptions = RequestOptions(
      headers: {"Authorization": "Bearer ${token ?? ""}"},
    );

    dio.interceptors.add(
      const Interceptor()
        ..onRequest(
          requestOptions,
          RequestInterceptorHandler(),
        ),
    );
  }

  Future<TResponse> request<TResponse extends BaseResponseModel,
      TRequest extends BaseRequestModel>(
    MethodType methodType,
    String path, {
    Map<String, dynamic>? queryParams,
    TRequest? request,
    Options? options,
  }) async {
    try {
      final getResponse = await dio.request(
        path,
        queryParameters: queryParams,
        data: jsonEncode(request?.toJson()),
        options: _checkOptions(methodType, options),
      );
      final response = GetIt.instance.get<TResponse>();
      response.statusCode = getResponse.statusCode;
      response.errorCode = getResponse.statusCode.toString();
      response.errorMessage = getResponse.statusMessage;
      if (response.success) {
        final newResponse = response.fromJson(getResponse.data);
        newResponse.statusCode = response.statusCode;
        newResponse.errorCode = response.errorCode;
        return newResponse;
      }
      return response;
    } on DioException catch (e) {
      throw HandleError.fromDioError(e);
    } catch (e) {
      rethrow;
    }
  }
}

Options _checkOptions(MethodType methodType, Options? options) {
  options ??= Options();
  options.method = methodType.name;
  return options;
}
