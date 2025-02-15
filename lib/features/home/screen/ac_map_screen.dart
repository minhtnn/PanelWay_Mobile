import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Danh sách các marker
  final List<Marker> markers = [
    Marker(
      point: LatLng(10.8231, 106.6297), // Tọa độ của TP.HCM
      width: 80,
      height: 80,
      rotate: false, // Luôn giữ nguyên hướng
      child: Icon(Icons.location_on, color: Colors.red, size: 40),
    ),
    Marker(
      point: LatLng(10.762622, 106.660172), // Tọa độ của Dinh Độc Lập
      width: 80,
      height: 80,
      rotate: false, // Luôn giữ nguyên hướng
      child: Icon(Icons.location_on, color: Colors.blue, size: 40),
    ),
    Marker(
      point: LatLng(10.77689, 106.700806), // Tọa độ của Nhà thờ Đức Bà
      width: 80,
      height: 80,
      rotate: false, // Luôn giữ nguyên hướng
      child: Icon(Icons.location_on, color: Colors.green, size: 40),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Map with Fixed Markers'),
        backgroundColor: Colors.green[700],
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: markers[0].point, // Tọa độ trung tâm (TP.HCM)
          initialZoom: 13.0,
          onMapEvent: (MapEvent mapEvent) {
            if (mapEvent is MapEventMove) {
              print('Center: ${mapEvent.camera.center}'); // Vị trí trung tâm
              print('Zoom: ${mapEvent.camera.zoom}'); // Mức zoom hiện tại

              // Lấy bounding box (giới hạn hiển thị)
              final bounds = mapEvent.camera.visibleBounds;
              print('Bounds: ${bounds.toString()}');
            }
          },
        ),
        children: [
          TileLayer(
            urlTemplate:
                "https://tile.openstreetmap.org/{z}/{x}/{y}.png", // Loại bỏ subdomains
          ),
          MarkerLayer(
            markers: markers, // Thêm các marker vào đây
          ),
        ],
      ),
    );
  }
}
