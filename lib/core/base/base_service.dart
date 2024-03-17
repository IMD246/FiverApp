import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';

import '../../data/data_source/remote/api_reponse/api_respone.dart';
import '../../data/data_source/remote/api_reponse/data_response.dart';
import '../../data/data_source/remote/api_reponse/exceptions/api_exception.dart';
import 'rest_client.dart';

abstract class BaseSerivce {
  Future<dynamic> getWithCustomUrl(
    String customUrl,
    String path, {
    Map<String, dynamic>? params,
  }) async {
    final response = await RestClient.getDio(customUrl: customUrl).get(
      path,
      queryParameters: params,
    );
    return response.data;
  }

  Future<DataResponse> uploadMedia(
    String path,
    FormData formData,
  ) async {
    final response = await RestClient.getDio(isUpload: true).post(
      path,
      data: formData,
    );
    return _handleResponse(response);
  }

  Future<DataResponse> get(String path, {Map<String, dynamic>? params}) async {
    final response = await RestClient.getDio().get(
      path,
      queryParameters: params,
    );

    return _handleResponse(response);
  }

  Future<DataResponse> post(
    String path, {
    data,
    bool enableCache = false,
  }) async {
    final response = await RestClient.getDio().post(
      path,
      data: data,
    );

    return _handleResponse(response);
  }

  Future<DataResponse> put(String path, {data}) async {
    final response = await RestClient.getDio().put(
      path,
      data: data,
    );

    return _handleResponse(response);
  }

  Future<DataResponse> delete(String path, {data}) async {
    final response = await RestClient.getDio().delete(
      path,
      data: data,
    );

    return _handleResponse(response);
  }

  Future<DataResponse> postUpload(String path, {data}) async {
    final response = await RestClient.getDio(isUpload: true).post(
      path,
      data: data,
    );
    return _handleResponse(response);
  }

  DataResponse _handleResponse(dio.Response response) {
    var apiResponse = ApiResponse.fromJson(
      response.data,
      response.statusCode ?? 0,
    );

    switch (apiResponse.code) {
      case 200:
        return DataResponse(
          apiResponse.data,
          code: apiResponse.code,
          paginationModel: apiResponse.paginationModel,
        );
      default:
        throw ApiException(
          code: apiResponse.code,
          message: apiResponse.message,
        );
    }
  }
}
