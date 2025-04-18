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
  int _size = 20;
  bool _isLoadingMore = false;
  PaginatedResponse<RentalLocation>? _rentalLocationPaging;
  List<RentalLocation>? _rentalLocationMapPaging;
  bool _hasMorePages = true;

  bool get isLoading => _isLoading;
  String? get error => _error;
  int get page => _page;
  int get size => _size;
  bool get isLoadingMore => _isLoadingMore;
  PaginatedResponse<RentalLocation>? get rentalLocationPaging =>
      _rentalLocationPaging;
  List<RentalLocation>? get rentalLocationMapPaging => _rentalLocationMapPaging;
  bool get hasMorePages => _hasMorePages;

  // Key fix: Cache the loaded images to prevent them from being lost
  final Map<String, List<RentalLocationImage>> _imageCache = {};

  Future<void> _loadImagesForSpecificLocations(
      List<RentalLocation> locations) async {
    for (var location in locations) {
      if (location.id == null) continue;
      if (_imageCache.containsKey(location.id!)) {
        location.rentalLocationImages = _imageCache[location.id!];
      } else {
        try {
          var images = await _rentalLocationImageRepository
              .getRentalLocationImagesById(location.id!);
          if (images != null && images.isNotEmpty) {
            location.rentalLocationImages = images;
            _imageCache[location.id!] = images;
          } else {
            location.rentalLocationImages = [];
            _imageCache[location.id!] = [];
          }
        } catch (e) {
          debugPrint(
              "Error loading images for location ${location.id}: ${e.toString()}");
          location.rentalLocationImages = [];
          _imageCache[location.id!] = [];
        }
      }
    }
  }

  Future<PaginatedResponse<RentalLocation>?> getRentalLocationPaging(
      {bool forceRefresh = false}) async {
    if (_isLoading || (_rentalLocationPaging != null && !forceRefresh)) {
      if (_rentalLocationPaging != null && !_hasAllImagesLoaded()) {
        // Keep image check
        _isLoading = true;
        notifyListeners();
        await _loadImagesForSpecificLocations(_rentalLocationPaging!.items);
        _isLoading = false;
        notifyListeners();
      }
      return _rentalLocationPaging;
    }

    _isLoading = true;
    _page = 1; // Reset to first page
    _hasMorePages = true; // Assume more pages on initial/refresh
    _error = null;
    // Optionally clear data immediately on refresh:
    if (forceRefresh) {
      _rentalLocationPaging = null; // Clear existing data for refresh
      _imageCache.clear(); // Clear image cache on full refresh might be desired
    }
    notifyListeners(); // Show loading indicator

    try {
      // Fetch the FIRST page using the defined page size
      debugPrint("[ViewModel Init Load] Requesting Page: $_page, Size: $_size");
      var rentalLocationPagingIn = await _rentalLocationRepository
          .getRentalLocationsPaging(_page, _size); // Use _page and _pageSize

      if (rentalLocationPagingIn != null) {
        await _loadImagesForSpecificLocations(rentalLocationPagingIn.items);
        _rentalLocationPaging = rentalLocationPagingIn;
        _updateHasMorePages(); // Check if more pages exist
      } else {
        _rentalLocationPaging = PaginatedResponse(
            items: [],
            totalCount: 0,
            pageIndex: 0,
            pageSize: 0,
            totalPages: 0); // Init empty
        _hasMorePages = false;
      }

      _isLoading = false;
      notifyListeners();
      return _rentalLocationPaging;
    } on ApiException catch (e) {
      _error = e.message;
      _isLoading = false;
      _hasMorePages = false;
      _rentalLocationPaging = null;
      notifyListeners();
      return null;
    } catch (e) {
      _error = 'Unexpected error occurred: ${e.toString()}';
      _isLoading = false;
      _hasMorePages = false;
      _rentalLocationPaging = null;
      notifyListeners();
      return null;
    }
  }

  Future<void> loadMoreRentalLocations() async {
    if (_isLoadingMore || !_hasMorePages || _isLoading) {
      debugPrint(
          "Skipping loadMore: isLoadingMore=$_isLoadingMore, hasMorePages=$_hasMorePages, isLoading=$_isLoading");
      return;
    }

    _isLoadingMore = true;
    _error = null;
    notifyListeners(); // Show loading more indicator at the bottom

    // Increment page number for the *next* page
    final nextSize = _size + 10; // Calculate next page

    debugPrint(
        "Loading more rental locations - Requesting page: $_page, Page size: $nextSize");

    try {
      // Fetch the NEXT page using the incremented page number and the SAME page size
      debugPrint("[ViewModel Load More] Requesting Page: $_page, Size: $nextSize");
      var nextPageData =
          await _rentalLocationRepository.getRentalLocationsPaging(
              _page, nextSize); // Use nextPage, _pageSize

      if (nextPageData != null && nextPageData.items.isNotEmpty) {
        debugPrint(
            "Loaded ${nextPageData.items.length} more items for page $nextSize");

        await _loadImagesForSpecificLocations(nextPageData.items);

        // Append new items ONLY
        if (_rentalLocationPaging != null) {
          _rentalLocationPaging!.items.addAll(nextPageData.items);

          // IMPORTANT: Update totalCount from the latest response if it can change
          _rentalLocationPaging!.totalCount = nextPageData.totalCount;

          // Update current page number *after* successful load
          _size = nextSize;

          // Check if more pages exist based on the *new* total count and items length
          _updateHasMorePages();
        } else {
          // Should not happen if initial load was successful, but handle defensively
          _rentalLocationPaging = nextPageData;
          _size = nextSize;
          _updateHasMorePages();
        }
      } else {
        // The API returned no items for the requested page, so no more pages exist
        debugPrint("No more items to load after page $_page");
        _hasMorePages = false;
      }

      _isLoadingMore = false;
      notifyListeners(); // Update UI with new items and remove loading indicator
    } on ApiException catch (e) {
      debugPrint("API Error loading more: ${e.message}");
      _error =
          "Failed to load more: ${e.message}"; // You might want to display this
      _isLoadingMore = false;
      _hasMorePages = false; // Stop trying if an error occurs during load more
      notifyListeners();
    } catch (e) {
      debugPrint("Unexpected error loading more: ${e.toString()}");
      _error = 'Unexpected error loading more: ${e.toString()}';
      _isLoadingMore = false;
      _hasMorePages = false; // Stop trying on unexpected error
      notifyListeners();
    }
  }

  // Helper to update _hasMorePages based on current data
  void _updateHasMorePages() {
    if (_rentalLocationPaging == null) {
      _hasMorePages = false;
      debugPrint("Updated hasMorePages: false (no data)");
      return;
    }

    // *** CRUCIAL: Make sure your PaginatedResponse class has 'totalCount' ***
    final totalItems = _rentalLocationPaging!.totalCount;
    final currentItemCount = _rentalLocationPaging!.items.length;

    // We have more pages if the number of items currently loaded is less than the total count reported by the API
    _hasMorePages = currentItemCount < totalItems;

    debugPrint(
        "Updated hasMorePages: $_hasMorePages (currentItems: $currentItemCount, totalItems: $totalItems, currentPage: $_page)");
  }

  Future<List<RentalLocation>?> getRentalLocationMapPaging([
    double? minLat,
    double? maxLat,
    double? minLong,
    double? maxLong,
  ]) async {
    // Use default values if parameters are not provided (for backward compatibility)
    minLat ??= 10.755125758798037;
    maxLat ??= 10.883146727118318;
    minLong ??= 106.61538557572803;
    maxLong ??= 106.68280168013138;

    if (_isLoading) return _rentalLocationMapPaging;

    _isLoading = true;
    notifyListeners();
    _error = null;

    try {
      var rentalLocationPagingMapIn = await _rentalLocationRepository
          .getRentalLocationsMapPaging(minLat, maxLat, minLong, maxLong);
      _rentalLocationMapPaging = rentalLocationPagingMapIn;

      if (_rentalLocationMapPaging != null &&
          _rentalLocationMapPaging!.isNotEmpty) {
        // Load images for each rental location
        await _loadImagesForLocationsInMap();
      }

      _isLoading = false;
      notifyListeners();
      return _rentalLocationMapPaging;
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
      return true; // Or false depending on desired behavior for empty list
    }
    for (var location in _rentalLocationPaging!.items) {
      if (location.id != null && !_imageCache.containsKey(location.id!)) {
        // Simplified: Assumes if not in cache, it's not loaded.
        // The check inside _loadImagesForSpecificLocations is more robust.
        return false;
      }
      // You could also check location.rentalLocationImages != null here if preferred
    }
    return true;
  }

  bool _hasAllImagesMapLoaded() {
    if (_rentalLocationMapPaging == null || _rentalLocationMapPaging!.isEmpty) {
      return false;
    }

    for (var location in _rentalLocationMapPaging!) {
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
          debugPrint(
              "Error loading images for location ${location.id}: ${e.toString()}");
        }
      }
    }
  }

  // Load images for all locations in mao
  Future<void> _loadImagesForLocationsInMap() async {
    for (var location in _rentalLocationMapPaging!) {
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
          debugPrint(
              "Error loading images for location ${location.id}: ${e.toString()}");
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
          var images = await _rentalLocationImageRepository
              .getRentalLocationImagesById(id);
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
    _imageCache.clear(); // Clear cache on refresh
    // getRentalLocationPaging with forceRefresh will reset page and clear data
    await getRentalLocationPaging(forceRefresh: true);
  }
}
