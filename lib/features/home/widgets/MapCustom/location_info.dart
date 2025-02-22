import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class LocationInfo {
  final String name;
  final String description;
  final LatLng location;
  final Color markerColor;

  LocationInfo({
    required this.name,
    required this.description,
    required this.location,
    required this.markerColor,
  });
}