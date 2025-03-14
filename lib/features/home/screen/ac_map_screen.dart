import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/app/app_routes.dart';
import 'package:panelway_mobile/core/enum/bottom_bar_page.dart';
import 'package:panelway_mobile/core/widgets/flutter_map/custom_marker.dart';
import 'package:panelway_mobile/core/widgets/flutter_map/location_info.dart';
import 'package:panelway_mobile/core/widgets/flutter_map/map_style.dart';
import 'package:geolocator/geolocator.dart';
import 'package:panelway_mobile/core/widgets/non_rotating_marker.dart';
import 'package:panelway_mobile/features/auth/view_models/auth_viewmodel.dart';
import 'package:panelway_mobile/features/home/view_models/rental_location_viewmodel.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  LocationInfo? selectedLocation;
  MapStyle currentMapStyle = MapStyle.standard;
  bool isStyleMenuOpen = false;
  bool _isLoadingLocation = false;
  LatLng? _currentUserLocation;
  final MapController _mapController = MapController();
  bool _initialLoadDone = false;
  double? _prevMinLat;
  double? _prevMaxLat;
  double? _prevMinLong;
  double? _prevMaxLong;
  Timer? _debounceTimer;
  late AnimationController _markersAnimationController;
  late Animation<double> _markersOpacity;
  bool _locationsLoaded = false;
  // Map style definitions

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoadingLocation = true;
    });

    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Location services are disabled. Please enable them.'),
            backgroundColor: Palette.red,
          ),
        );
        return;
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Location permissions are denied'),
              backgroundColor: Palette.red,
            ),
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
                'Location permissions are permanently denied. Please enable them in settings.'),
            backgroundColor: Palette.red,
            action: SnackBarAction(
              label: 'Settings',
              onPressed: () => Geolocator.openAppSettings(),
              textColor: Palette.white,
            ),
          ),
        );
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        _currentUserLocation = LatLng(position.latitude, position.longitude);
      });

      // Animate map to user location
      _mapController.move(
        _currentUserLocation!,
        15.0, // zoom level
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error getting location: $e'),
          backgroundColor: Palette.red,
        ),
      );
    } finally {
      setState(() {
        _isLoadingLocation = false;
      });
    }
  }

  List<Marker> markers(List<LocationInfo> locations) {
    List<Marker> allMarkers = locations
        .map(
          (loc) => NonRotatingMarker(
            point: loc.location,
            width: 120,
            height: 80,
            child: CustomMarkerWidget(
              label: loc.price,
              color: loc.markerColor,
              isSelected: selectedLocation == loc,
              onTap: () {
                setState(() {
                  selectedLocation = loc;
                });
              },
            ),
          ),
        )
        .toList();

    // Add user location marker if available
    if (_currentUserLocation != null) {
      allMarkers.add(
        NonRotatingMarker(
          point: _currentUserLocation!,
          width: 60,
          height: 60,
          child: Container(
            decoration: BoxDecoration(
              color: Palette.blueButton.withOpacity(0.3),
              shape: BoxShape.circle,
              border: Border.all(
                color: Palette.blueButton,
                width: 2,
              ),
            ),
            child: const Center(
              child: Icon(
                Symbols.my_location,
                color: Palette.blueButton,
                size: 30,
              ),
            ),
          ),
        ),
      );
    }

    return allMarkers;
  }

  @override
  void initState() {
    super.initState();
    // Initialize animation controller
    _markersAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _markersOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _markersAnimationController,
        curve: Curves.easeIn,
      ),
    );
    // Only load data once when widget is created
    _loadDataOnce();
  }

  void _loadDataOnce() {
    if (!_initialLoadDone) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Get the initial bounds from the map controller
        double minLat = 10.755125758798037;
        double maxLat = 10.883146727118318;
        double minLong = 106.61538557572803;
        double maxLong = 106.68280168013138;

        final rentalLocVM =
            Provider.of<RentalLocationViewmodel>(context, listen: false);
        rentalLocVM
            .getRentalLocationMapPaging(minLat, maxLat, minLong, maxLong)
            .then((_) {
          // Start animation when locations are loaded
          if (rentalLocVM.rentalLocationMapPaging != null &&
              rentalLocVM.rentalLocationMapPaging!.isNotEmpty) {
            setState(() {
              _locationsLoaded = true;
            });
            _markersAnimationController.forward();
          }
        });

        // Call with the correct parameters from the bounds
        Provider.of<RentalLocationViewmodel>(context, listen: false)
            .getRentalLocationMapPaging(minLat, maxLat, minLong, maxLong);

        Provider.of<AuthViewModel>(context, listen: false).getAccount();
        final authVM = Provider.of<AuthViewModel>(context, listen: false);
        authVM.getAccount().then((_) {
          if (mounted) {
            setState(() {}); // Force refresh if needed
          }
        });
        _initialLoadDone = true;
      });
    }
  }

  void _loadLocationData(
      double minLat, double maxLat, double minLong, double maxLong) {
    if (!mounted) return; // Check if widget is still mounted

    final rentalLocVM =
        Provider.of<RentalLocationViewmodel>(context, listen: false);

    // Reset animation controller
    _markersAnimationController.reset();
    setState(() {
      _locationsLoaded = false;
    });

    // Get rental location data
    rentalLocVM
        .getRentalLocationMapPaging(minLat, maxLat, minLong, maxLong)
        .then((_) {
      if (!mounted) return; // Add this check before setState
      // Start animation when locations are loaded
      if (rentalLocVM.rentalLocationMapPaging != null &&
          rentalLocVM.rentalLocationMapPaging!.isNotEmpty) {
        setState(() {
          _locationsLoaded = true;
        });
        _markersAnimationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _markersAnimationController
        .dispose(); // Missing disposal of the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<LocationInfo> locations = [];
    final rentalLocationViewmodel =
        Provider.of<RentalLocationViewmodel>(context);
    if (rentalLocationViewmodel.rentalLocationMapPaging != null &&
        rentalLocationViewmodel.rentalLocationMapPaging!.isNotEmpty) {
      var rentalLocationList = rentalLocationViewmodel.rentalLocationMapPaging;
      locations = rentalLocationList!.map((e) {
        return LocationInfo(
          id: e.id ?? "",
          address: e.address ?? "Unavailable",
          price: '${e.price} VND',
          duration: '${e.price} years min',
          traffic: '${e.price} views/day',
          type: e.panelSize ?? "Unavailable",
          imageUrl: e.rentalLocationImages != null &&
                  e.rentalLocationImages!.isNotEmpty &&
                  e.rentalLocationImages![0].imageUrl != null
              ? e.rentalLocationImages![0].imageUrl!
              : "lib\\assets\\Image-not-found.png",
          location: LatLng(e.latitude ?? 0, e.longitude ?? 0),
          markerColor: Palette.blueButton,
        );
      }).toList();
      if (locations.isNotEmpty && !_locationsLoaded) {
        setState(() {
          _locationsLoaded = true;
        });
        _markersAnimationController.forward();
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: locations.isNotEmpty
                  ? locations[0].location
                  : const LatLng(10.8231, 106.6297),
              initialZoom: 13.0,
              onMapEvent: (MapEvent mapEvent) {
                if (mapEvent is MapEventMoveEnd) {
                  final bounds = mapEvent.camera.visibleBounds;

                  // Extract the bounds components
                  double minLat = bounds.south;
                  double maxLat = bounds.north;
                  double minLong = bounds.west;
                  double maxLong = bounds.east;

                  // Check if bounds have changed
                  bool boundsChanged = _prevMinLat != minLat ||
                      _prevMaxLat != maxLat ||
                      _prevMinLong != minLong ||
                      _prevMaxLong != maxLong;

                  if (boundsChanged) {
                    // Update the previous bounds
                    _prevMinLat = minLat;
                    _prevMaxLat = maxLat;
                    _prevMinLong = minLong;
                    _prevMaxLong = maxLong;

                    // Debounce the API call
                    // Debounce the API call
                    if (_debounceTimer?.isActive ?? false) {
                      _debounceTimer!.cancel();
                    }
                    _debounceTimer = Timer(Duration(seconds: 1), () {
                      if (mounted) {
                        // Check if widget is still mounted before calling the method
                        _loadLocationData(minLat, maxLat, minLong, maxLong);
                      }
                    });
                  }
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: mapStyles[currentMapStyle]!.urlTemplate,
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: markers(locations),
              ),
            ],
          ),
          Positioned(
            top: 50,
            left: 30,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(context, AppRoutes.bottombar,
                        arguments: BottomBarPage.home.index);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100000),
                      color: Palette.white,
                      boxShadow: [
                        BoxShadow(
                          color: Palette.darkText.withOpacity(0.2),
                          offset: Offset(0, 4),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Icon(Icons.filter_list),
                  ),
                ),
                SizedBox(width: 16), // Adds space between filter and TextField
                Container(
                  width:
                      280, // Explicit width or use Flexible/Expanded to make it responsive
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Palette.white,
                    boxShadow: [
                      BoxShadow(
                        color: Palette.darkText.withOpacity(0.2),
                        offset: Offset(0, 4),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: TextField(
                    // controller: _searchController,
                    // onChanged: _performSearch,
                    decoration: InputDecoration(
                      hintText: 'Tìm kiếm...',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Palette.grey),
                      suffixIcon: Icon(Symbols.location_pin),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Style Switcher Button and Menu
          Positioned(
            left: 16,
            bottom: selectedLocation != null ? 200 : 16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isStyleMenuOpen) ...[
                  Container(
                    decoration: BoxDecoration(
                      color: Palette.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Palette.darkText.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: mapStyles.entries
                          .map(
                            (style) => MaterialButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              onPressed: () {
                                setState(() {
                                  currentMapStyle = style.key;
                                  isStyleMenuOpen = false;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  style.value.icon,
                                  SizedBox(width: 8),
                                  Text(style.value.name),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  SizedBox(height: 12),
                ],
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        isStyleMenuOpen = !isStyleMenuOpen;
                      });
                    },
                    child: Icon(Symbols.layers),
                    backgroundColor: Palette.white,
                    foregroundColor: Palette.blueButton,
                    heroTag: 'layerFAB',
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: FloatingActionButton(
                    onPressed: _isLoadingLocation ? null : _getCurrentLocation,
                    child: _isLoadingLocation
                        ? const CircularProgressIndicator(
                            color: Palette.blueButton,
                            strokeWidth: 2,
                          )
                        : const Icon(Symbols.my_location),
                    backgroundColor: Palette.white,
                    foregroundColor: Palette.blueButton,
                    heroTag: 'locationFAB', // Unique tag for this button
                  ),
                ),
              ],
            ),
          ),

          // Location Info Popup
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.bounceIn,
            left: 10,
            right: 10,
            bottom: 10,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: selectedLocation != null ? 1.0 : 0.0,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Palette.white,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Palette.darkText.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: selectedLocation != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  selectedLocation!.address,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.close),
                                alignment: Alignment.topRight,
                                onPressed: () {
                                  setState(() {
                                    selectedLocation = null;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Location info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Location with icon
                                    Row(
                                      children: [
                                        Icon(Icons.location_on,
                                            color: Colors.blue, size: 16),
                                        SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            selectedLocation!.address,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),

                                    // Price
                                    Text(
                                      'From ${selectedLocation!.price}/month',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Palette.blueButton,
                                      ),
                                    ),
                                    SizedBox(height: 4),

                                    // Details
                                    Text(
                                      selectedLocation!.duration,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      'Traffic: ${selectedLocation!.traffic}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      'Type: ${selectedLocation!.type}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Billboard image
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: (selectedLocation!.imageUrl
                                              .startsWith('http') ||
                                          selectedLocation!.imageUrl
                                              .startsWith('https'))
                                      ? Image.network(
                                          selectedLocation!.imageUrl,
                                          height: 90,
                                          width: 120,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              'lib\\assets\\Image-not-found.png',
                                              height: 90,
                                              width: 120,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        )
                                      : Image.asset(
                                          selectedLocation!.imageUrl,
                                          height: 90,
                                          width: 120,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),

                              // Close button
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          // View detail button
                          Center(
                            child: TextButton(
                              onPressed: () {
                                if(selectedLocation != null){
                                  Navigator.pushReplacementNamed(
                                    context, AppRoutes.acLocationDetail,
                                    arguments: selectedLocation!.id);
                                }
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'View detail',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 16,
                                    color: Colors.grey[700],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
