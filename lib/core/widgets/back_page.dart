import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';

class BackButtonCustom extends StatelessWidget {
  final BuildContext context;
  final String backToRoute;
  const BackButtonCustom({super.key, required this.context, required this.backToRoute});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40, // Khoảng cách từ trên xuống (có thể điều chỉnh)
      left: 20, // Khoảng cách từ trái sang
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
