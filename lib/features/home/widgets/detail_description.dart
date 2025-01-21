import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';

class DetailDescription extends StatelessWidget {
  final String title;
  final String description;
  final Color titleColor;
  final Color descriptionColor;
  const DetailDescription(
      {super.key, required this.title, required this.description, this.titleColor = Palette.darkerText, this.descriptionColor = Palette.darkerText});

  @override
  Widget build(BuildContext context) {
    const double fontSizeStandard = 14.0;
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      child: RichText(
        text: TextSpan(
          text: '$title: ',
          style: TextStyle(
              fontSize: fontSizeStandard,
              color: titleColor,
              fontWeight: FontWeight.w600),
          children: <TextSpan>[
            TextSpan(
              text: description,
              style: TextStyle(
                  fontSize: fontSizeStandard,
                  fontWeight: FontWeight.normal,
                  color: descriptionColor),
            ),
          ],
        ),
      ),
    );
  }
}
