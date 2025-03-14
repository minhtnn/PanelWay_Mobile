import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/core/constants/app_constants.dart';

enum MapStyle { standard, dark, light, satellite }

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

final Map<MapStyle, MapStyleData> mapStyles = {
    MapStyle.standard: MapStyleData(
      name: 'Standard',
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      icon: Icon(Symbols.map_rounded, color: Palette.blueButton),
    ),
    MapStyle.dark: MapStyleData(
      name: 'Dark',
      urlTemplate:
          "https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}.png?api_key=${AppConstrant.flutterMapApiKey}",
      icon: Icon(Symbols.dark_mode_rounded, color: Palette.darkText),
    ),
    MapStyle.light: MapStyleData(
      name: 'Light',
      urlTemplate:
          'https://tiles.stadiamaps.com/tiles/alidade_smooth/{z}/{x}/{y}.png?api_key=${AppConstrant.flutterMapApiKey}',
      icon: Icon(Symbols.light_mode_rounded, color: Palette.yellow),
    ),
    MapStyle.satellite: MapStyleData(
      name: 'Satellite',
      urlTemplate:
          'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}?api_key=${AppConstrant.flutterMapApiKey}',
      icon: Icon(Icons.satellite_alt_outlined, color: Palette.green),
    ),
  };