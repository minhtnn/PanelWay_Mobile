import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:panelway_mobile/app/app_palette.dart';

class HistoryBox extends StatelessWidget {
  final String statusName;
  final Color statusColor;
  final IconData statusIcon;
  final String statusDescription;
  final String title;
  final String titleDescription;
  const HistoryBox(
      {super.key,
      required this.statusName,
      required this.statusColor,
      required this.statusDescription,
      required this.title,
      required this.titleDescription,
      required this.statusIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Palette.white,
            border: Border.all(
              color: Palette.grayTransparent,
              width: 0.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      statusName,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: statusColor),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Icon(
                      statusIcon,
                      color: statusColor,
                      size: 18,
                      fill: 1,
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, bottom: 30),
                  child: Text(
                    statusDescription,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Palette.darkerText,
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  height: 190,
                  decoration: BoxDecoration(
                      color: Palette.deactivatedText,
                      borderRadius: BorderRadius.circular(16)),
                ),
                Container(
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.only(top: 12, bottom: 5),
                  child: Text(
                    title,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Palette.darkerText,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    titleDescription,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Palette.darkerText,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
