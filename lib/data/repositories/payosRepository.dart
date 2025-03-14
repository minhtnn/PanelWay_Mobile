import 'package:flutter/widgets.dart';
import 'package:panelway_mobile/core/constants/api_endpoints.dart';
import 'package:panelway_mobile/core/exceptions/api_exception.dart';
import 'package:panelway_mobile/data/payloads/requests/create_payos_request.dart';
import 'package:panelway_mobile/data/payloads/requests/usersubscriptionregisterRequest.dart';
import 'package:panelway_mobile/data/payloads/responses/payos_check_response.dart';
import 'package:panelway_mobile/data/payloads/responses/payos_qr_response.dart';
import 'package:panelway_mobile/data/payloads/responses/userSubscriptionRegisterResponse.dart';
import 'package:panelway_mobile/data/services/api_service.dart';

class Payosrepository {
  final ApiService _apiService;

  Payosrepository(this._apiService);

  Future<PayosQrResponse?> getPayOsPaymentQr(CreatePayOsRequest request) async {
    try {
      var response = await _apiService.post(
          ApiEndpoints.createQrApiEndpoint, request.toJson());
      if (response == null || response.data == null) {
        throw ApiException('No response from server');
      }
      // debugPrint("Check payos QR response: ${response.data.runtimeType}");

      final responseData = response.data;
      var payosQrResponse = PayosQrResponse.fromJson(responseData);

      return payosQrResponse;
    } on ApiException catch (e) {
      throw ApiException(e.message, statusCode: e.statusCode);
    } catch (e) {
      throw ApiException("${e}");
    }
  }

  Future<PayosCheckResponse?> getPayOsPaymentInformation(String orderId) async {
    try {
      var response =
          await _apiService.get("${ApiEndpoints.payOsApiEndpoint}/${orderId}");
      if (response == null || response.data == null) {
        throw ApiException('No response from server');
      }
      // debugPrint("Check payos QR response: ${response.data.runtimeType}");

      final responseData = response.data;

      var payosCheckResponse = PayosCheckResponse.fromJson(responseData);
      return payosCheckResponse;
    } on ApiException catch (e) {
      throw ApiException(e.message, statusCode: e.statusCode);
    } catch (e) {
      throw ApiException("${e}");
    }
  }

  Future<UsersubscriptionregisterResponse?> registerUserSubscription(UsersubscriptionregisterRequest request) async {
    try {
      //Tet dit roi
      var response =
          await _apiService.post("${ApiEndpoints.userSubscriptionApiEndpoint}", request.toJson());
      if (response == null || response.data == null) {
        throw ApiException('No response from server');
      }
      // debugPrint("Check payos QR response: ${response.data.runtimeType}");

      final responseData = response.data;

      var usersubscriptionregisterResponse = UsersubscriptionregisterResponse.fromJson(responseData);
      return usersubscriptionregisterResponse;
    } on ApiException catch (e) {
      throw ApiException(e.message, statusCode: e.statusCode);
    } catch (e) {
      throw ApiException("${e}");
    }
  }
}
