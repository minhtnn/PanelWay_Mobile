
import 'package:panelway_mobile/core/constants/api_endpoints.dart';
import 'package:panelway_mobile/data/models/paginated_response.dart';
import 'package:panelway_mobile/data/models/rental_location.dart';
import 'package:panelway_mobile/data/services/api_service.dart';

class RentalLocationRepository {
  final ApiService _apiService;

  RentalLocationRepository(this._apiService);

  Future<PaginatedResponse<RentalLocation>?> GetRentalLocationsPaging(
      int page, int size) async {
        var response = _apiService.get(ApiEndpoints.rentalLocationApiEndpoint);
        print("Check: " + response.toString());
        return null;
  }
}
