import 'dart:convert';

import 'package:panelway_mobile/core/constants/api_endpoints.dart';
import 'package:panelway_mobile/data/models/paginated_response.dart';
import 'package:panelway_mobile/data/models/rental_location.dart';
import 'package:panelway_mobile/data/services/api_service.dart';

class RentalLocationRepository {
  final ApiService _apiService;

  RentalLocationRepository(this._apiService);

  Future<PaginatedResponse<RentalLocation>?> getRentalLocationsPaging(
      int page, int size) async {
    try {
      var response =
          await _apiService.get(ApiEndpoints.rentalLocationApiEndpoint);

      var rentalLocationPaging = PaginatedResponse<RentalLocation>.fromJson(
          jsonDecode(response.toString()),
          (item) => RentalLocation.fromJson(item));
      return rentalLocationPaging;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<RentalLocation>?> getRentalLocationsMapPaging(
      double minLat, double maxLat, double minLong, double maxLong) async {
    try {
      var responseList = await _apiService.get(
          "${ApiEndpoints.findRentalLocationByLadLongApiEndpoint}?minLat=${minLat}&minLng=${minLong}&maxLat=${maxLat}&maxLng=${maxLong}");

      if (responseList?.data != null && responseList!.data is List) {
        List<dynamic> responses = responseList.data;

        List<RentalLocation> subscriptionList = responses
            .map(
                (item) => RentalLocation.fromJson(item as Map<String, dynamic>))
            .toList();

        return subscriptionList;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<RentalLocation> getRentalLocationById(String id) async {
    try {
      var response = await _apiService
          .get("${ApiEndpoints.rentalLocationApiEndpoint}/${id}");
      var rentalLocation =
          RentalLocation.fromJson(jsonDecode(response.toString()));
      return rentalLocation;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
