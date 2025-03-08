import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';

// ignore: must_be_immutable
class CircleIconNavigation extends StatefulWidget {
  final IconData iconData;
  Color? color = Colors.black;
  double? iconSize = 20;
  double? iconPadding = 10;
  double defaultIconSize = 20;
  double defaultIconPadding = 10;
  double? iconWeight = 400;
  final GestureTapCallback onTap;
  CircleIconNavigation(
      {super.key,
      required this.iconData,
      this.color,
      this.iconSize,
      this.iconPadding,
      required this.onTap,
      this.iconWeight
      });

  @override
  State<CircleIconNavigation> createState() => _CircleIconNavigationState();
}

class _CircleIconNavigationState extends State<CircleIconNavigation> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: Palette.grayTransparent,
              width: 1.5,
            )),
        padding: EdgeInsets.all(widget.iconPadding ?? widget.defaultIconPadding),
        child: Icon(
          widget.iconData,
          color: widget.color,
          size: widget.iconSize ?? widget.defaultIconSize,
          weight: widget.iconWeight,
        ),
      ),
    );
  }
}
