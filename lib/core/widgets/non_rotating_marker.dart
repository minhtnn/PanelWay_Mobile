import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class NonRotatingMarker extends Marker {
  final double? iconSize;
  NonRotatingMarker({
    this.iconSize,
    required LatLng point,
    required Widget child,
    double width = 80.0,
    double height = 80.0,
    Key? key,
  }) : super(
          point: point,
          child: Builder(
            builder: (BuildContext context) {
              final mapState = MapCamera.of(context);
              return Transform.rotate(
                angle: -mapState.rotation * pi / 180,
                child: child,
              );
            },
          ),
          width: (iconSize!= null)? iconSize:width,
          height: (iconSize!= null)? iconSize:height,
        );
}