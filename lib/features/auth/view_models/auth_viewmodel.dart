import 'package:flutter/material.dart';
import 'package:panelway_mobile/core/exceptions/api_exception.dart';
import 'package:panelway_mobile/data/models/account.dart';
import 'package:panelway_mobile/data/payloads/requests/register_request.dart';
import 'package:panelway_mobile/data/payloads/responses/otp_response.dart';
import 'package:panelway_mobile/data/repositories/authenticationRepository.dart';
import 'package:panelway_mobile/data/services/storage_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthenticationRepository _authRepo;
  final StorageService _storageService;

  AuthViewModel({
    required AuthenticationRepository authRepository,
    required StorageService storageService,
  })  : _authRepo = authRepository,
        _storageService = storageService;

  bool _isLoading = false;
  bool _isLoggedIn = false;
  String? _error;
  Account? _account;

  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  String? get error => _error;
  Account? get account => _account;

  Future<void> checkLoginStatus() async {
    final savedAccount = await _storageService.getAccount();
    if (savedAccount != null && savedAccount.accessToken != null) {
      _isLoggedIn = true;
      _account = savedAccount;
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password, String role) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final account = await _authRepo.login(email, password, role);
      await _storageService.saveAccount(account!);
      _account = account;
      _isLoggedIn = true;
      _isLoading = false;
      notifyListeners();
      return (_error == null || _account?.accessToken != null);
    } on ApiException catch (e) {
      _error = e.message;
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _error = 'Unexpected error occurred';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<OtpResponse?> SendOTP(String phoneNumber) async {
    try{
      var response = await _authRepo.sendOTP(phoneNumber);
      return response;
    } on ApiException catch (e) {
      throw ApiException(e.message, statusCode: e.statusCode);
    } catch (e) {
      throw ApiException('Unexpected error during login');
    }
  }
  Future<bool> register(RegisterRequest request) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final account = await _authRepo.register(request);

      await _storageService.saveAccount(account!);
      _account = account;
      _isLoggedIn = true;
      _isLoading = false;
      notifyListeners();
      return (_error == null || _account?.accessToken != null);
    } on ApiException catch (e) {
      _error = e.message;
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _error = '${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _storageService.clearAccount();
    _isLoggedIn = false;
    _account = null;
    notifyListeners();
  }
}
