import "package:panelway_mobile/core/constants/api_endpoints.dart";
import "package:panelway_mobile/core/exceptions/api_exception.dart";
import "package:dio/dio.dart";

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiEndpoints.baseUrl,
    // connectTimeout: 5000,
    // receiveTimeout: 3000,
  ));

  Future<Response?> get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      return await _dio.get(endpoint, queryParameters: params);
    } on DioError catch (e) {
      _handleError(e);
    }
    return null;
  }

  Future<Response?> post(String endpoint, Map<String, dynamic> data) async {
    try {
      return await _dio.post(endpoint, data: data);
    } on DioError catch (e) {
      _handleError(e);
    }
    return null;
  }
  Future<Response?> patch(String endpoint, Map<String, dynamic> data) async {
    try {
      return await _dio.patch(endpoint, data: data);
    } on DioError catch (e) {
      _handleError(e);
    }
    return null;
  }

  Future<Response?> delete(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      return await _dio.delete(endpoint, queryParameters: params);
    } on DioError catch (e) {
      _handleError(e);
    }
    return null;
  }
  void _handleError(DioException error) {
    if (error.response != null) {
      throw ApiException(
        error.response?.data['message'] ?? 'Unknown error occurred',
        statusCode: error.response?.statusCode,
      );
    } else if (error.type == DioException.connectionTimeout) {
      throw ApiException('Connection timeout.');
    } else if (error.type == DioException.receiveTimeout) {
      throw ApiException('Response timeout.');
    } else {
      throw ApiException('Unexpected error occurred.');
    }
  }
}
