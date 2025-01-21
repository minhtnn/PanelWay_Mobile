import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';

class BackButtonCustom extends StatelessWidget {
  final BuildContext context;
  final String backToRoute;
  final double? topSide;
  final double? leftSide;
  final double? rightSide;
  const BackButtonCustom({super.key, required this.context, required this.backToRoute, this.topSide = 40, this.leftSide, this.rightSide});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topSide,
      left: (leftSide != null) ? leftSide : null,
      right: (rightSide!= null) ? rightSide : null,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Palette.whiteButton,
          border: Border.all(color: Palette.borderButton, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.popAndPushNamed(context, backToRoute); // Quay lại trang trước đó
          },
        ),
      ),
    );
  }
}
