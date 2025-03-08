import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:panelway_mobile/core/widgets/non_rotating_marker.dart';
import 'package:panelway_mobile/features/home/screen/ac_map_screen.dart';

class BuildMap extends StatefulWidget {
  final double? latitude;
  final double? longitude;
  const BuildMap({super.key, this.latitude, this.longitude});

  @override
  State<BuildMap> createState() => _BuildMapState();
}

class _BuildMapState extends State<BuildMap> {
  @override
  Widget build(BuildContext context) {
    var latitude = widget.latitude ?? 0;
    var longitude = widget.longitude ?? 0;
    if (widget.latitude == 0.0 && widget.longitude == 0.0) {
      return Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Symbols.location_off_rounded,
                fill: 1,
                color: Palette.dismissibleBackground,
                size: 40,
              ),
              SizedBox(height: 8),
              Text(
                "Location coordinates not available",
                style: TextStyle(
                  color: Palette.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(latitude, longitude),
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: [
              NonRotatingMarker(
                point: LatLng(latitude, longitude),
                width: 120,
                height: 80,
                child: Icon(
                  Icons.location_on,
                  color: Palette.blueButton,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
