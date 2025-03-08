import 'package:flutter/material.dart';
import 'package:panelway_mobile/core/constants/api_endpoints.dart';
import 'package:panelway_mobile/data/models/user_subscription.dart';
import 'package:panelway_mobile/data/services/api_service.dart';

class Usersubscriptionrepository {
  final ApiService _apiService;

  Usersubscriptionrepository({required ApiService apiService})
      : _apiService = apiService;

  Future<List<UserSubscription>?> getUserSubscriptionByUserid(
      String id, String status) async {
    try {
      var response = await _apiService.get(
          "${ApiEndpoints.findUserSubscriptionByAccountIdApiEndpoint}/${id}?status=${status}");
      debugPrint("${response}");
      // if (response?.data != null && response!.data is List) {
      //   List<dynamic> responseList = response!.data; // Ép kiểu về List<dynamic>

      //   List<UserSubscription> subscriptionList = responseList
      //       .map((item) => Subscription.fromJson(item as Map<String, dynamic>))
      //       .toList();

      //   return subscriptionList; // Trả về danh sách Subscription thay vì null
      // } else {
      return []; // Trả về danh sách rỗng nếu không có dữ liệu
      // }
    } catch (e) {
      throw Exception("Error in getSubcriptions: ${e.toString()}");
    }
  }
}
