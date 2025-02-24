import 'package:flutter/material.dart';
import 'package:panelway_mobile/core/exceptions/api_exception.dart';
import 'package:panelway_mobile/data/models/paginated_response.dart';
import 'package:panelway_mobile/data/models/rental_location.dart';
import 'package:panelway_mobile/data/repositories/rentalLocationRepository.dart';

class RentalLocationViewmodel extends ChangeNotifier {
  final RentalLocationRepository _rentalLocationRepository;
  RentalLocationViewmodel(
      {required RentalLocationRepository rentalLocationRepository})
      : _rentalLocationRepository = rentalLocationRepository;

  bool _isLoading = false;
  String? _error;
  int _page = 1;
  int _size = 10;
  PaginatedResponse<RentalLocation>? _rentalLocationPaging;

  bool get isLoading => _isLoading;
  String? get error => _error;
  int get page => _page;
  int get size => _size;
  PaginatedResponse<RentalLocation>? get rentalLocationPaging =>
      _rentalLocationPaging;

  Future<PaginatedResponse<RentalLocation>?> getRentalLocationPaging() async {
    _isLoading = true;
    _error = null;

    try {
          await _rentalLocationRepository.GetRentalLocationsPaging(page, size);
      _isLoading = false;
      return null;
    } on ApiException catch (e) {
      _error = e.message;
      _isLoading = false;
      notifyListeners();
      return null;
    } catch (e) {
      _error = 'Unexpected error occurred';
      _isLoading = false;
      notifyListeners();
      throw Exception("Error 2: " + e.toString());
      return null;
    }
  }
}
