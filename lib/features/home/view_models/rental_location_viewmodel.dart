import 'package:flutter/material.dart';
import 'package:panelway_mobile/core/exceptions/api_exception.dart';
import 'package:panelway_mobile/data/models/paginated_response.dart';
import 'package:panelway_mobile/data/models/rental_location.dart';
import 'package:panelway_mobile/data/repositories/rentalLocationImageRepository.dart';
import 'package:panelway_mobile/data/repositories/rentalLocationRepository.dart';

class RentalLocationViewmodel extends ChangeNotifier {
  final RentalLocationRepository _rentalLocationRepository;
  final RentalLocationImageRepository _rentalLocationImageRepository;
  RentalLocationViewmodel(
      {required RentalLocationRepository rentalLocationRepository,
      required RentalLocationImageRepository rentalLocationImageRepository})
      : _rentalLocationRepository = rentalLocationRepository,
        _rentalLocationImageRepository = rentalLocationImageRepository;

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
    if (_isLoading) return _rentalLocationPaging;
    _isLoading = true;
    notifyListeners();
    _error = null;

    try {
      var rentalLocationPagingIn =
          await _rentalLocationRepository.getRentalLocationsPaging(page, size);
      _isLoading = false;
      notifyListeners();
      _rentalLocationPaging = rentalLocationPagingIn;
      if (_rentalLocationPaging!.items != null) {
        for (var rentalLocation in _rentalLocationPaging!.items) {
          var rentalLocationImages = await _rentalLocationImageRepository.getRentalLocationImagesById(rentalLocation.id??"");
          rentalLocation.rentalLocationImages = rentalLocationImages;
        }
      }
      return _rentalLocationPaging;
    } on ApiException catch (e) {
      _error = e.message;
      _isLoading = false;
      notifyListeners();
      return null;
    } catch (e) {
      _error = 'Unexpected error occurred: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      throw Exception(e.toString());
    }
  }

  Future<bool> getRentalLocationImageByRentalLocationId(String id) async {
    try {
      await _rentalLocationImageRepository.getRentalLocationImagesById(id);
      return false;
    } catch (e) {
      debugPrint("Error getting images: ${e.toString()}");
      return false;
    }
  }
}
