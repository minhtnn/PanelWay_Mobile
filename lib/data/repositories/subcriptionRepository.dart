import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:panelway_mobile/core/constants/api_endpoints.dart';
import 'package:panelway_mobile/data/models/subscription.dart';
import 'package:panelway_mobile/data/models/user_subscription.dart';
import 'package:panelway_mobile/data/services/api_service.dart';

class Subcriptionrepository {
  final ApiService _apiService;

  Subcriptionrepository(this._apiService);

  Future<List<Subscription>?> getSubcriptions() async {
    try {
      var response =
          await _apiService.get(ApiEndpoints.subscriptionApiEndpoint);
      if (response?.data != null && response!.data is List) {
        List<dynamic> responseList = response.data;

        List<Subscription> subscriptionList = responseList
            .map((item) => Subscription.fromJson(item as Map<String, dynamic>))
            .toList();

        return subscriptionList;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Error in getSubcriptions: ${e.toString()}");
    }
  }

  Future<UserSubscription?> getUserSubcriptions(
      String id, String status) async {
    try {
      String endpoint =
          "${ApiEndpoints.findUserSubscriptionByAccountIdApiEndpoint}/${id}?status=${status}";
      debugPrint("API Call: GET $endpoint");

      var response = await _apiService.get(endpoint);

      // Check if we got any response at all
      if (response == null) {
        return null;
      }
      if (response.data is List<dynamic>) {
        var userSubscriptionList = response.data as List<dynamic>;
        // debugPrint(
        //     "Check userSubscription: ${UserSubscription.fromJson(userSubscriptionList[0])}");
        if (userSubscriptionList[0] != null) {
          return UserSubscription.fromJson(userSubscriptionList[0]);
        }
      }
      return null;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Subscription?> getSubcriptionById(
      String id) async {
    try {
      String endpoint =
          "${ApiEndpoints.subscriptionApiEndpoint}/${id}";
      debugPrint("API Call: GET $endpoint");

      var response = await _apiService.get(endpoint);

      // Check if we got any response at all
      if (response == null) {
        return null;
      }

      if (response.data is Map<String, dynamic>) {
        var userSubscriptionList = response.data;
        return Subscription.fromJson(userSubscriptionList);
      }
      return null;
    } catch (e) {
      throw Exception(e);
    }
  }
}
