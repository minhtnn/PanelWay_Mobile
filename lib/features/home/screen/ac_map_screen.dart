import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('simple'),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(21.0285, 105.8542), // Tọa độ của Hà Nội
          initialZoom: 13.0, // Mức zoom ban đầu
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
            subdomains: [
              'a',
              'b',
              'c'
            ], // You can keep or remove subdomains depending on the tile provider
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(21.0285, 105.8542), // Vị trí marker
                child: Icon(Icons.location_on, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
      // Text("data"),
    );
  }
}
