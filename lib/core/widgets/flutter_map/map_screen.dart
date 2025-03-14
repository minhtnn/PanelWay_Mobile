// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:material_symbols_icons/symbols.dart';
// import 'package:panelway_mobile/app/app_palette.dart';
// import 'package:panelway_mobile/app/app_routes.dart';
// import 'package:panelway_mobile/core/constants/app_constants.dart';
// import 'package:panelway_mobile/core/enum/bottom_bar_page.dart';
// import 'package:panelway_mobile/core/widgets/non_rotating_marker.dart';
// import 'package:panelway_mobile/features/home/widgets/MapCustom/custom_marker_widget.dart';
// import 'package:panelway_mobile/features/home/widgets/MapCustom/location_info.dart';
// import 'package:panelway_mobile/features/home/widgets/MapCustom/map_style_data.dart';
// 
// 
// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   LocationInfo? selectedLocation;
//   MapStyle currentMapStyle = MapStyle.standard;
//   bool isStyleMenuOpen = false;
//   bool _isLoadingLocation = false;
//   LatLng? _currentUserLocation;
//   final MapController _mapController = MapController();

//   // Map style definitions
//   final Map<MapStyle, MapStyleData> mapStyles = {
//     MapStyle.standard: MapStyleData(
//       name: 'Standard',
//       urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//       icon: Icon(Icons.map, color: Colors.blue),
//     ),
//     MapStyle.dark: MapStyleData(
//       name: 'Dark',
//       urlTemplate:
//           "https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}.png?api_key=${AppConstrant.flutterMapApiKey}",
//       icon: Icon(Icons.nights_stay, color: Colors.grey[800]),
//     ),
//     MapStyle.light: MapStyleData(
//       name: 'Light',
//       urlTemplate:
//           'https://tiles.stadiamaps.com/tiles/alidade_smooth/{z}/{x}/{y}.png?api_key=${AppConstrant.flutterMapApiKey}',
//       icon: Icon(Icons.light_mode, color: Colors.orange),
//     ),
//     MapStyle.satellite: MapStyleData(
//       name: 'Satellite',
//       urlTemplate:
//           'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}?api_key=${AppConstrant.flutterMapApiKey}',
//       icon: Icon(Icons.satellite, color: Colors.green),
//     ),
//   };

//   final List<LocationInfo> locations = [
//     LocationInfo(
//       name: 'TP.HCM',
//       description:
//           'The largest city in Vietnam, known for its vibrant culture and history.',
//       location: LatLng(10.8231, 106.6297),
//       markerColor: Colors.red,
//     ),
//     LocationInfo(
//       name: 'Independence Palace',
//       description:
//           'Historic landmark that served as South Vietnam\'s presidential palace.',
//       location: LatLng(10.762622, 106.660172),
//       markerColor: Colors.blue,
//     ),
//     LocationInfo(
//       name: 'Notre-Dame Cathedral',
//       description:
//           'Iconic French colonial era cathedral in the heart of Ho Chi Minh City.',
//       location: LatLng(10.77689, 106.700806),
//       markerColor: Colors.green,
//     ),
//   ];

//   Future<void> _getCurrentLocation() async {
//     setState(() {
//       _isLoadingLocation = true;
//     });

//     try {
//       // Check if location services are enabled
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content:
//                 Text('Location services are disabled. Please enable them.'),
//             backgroundColor: Colors.red,
//           ),
//         );
//         return;
//       }

//       // Check location permission
//       LocationPermission permission = await Geolocator.checkPermission();

//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Location permissions are denied'),
//               backgroundColor: Colors.red,
//             ),
//           );
//           return;
//         }
//       }

//       if (permission == LocationPermission.deniedForever) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: const Text(
//                 'Location permissions are permanently denied. Please enable them in settings.'),
//             backgroundColor: Colors.red,
//             action: SnackBarAction(
//               label: 'Settings',
//               onPressed: () => Geolocator.openAppSettings(),
//               textColor: Colors.white,
//             ),
//           ),
//         );
//         return;
//       }

//       // Get current position
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);

//       setState(() {
//         _currentUserLocation = LatLng(position.latitude, position.longitude);
//       });

