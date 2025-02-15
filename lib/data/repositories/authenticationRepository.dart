import 'package:panelway_mobile/core/constants/api_endpoints.dart';
import 'package:panelway_mobile/data/models/account.dart';
import 'package:panelway_mobile/data/services/api_service.dart';

class AuthenticationRepository {
  final ApiService _apiService = ApiService();

  Future<Account?> login(String email, String password, String role) async {
    var data = {"email": email, "password": password, "role": role};
    var response = await _apiService.post(ApiEndpoints.login, data);
    if (response == null || response.data == null) {
      print("Response null hoặc không hợp lệ");
      return null;
    }
    final responseData = response.data as Map<String, dynamic>;
    var account = Account.fromJson(responseData);
    return account;
  }
}
