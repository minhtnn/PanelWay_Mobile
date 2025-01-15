import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';

class CustomButton extends StatelessWidget {
  final String functionName;
  final IconData? icon;
  bool? hasBorder = false;
  final VoidCallback onPressed;
  final Color buttonBackgroundColor;
  final Color textColor;
  CustomButton(
      {super.key,
      required this.functionName,
      this.icon,
      this.hasBorder,
      required this.onPressed,
      required this.buttonBackgroundColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    const double textSize = 16;
    const double iconSize = 20;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonBackgroundColor,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 30, // Thụt vào hai bên
          vertical: 16, // Khoảng cách trên/dưới
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: hasBorder == true
              ? const BorderSide(color: Palette.borderButton, width: 1.0) // Viền đen
              : BorderSide.none, // Không có viền
        ),

        elevation: hasBorder == true ? 0.5 : 0.0,
        shadowColor: hasBorder == true ? Palette.shadowForButton : null,
        minimumSize: const Size(double.infinity, 56),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            functionName + "    ",
            style: TextStyle(color: textColor, fontSize: textSize),
          ),
          (icon != null)
              ? Icon(
                  icon,
                  size: iconSize,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
