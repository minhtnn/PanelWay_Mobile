import 'package:flutter/material.dart';
import 'package:panelway_mobile/core/exceptions/api_exception.dart';
import 'package:panelway_mobile/data/models/subscription.dart';
import 'package:panelway_mobile/data/models/user_subscription.dart';
import 'package:panelway_mobile/data/payloads/requests/create_payos_request.dart';
import 'package:panelway_mobile/data/payloads/responses/payos_check_response.dart';
import 'package:panelway_mobile/data/payloads/responses/payos_qr_response.dart';
import 'package:panelway_mobile/data/repositories/payosRepository.dart';
import 'package:panelway_mobile/data/repositories/subcriptionRepository.dart';

class SubcriptionViewModel extends ChangeNotifier {
  final Subcriptionrepository _subcriptionrepository;
  final Payosrepository _payosrepository;

  SubcriptionViewModel(
      {required Subcriptionrepository subcriptionrepository,
      required Payosrepository payosRepository})
      : _subcriptionrepository = subcriptionrepository,
        _payosrepository = payosRepository;

  bool _isLoading = false;
  String? _error;
  List<Subscription>? _subcriptions;
  UserSubscription? _userSubscription;
  PayosQrResponse? _payosQrResponse;

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Subscription>? get subcriptions => _subcriptions;
  UserSubscription? get userSubscription => _userSubscription;
  PayosQrResponse? get payosQrResponse => _payosQrResponse;

  Future getSubcriptions() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();
    _error = null;
    try {
      var subcriptionList = await _subcriptionrepository.getSubcriptions();
      _subcriptions = subcriptionList;
      _isLoading = false;
      notifyListeners();
    } on ApiException catch (e) {
      _error = e.message;
      _isLoading = false;
      notifyListeners();
      return null;
    } catch (e) {
      _error = 'Unexpected error occurred: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      throw Exception(e.toString());
    } finally {
      _isLoading = false;
    }
  }

  Future<UserSubscription?> getCurrentSubcription(
      String id, String status) async {
    // if (_isLoading) return null;
    _isLoading = true;
    notifyListeners();
    _error = null;
    try {
      var userSubscriptionIn =
          await _subcriptionrepository.getUserSubcriptions(id, status);

      _isLoading = false;
      if (userSubscriptionIn != null) {
        var subscription = await _subcriptionrepository
            .getSubcriptionById(userSubscriptionIn.subscriptionId ?? "");
        userSubscriptionIn.subscription = subscription;
        _userSubscription = userSubscriptionIn;
      }
      notifyListeners();
      return _userSubscription;
    } on ApiException catch (e) {
      _error = e.message;
      _isLoading = false;
      notifyListeners();
      return null;
    } catch (e) {
      _error = 'Unexpected error occurred: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      throw Exception(e.toString());
    } finally {
      _isLoading = false;
    }
  }

  Future<PayosQrResponse?> getPayOsQr(CreatePayOsRequest request) async {
    _isLoading = true;
    notifyListeners();
    _error = null;
    try {
      var response = await _payosrepository.getPayOsPaymentQr(request);
      if (response != null) {
        _payosQrResponse = response;
        _isLoading = false;
        notifyListeners();
        return response;
      }
      _isLoading = false;
      notifyListeners();
      return null;
    } on ApiException catch (e) {
      _error = e.message;
      _isLoading = false;
      notifyListeners();
      return null;
    } catch (e) {
      _error = 'Unexpected error occurred: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      throw Exception(e.toString());
    } finally {
      _isLoading = false;
    }
  }

  Future<PayosCheckResponse?> getPayOsCheck(String orderId) async {
    _isLoading = true;
    notifyListeners();
    _error = null;
    try {
      var response = await _payosrepository.getPayOsPaymentInformation(orderId);

      if (response != null) {
        _isLoading = false;

        notifyListeners();
        return response;
      }
      _isLoading = false;
      notifyListeners();
      return null;
    } on ApiException catch (e) {
      _error = e.message;
      _isLoading = false;
      notifyListeners();
      return null;
    } catch (e) {
      _error = 'Unexpected error occurred: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      throw Exception(e.toString());
    } finally {
      _isLoading = false;
    }
  }
}
