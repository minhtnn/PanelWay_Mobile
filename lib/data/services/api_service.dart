import "package:flutter/material.dart";
import "package:dio/dio.dart";
import "package:shared_preferences/shared_preferences.dart"; // Store token
import "package:panelway_mobile/app/app_routes.dart";
import "package:panelway_mobile/core/constants/api_endpoints.dart";
import "package:panelway_mobile/core/exceptions/api_exception.dart";

class ApiService {
  final GlobalKey<NavigatorState> _navigatorKey;
  late Dio _dio;

  ApiService(this._navigatorKey) {
    _dio = Dio(BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
    ));

    // Initialize immediately to avoid timing issues
    _initializeInterceptors();
  }

  Future<void> _initializeInterceptors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("auth_token");

    _dio.interceptors
        .clear(); // Clear existing interceptors to avoid duplicates
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
      ),
    );
  }

  Future<Response?> get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      // print("🔵 Requesting: $endpoint with params: $params");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("auth_token");
      var response = await _dio.get(
        endpoint,
        queryParameters: params,
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      // print("✅ Response received: ${response.data}");
      return response;
    } on DioException catch (e) {
      print("❌ DioException: ${e.message}");
      print("📌 Response Data: ${e.response?.data}");
      print("📌 Response Status: ${e.response?.statusCode}");
      print("📌 Headers: ${e.response?.headers}");
    } catch (e) {
      print("❌ Other Exception: $e");
    }
    return null;
  }

  Future<Response?> post(String endpoint, Map<String, dynamic> data) async {
    try {
      // print("🔵 Requesting: $endpoint with params: $data");
      var response = await _dio.post(
        endpoint,
        data: data,
        options: Options(headers: {
          "Content-Type": "application/json"
        }), // Explicit JSON format
      );
      // print("✅ Response received: ${response.data}");
      return response;
    } on DioException catch (e) {
      debugPrint("Dio error: ${e.message}");
      debugPrint("Response data: ${e.response?.data}");
      debugPrint("Status code: ${e.response?.statusCode}");
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
    } else if (error.response?.statusCode == 401) {
      _navigatorKey.currentState?.pushNamedAndRemoveUntil(
        AppRoutes.login,
        (route) => false,
      );
    } else {
      throw ApiException('Unexpected error occurred.');
    }
  }
}
