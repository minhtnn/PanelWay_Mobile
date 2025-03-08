import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:panelway_mobile/core/constants/api_endpoints.dart';
import 'package:panelway_mobile/data/models/subscription.dart';
import 'package:panelway_mobile/data/services/api_service.dart';

class Subcriptionrepository {
  final ApiService _apiService;

  Subcriptionrepository(this._apiService);

  Future<List<Subscription>?> getSubcriptions() async {
  try {
    var response = await _apiService.get(ApiEndpoints.subscriptionApiEndpoint);
    
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
}
