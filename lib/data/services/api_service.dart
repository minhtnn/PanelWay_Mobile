import "package:flutter/material.dart";
import "package:dio/dio.dart";
import "package:shared_preferences/shared_preferences.dart"; // Store token
import "package:panelway_mobile/app/app_routes.dart";
import "package:panelway_mobile/core/constants/api_endpoints.dart";
import "package:panelway_mobile/core/exceptions/api_exception.dart";

class ApiService {
  final GlobalKey<NavigatorState> _navigatorKey;
  Dio _dio = Dio(BaseOptions(
    baseUrl: ApiEndpoints.baseUrl,
  ));

  ApiService(this._navigatorKey) {
    _initializeInterceptors(); // Add token interceptor
  }

  void _initializeInterceptors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("auth_token");
    print("Token: " + token!);
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
      return await _dio.get(endpoint, queryParameters: params);
    } on DioException catch (e) {
      _handleError(e);
    }
    return null;
  }

  Future<Response?> post(String endpoint, Map<String, dynamic> data) async {
    try {
      return await _dio.post(endpoint, data: data);
    } on DioException catch (e) {
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


// import "package:flutter/material.dart";
// import "package:panelway_mobile/app/app_routes.dart";
// import "package:panelway_mobile/core/constants/api_endpoints.dart";
// import "package:panelway_mobile/core/exceptions/api_exception.dart";
// import "package:dio/dio.dart";

// class ApiService {
//   final GlobalKey<NavigatorState> _navigatorKey;
//   ApiService(this._navigatorKey);
//   final Dio _dio = Dio(BaseOptions(
//     baseUrl: ApiEndpoints.baseUrl,
//     // connectTimeout: 5000,
//     // receiveTimeout: 3000,
//   ));

//   Future<Response?> get(String endpoint, {Map<String, dynamic>? params}) async {
//     try {
//       return await _dio.get(endpoint, queryParameters: params);
//     } on DioError catch (e) {
//       _handleError(e);
//     }
//     return null;
//   }

//   Future<Response?> post(String endpoint, Map<String, dynamic> data) async {
//     try {
//       return await _dio.post(endpoint, data: data);
//     } on DioError catch (e) {
//       _handleError(e);
//     }
//     return null;
//   }

//   Future<Response?> patch(String endpoint, Map<String, dynamic> data) async {
//     try {
//       return await _dio.patch(endpoint, data: data);
//     } on DioError catch (e) {
//       _handleError(e);
//     }
//     return null;
//   }

//   Future<Response?> delete(String endpoint,
//       {Map<String, dynamic>? params}) async {
//     try {
//       return await _dio.delete(endpoint, queryParameters: params);
//     } on DioError catch (e) {
//       _handleError(e);
//     }
//     return null;
//   }

//   void _handleError(DioException error) {
//     if (error.response != null) {
//       throw ApiException(
//         error.response?.data['message'] ?? 'Unknown error occurred',
//         statusCode: error.response?.statusCode,
//       );
//     } else if (error.response?.statusCode == 401) {
//       // Now you can use the navigatorKey safely
//       _navigatorKey.currentState?.pushNamedAndRemoveUntil(
//         AppRoutes.login,
//         (route) => false,
//       );
//     } else if (error.type == DioException.connectionTimeout) {
//       throw ApiException('Connection timeout.');
//     } else if (error.type == DioException.receiveTimeout) {
//       throw ApiException('Response timeout.');
//     } else {
//       throw ApiException('Unexpected error occurred.');
//     }
//   }
  
// }
