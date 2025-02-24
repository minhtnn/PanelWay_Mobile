import 'package:panelway_mobile/core/constants/api_endpoints.dart';
import 'package:panelway_mobile/core/exceptions/api_exception.dart';
import 'package:panelway_mobile/data/models/account.dart';
import 'package:panelway_mobile/data/payloads/requests/login_request.dart';
import 'package:panelway_mobile/data/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepository {
  static const String _tokenKey = "auth_token";
  final ApiService _apiService;

  AuthenticationRepository(this._apiService);

  Future<Account?> login(String email, String password, String role) async {
    try {
      var data = LoginRequest(email: email, password: password, role: role);
      var response = await _apiService.post(ApiEndpoints.login, data.toJson());
      if (response == null || response.data == null) {
        throw ApiException('Login failed: No response from server');
      }
      final responseData = response.data as Map<String, dynamic>;
      var account = Account.fromJson(responseData);
      await saveToken(account.accessToken!); 
      return account;
    } on ApiException catch (e) {
      throw ApiException(e.message, statusCode: e.statusCode);
    } catch (e) {
      throw ApiException('Unexpected error during login');
    }
  }
  /// 🔹 Lưu token vào SharedPreferences
  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  /// 🔹 Lấy token từ SharedPreferences
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// 🔹 Xóa token khi user đăng xuất
  static Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
  
}
