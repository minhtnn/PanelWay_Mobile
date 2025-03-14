import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class LocationInfo {
  final String id;
  final String address;
  final String price;
  final String duration;
  final String traffic;
  final String type;
  final String imageUrl;
  final LatLng location;
  final Color markerColor;

  LocationInfo({
    required this.id,
    required this.address,
    required this.price,
    required this.duration,
    required this.traffic,
    required this.type,
    required this.imageUrl,
    required this.location,
    required this.markerColor,
  });
}