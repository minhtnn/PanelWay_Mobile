import 'package:flutter/material.dart';
import 'package:panelway_mobile/core/exceptions/api_exception.dart';
import 'package:panelway_mobile/data/models/account.dart';
import 'package:panelway_mobile/data/repositories/authenticationRepository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthenticationRepository _authRepo = AuthenticationRepository();

  bool isLoading = false;
  Account? account;
  String? errorMessage;

  Future<void> login(String email, String password, String role) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      account = await _authRepo.login(email, password, role);
    } on ApiException catch (e) {
      errorMessage = e.message;
    } catch (e) {
      errorMessage = 'An unexpected error occurred.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
