import 'package:flutter/material.dart';
import 'package:panelway_mobile/core/constants/api_endpoints.dart';
import 'package:panelway_mobile/core/exceptions/api_exception.dart';
import 'package:panelway_mobile/data/models/account.dart';
import 'package:panelway_mobile/data/payloads/responses/accountResponse.dart';
import 'package:panelway_mobile/data/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountRepository {
  final ApiService _apiService;

  AccountRepository(this._apiService);

  Future<AccountResponse?> getAccountById(String id) async {
    try {
      var response = await _apiService.get("${ApiEndpoints.accountApiEndpoint}/${id}" );
      if (response == null || response.data == null) {
        throw ApiException('Failed to fetch account: No response from server');
      }
      final responseData = response.data as Map<String, dynamic>;
      // debugPrint("Account owner data: ${accountOwner.toJson()}");
      var account = AccountResponse.fromJson(responseData);
      return AccountResponse.fromJson(responseData);
    } on ApiException catch (e) {
      debugPrint("Error in account repo: " + e.message + e.statusCode.toString());
      throw ApiException(e.message, statusCode: e.statusCode);
    } catch (e) {
      debugPrint("Error in account repo: " + e.toString());
      throw ApiException('Unexpected error during fetching account');
    }
  }
}