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
}
