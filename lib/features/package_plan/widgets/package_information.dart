import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/core/widgets/custom_button.dart';

class PackageInformation extends StatelessWidget {
  final String packageName;
  final int packagePrice;
  final String packagePriceUnit;
  final String packageButtonName;
  final Color buttonColor;
  final VoidCallback onTap;
  final List<String> featureList;

  const PackageInformation({
    super.key,
    required this.packageName,
    required this.packagePrice,
    required this.packagePriceUnit,
    required this.packageButtonName,
    required this.buttonColor,
    required this.onTap,
    required this.featureList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          packageName,
          textAlign: TextAlign.left,
          style: const TextStyle(
            color: Palette.darkerText,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: [
            const Text(
              "\$",
              style: TextStyle(
                color: Palette.darkText,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              NumberFormat("#,###", "en_US").format(packagePrice),
              style: const TextStyle(
                color: Palette.darkText,
                fontSize: 50,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              packagePriceUnit,
              style: const TextStyle(
                color: Palette.darkText,
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        CustomButton(
          functionName: packageButtonName,
          onPressed: onTap,
          buttonBackgroundColor: buttonColor,
          textColor: Palette.white,
        ),
        const SizedBox(height: 30),
        // Replace ListView.builder with Column for feature list
        ...featureList.map((feature) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  const Icon(
                    Symbols.check,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(feature)),
                ],
              ),
            )),
        const SizedBox(
          height: 80,
        ),
      ],
    );
  }
}
