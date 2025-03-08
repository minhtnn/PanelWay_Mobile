
import 'package:panelway_mobile/core/constants/api_endpoints.dart';
import 'package:panelway_mobile/data/models/rental_location_image.dart';
import 'package:panelway_mobile/data/services/api_service.dart';

class RentalLocationImageRepository {
  final ApiService _apiService;

  RentalLocationImageRepository(this._apiService);

  Future<List<RentalLocationImage>?> getRentalLocationImagesById(
      String id) async {
    try {
      var response = await _apiService.get(
          "${ApiEndpoints.findRentalLocationImagesByRentalLocationIdApiEndpoint}/${id}");
      if (response != null) {
        List<dynamic> jsonrlImage = response.data;
        List<RentalLocationImage> images = jsonrlImage
            .map((data) => RentalLocationImage.fromJson(data))
            .toList();
        return images;
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