//       // Animate map to user location
//       _mapController.move(
//         _currentUserLocation!,
//         15.0, // zoom level
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error getting location: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     } finally {
//       setState(() {
//         _isLoadingLocation = false;
//       });
//     }
//   }

//   List<Marker> get markers {
//     List<Marker> allMarkers = locations
//         .map(
//           (loc) => NonRotatingMarker(
//             point: loc.location,
//             width: 120,
//             height: 80,
//             child: CustomMarkerWidget(
//               label: loc.name,
//               color: loc.markerColor,
//               isSelected: selectedLocation == loc,
//               onTap: () {
//                 setState(() {
//                   selectedLocation = loc;
//                 });
//               },
//             ),
//           ),
//         )
//         .toList();

//     // Add user location marker if available
//     if (_currentUserLocation != null) {
//       allMarkers.add(
//         NonRotatingMarker(
//           point: _currentUserLocation!,
//           width: 60,
//           height: 60,
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.blue.withOpacity(0.3),
//               shape: BoxShape.circle,
//               border: Border.all(
//                 color: Colors.blue,
//                 width: 2,
//               ),
//             ),
//             child: const Center(
//               child: Icon(
//                 Icons.my_location,
//                 color: Colors.blue,
//                 size: 30,
//               ),
//             ),
//           ),
//         ),
//       );
//     }

//     return allMarkers;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           FlutterMap(
//             mapController: _mapController,
//             options: MapOptions(
//               initialCenter: locations[0].location,
//               initialZoom: 13.0,
//               onMapEvent: (MapEvent mapEvent) {
//                 if (mapEvent is MapEventMove) {
//                   print('Center: ${mapEvent.camera.center}');
//                   print('Zoom: ${mapEvent.camera.zoom}');
//                   final bounds = mapEvent.camera.visibleBounds;
//                   print('Bounds: ${bounds.toString()}');
//                 }
//               },
//             ),
//             children: [
//               TileLayer(
//                 urlTemplate: mapStyles[currentMapStyle]!.urlTemplate,
//                 userAgentPackageName: 'com.example.app',
//               ),
//               MarkerLayer(
//                 markers: markers,
//               ),
//             ],
//           ),
//           Positioned(
//             top: 50,
//             left: 30,
//             child: Row(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.popAndPushNamed(context, AppRoutes.bottombar,
//                         arguments: BottomBarPage.home.index);
//                   },
//                   child: Container(
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(100000),
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.2),
//                           offset: Offset(0, 4),
//                           blurRadius: 6,
//                         ),
//                       ],
//                     ),
//                     child: Icon(Icons.filter_list),
//                   ),
//                 ),
//                 SizedBox(width: 16), // Adds space between filter and TextField
//                 Container(
//                   width:
//                       280, // Explicit width or use Flexible/Expanded to make it responsive
//                   padding: EdgeInsets.symmetric(horizontal: 16.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(30),
//                     color: Palette.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.2),
//                         offset: Offset(0, 4),
//                         blurRadius: 6,
//                       ),
//                     ],
//                   ),
//                   child: TextField(
//                     // controller: _searchController,
//                     // onChanged: _performSearch,
//                     decoration: InputDecoration(
//                       hintText: 'Tìm kiếm...',
//                       border: InputBorder.none,
//                       prefixIcon: Icon(Icons.search, color: Colors.grey),
//                       suffixIcon: Icon(Symbols.location_pin),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Style Switcher Button and Menu
//           Positioned(
//             left: 16,
//             bottom: selectedLocation != null ? 200 : 16,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 if (isStyleMenuOpen) ...[
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 8,
//                           offset: Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: mapStyles.entries
//                           .map(
//                             (style) => MaterialButton(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 16, vertical: 8),
//                               onPressed: () {
//                                 setState(() {
//                                   currentMapStyle = style.key;
//                                   isStyleMenuOpen = false;
//                                 });
//                               },
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   style.value.icon,
//                                   SizedBox(width: 8),
//                                   Text(style.value.name),
//                                 ],
//                               ),
//                             ),
//                           )
//                           .toList(),
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                 ],
//                 Container(
//                   padding: EdgeInsets.only(top: 10, bottom: 10),
//                   child: FloatingActionButton(
//                     onPressed: () {
//                       setState(() {
//                         isStyleMenuOpen = !isStyleMenuOpen;
//                       });
//                     },
//                     child: Icon(Icons.layers),
//                     backgroundColor: Colors.white,
//                     foregroundColor: Colors.blue,
//                     heroTag: 'layerFAB',
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(top: 10, bottom: 10),
//                   child: FloatingActionButton(
//                     onPressed: _isLoadingLocation ? null : _getCurrentLocation,
//                     child: _isLoadingLocation
//                         ? const CircularProgressIndicator(
//                             color: Colors.blue,
//                             strokeWidth: 2,
//                           )
//                         : const Icon(Icons.my_location),
//                     backgroundColor: Colors.white,
//                     foregroundColor: Colors.blue,
//                     heroTag: 'locationFAB', // Unique tag for this button
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Location Info Popup
//           AnimatedPositioned(
//             duration: Duration(milliseconds: 300),
//             curve: Curves.easeInOut,
//             left: 0,
//             right: 0,
//             bottom: selectedLocation != null ? 0 : -200,
//             child: AnimatedOpacity(
//               duration: Duration(milliseconds: 300),
//               opacity: selectedLocation != null ? 1.0 : 0.0,
//               child: Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 10,
//                       offset: Offset(0, -5),
//                     ),
//                   ],
//                 ),
//                 child: selectedLocation != null
//                     ? Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 selectedLocation!.name,
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               IconButton(
//                                 icon: Icon(Icons.close),
//                                 onPressed: () {
//                                   setState(() {
//                                     selectedLocation = null;
//                                   });
//                                 },
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             selectedLocation!.description,
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           SizedBox(height: 16),
//                         ],
//                       )
//                     : SizedBox(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
