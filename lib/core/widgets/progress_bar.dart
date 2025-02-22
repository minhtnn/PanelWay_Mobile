import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';

class ProgressBarScreen extends StatefulWidget {
  final int currentStep;
  final int totalSteps;

  const ProgressBarScreen(
      {Key? key, required this.currentStep, required this.totalSteps})
      : super(key: key);

  @override
  _ProgressBarScreenState createState() => _ProgressBarScreenState();
}

class _ProgressBarScreenState extends State<ProgressBarScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double padding = 40;
    double availableWidth = screenWidth - padding;
    double progress =
        widget.currentStep / widget.totalSteps; // Calculate progress

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 20),
          width: 100,
          decoration: BoxDecoration(
              color: Palette.darkerText,
              borderRadius: BorderRadius.circular(100)),
          child: Text(
            "${widget.currentStep.toString().padLeft(2, '0')} / ${widget.totalSteps.toString().padLeft(2, '0')}",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Palette.white,
                fontSize: 15,
                fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            // Progress Bar Background
            Container(
              height: 6,
              width: availableWidth,
              decoration: BoxDecoration(
                color: Palette.buttonGrayTransparent,
                borderRadius: BorderRadius.circular(3),
              ),
            ),

            // Progress Bar Fill
            Positioned(
              left: 0,
              child: Container(
                width: availableWidth *
                    progress, // Dynamically change width
                height: 6,
                decoration: BoxDecoration(
                  color: Palette.blueButton,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ],
        ),
        //   Stack(
        //     alignment: Alignment.center,
        //     children: [
        //       // Progress Bar Background
        //       Container(
        //         width: 300,
        //         height: 6,
        //         decoration: BoxDecoration(
        //           color: Colors.grey[300],
        //           borderRadius: BorderRadius.circular(3),
        //         ),
        //       ),

        //       // Progress Bar Fill
        //       Positioned(
        //         left: 0,
        //         child: Container(
        //           width: 300 * progress, // Dynamically change width
        //           height: 6,
        //           decoration: BoxDecoration(
        //             color: Colors.blue,
        //             borderRadius: BorderRadius.circular(3),
        //           ),
        //         ),
        //       ),

        //       // Step Counter Box
        //       Positioned(
        //         top: -20,
        //         child: Container(
        //           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        //           decoration: BoxDecoration(
        //             color: Colors.black87,
        //             borderRadius: BorderRadius.circular(12),
        //           ),
        //           child: Text(
        //             "${widget.currentStep.toString().padLeft(2, '0')} / ${widget.totalSteps.toString().padLeft(2, '0')}", // Add leading zeroes
        //             style: const TextStyle(
        //                 color: Colors.white, fontWeight: FontWeight.bold),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
      ],
    );
  }
}
