 import 'package:flutter/material.dart';

enum MapStyle {
  standard,
  dark,
  light,
  satellite
}

class MapStyleData {
  final String name;
  final String urlTemplate;
  final Icon icon;

  MapStyleData({
    required this.name,
    required this.urlTemplate,
    required this.icon,
  });
}
