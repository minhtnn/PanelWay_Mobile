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
        List<dynamic> responseList = response!.data; // Ép kiểu về List<dynamic>

        List<Subscription> subscriptionList = responseList
            .map((item) => Subscription.fromJson(item as Map<String, dynamic>))
            .toList();

        return subscriptionList; // Trả về danh sách Subscription thay vì null
      } else {
        return []; // Trả về danh sách rỗng nếu không có dữ liệu
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
        debugPrint("API Response is completely null");
        return null;
      }

      // Log response status code if available
      debugPrint("API Response status: ${response.statusCode}");

      // Check response data
      if (response.data == null) {
        debugPrint("API Response data is null");
        return null;
      }

      // Log the data type and content
      debugPrint("Response data type: ${response.data.runtimeType}");
      debugPrint("Response data content: ${response.data}");

      // Try to parse based on the format
      if (response.data is Map<String, dynamic>) {
        debugPrint("Attempting to parse Map response");
        try {
          var userSubscription = UserSubscription.fromJson(response.data);
          debugPrint(
              "Successfully parsed user subscription: ${userSubscription.toString()}");
          return userSubscription;
        } catch (e) {
          debugPrint("Error parsing subscription from Map: $e");
        }
      } else if (response.data is List) {
        debugPrint(
            "Response is a List with ${(response.data as List).length} items");
        if ((response.data as List).isNotEmpty) {
          var firstItem = (response.data as List).first;
          debugPrint("First item type: ${firstItem.runtimeType}");
          try {
            if (firstItem is Map<String, dynamic>) {
              var userSubscription = UserSubscription.fromJson(firstItem);
              debugPrint(
                  "Successfully parsed user subscription from list item");
              return userSubscription;
            }
          } catch (e) {
            debugPrint("Error parsing subscription from List item: $e");
          }
        }
      } else {
        debugPrint(
            "Unexpected response data type: ${response.data.runtimeType}");
      }

      return null;
    } catch (e) {
      debugPrint("Exception in getUserSubcriptions: $e");
      return null;
    }
  }
}
