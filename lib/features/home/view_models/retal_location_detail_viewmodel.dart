import 'package:flutter/material.dart';
import 'package:panelway_mobile/core/exceptions/api_exception.dart';
import 'package:panelway_mobile/data/models/rental_location.dart';
import 'package:panelway_mobile/data/repositories/rentalLocationImageRepository.dart';
import 'package:panelway_mobile/data/repositories/rentalLocationRepository.dart';

class RetalLocationDetailViewmodel extends ChangeNotifier {
  final RentalLocationRepository _rentalLocationRepository;
  final RentalLocationImageRepository _rentalLocationImageRepository;

  RetalLocationDetailViewmodel(
      {required RentalLocationRepository rentalLocationRepository,
      required RentalLocationImageRepository rentalLocationImageRepository})
      : _rentalLocationRepository = rentalLocationRepository,
        _rentalLocationImageRepository = rentalLocationImageRepository;

  bool _isLoading = false;
  String? _error;
  int _page = 1;
  int _size = 10;
  RentalLocation? _rentalLocation;

  bool get isLoading => _isLoading;
  String? get error => _error;
  int get page => _page;
  int get size => _size;
  RentalLocation? get rentalLocation => _rentalLocation;

  Future<RentalLocation?> getRentalLocationById(String id) async {
    if (_isLoading) return _rentalLocation;
    _isLoading = true;
    notifyListeners();
    _error = null;

    try {
      var rentalLocationIn =
          await _rentalLocationRepository.getRentalLocationById(id);
      _isLoading = false;
      notifyListeners();
      _rentalLocation = rentalLocationIn;
      debugPrint("${_rentalLocation}");
      if (_rentalLocation! != null) {
        var rentalLocationImages = await _rentalLocationImageRepository
            .getRentalLocationImagesById(id ?? "");
        _rentalLocation!.rentalLocationImages = rentalLocationImages;
      }
      return _rentalLocation;
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
}
