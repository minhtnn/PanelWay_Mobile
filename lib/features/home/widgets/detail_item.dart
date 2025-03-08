import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/data/models/rental_location.dart';
import 'package:panelway_mobile/data/models/rental_location_image.dart';

class DetailItem extends StatelessWidget {
  final String label;
  final String value;

  DetailItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'lib/assets/Icon.png',
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(value),
          ],
        ),
      ],
      spacing: 8,
    );
  }
}

