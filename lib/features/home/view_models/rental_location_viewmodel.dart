import 'package:flutter/material.dart';
import 'package:panelway_mobile/core/exceptions/api_exception.dart';
import 'package:panelway_mobile/data/models/paginated_response.dart';
import 'package:panelway_mobile/data/models/rental_location.dart';
import 'package:panelway_mobile/data/models/rental_location_image.dart';
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

  // Key fix: Cache the loaded images to prevent them from being lost
  final Map<String, List<RentalLocationImage>> _imageCache = {};

  Future<PaginatedResponse<RentalLocation>?> getRentalLocationPaging() async {
    if (_isLoading) return _rentalLocationPaging;
    
    // If we already have data loaded with images, just return it
    if (_rentalLocationPaging != null && 
        _rentalLocationPaging!.items.isNotEmpty && 
        _hasAllImagesLoaded()) {
      return _rentalLocationPaging;
    }
    
    _isLoading = true;
    notifyListeners();
    _error = null;

    try {
      var rentalLocationPagingIn =
          await _rentalLocationRepository.getRentalLocationsPaging(page, size);
      _rentalLocationPaging = rentalLocationPagingIn;
      
      if (_rentalLocationPaging != null && _rentalLocationPaging!.items.isNotEmpty) {
        // Load images for each rental location
        await _loadImagesForLocations();
      }
      
      _isLoading = false;
      notifyListeners();
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
  
  // Check if all locations have their images loaded
  bool _hasAllImagesLoaded() {
    if (_rentalLocationPaging == null || _rentalLocationPaging!.items.isEmpty) {
      return false;
    }
    
    for (var location in _rentalLocationPaging!.items) {
      if (location.id == null) continue;
      
      if (location.rentalLocationImages == null || 
          location.rentalLocationImages!.isEmpty) {
        // Check if we have the images in cache
        if (!_imageCache.containsKey(location.id!) || 
            _imageCache[location.id]!.isEmpty) {
          return false;
        }
      }
    }
    
    return true;
  }
  
  // Load images for all locations
  Future<void> _loadImagesForLocations() async {
    for (var location in _rentalLocationPaging!.items) {
      if (location.id == null) continue;
      
      // Check if we have images in cache first
      if (_imageCache.containsKey(location.id!)) {
        location.rentalLocationImages = _imageCache[location.id!];
      } else {
        // Load images from repository
        try {
          var images = await _rentalLocationImageRepository
              .getRentalLocationImagesById(location.id!);
          
          if (images != null && images.isNotEmpty) {
            location.rentalLocationImages = images;
            // Cache the images for future use
            _imageCache[location.id!] = images;
          }
        } catch (e) {
          debugPrint("Error loading images for location ${location.id}: ${e.toString()}");
        }
      }
    }
  }

  Future<RentalLocation?> getRentalLocationById(String id) async {
    _isLoading = true;
    notifyListeners();
    _error = null;

    try {
      var rentalLocationIn =
          await _rentalLocationRepository.getRentalLocationById(id);
      
      if (rentalLocationIn != null) {
        // Check if we have images in cache first
        if (_imageCache.containsKey(id)) {
          rentalLocationIn.rentalLocationImages = _imageCache[id];
        } else {
          // Get the images for this specific rental location
          var images = await _rentalLocationImageRepository.getRentalLocationImagesById(id);
          if (images != null && images.isNotEmpty) {
            rentalLocationIn.rentalLocationImages = images;
            // Cache the images
            _imageCache[id] = images;
          }
        }
      }
      
      _isLoading = false;
      notifyListeners();
      return rentalLocationIn;
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

  // This method provides a way to force a refresh when needed
  Future<void> refreshData() async {
    _imageCache.clear();
    await getRentalLocationPaging();
  }
}