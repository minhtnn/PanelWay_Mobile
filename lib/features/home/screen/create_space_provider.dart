import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/app/app_routes.dart';
import 'package:panelway_mobile/core/widgets/back_page.dart';
import 'package:panelway_mobile/core/widgets/custom_button.dart';
import 'package:panelway_mobile/core/widgets/custom_field.dart';
import 'package:panelway_mobile/core/widgets/custom_upload_image.dart';
import 'package:panelway_mobile/core/widgets/progress_bar.dart';
import 'package:panelway_mobile/core/enum/status_enum.dart';

class UploadSpaceInformation extends StatefulWidget {
  const UploadSpaceInformation({super.key});

  @override
  State<UploadSpaceInformation> createState() => _UploadSpaceInformationState();
}

class _UploadSpaceInformationState extends State<UploadSpaceInformation> {
  int currentStep = 1;

  final TextEditingController titleTextEditingController = TextEditingController();
  final TextEditingController locationTextEditingController = TextEditingController();
  final TextEditingController descriptionTextEditingController = TextEditingController();
  final TextEditingController audienceTypeTextEditingController = TextEditingController();
  final TextEditingController widthTextEditingController = TextEditingController();
  final TextEditingController heightTextEditingController = TextEditingController();
  final TextEditingController priceTextEditingController = TextEditingController();
  final TextEditingController minRentalTimeTextEditingController = TextEditingController();
  String? _selectedPanelType;
  String? _selectedSpaceStatus;
  String? _selectedMinRentalUnit;

  Widget getCurrentStepContent() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Column(
        key: ValueKey<int>(currentStep),
        children: getStepContent(),
      ),
    );
  }

  List<Widget> getStepContent() {
    switch (currentStep) {
      case 1:
        return [
          CustomTextInput(hintText: "Title", controller: titleTextEditingController),
          const SizedBox(height: 16.0),
          CustomDropDownList(
            hintText: "Panel type",
            list: [],
            onChanged: (value) {
              setState(() {
                _selectedPanelType = value;
              });
            },
          ),
          const SizedBox(height: 16.0),
          CustomTextInput(hintText: "Location", controller: locationTextEditingController),
          const SizedBox(height: 16.0),
          CustomTextInput(hintText: "Description", controller: descriptionTextEditingController, needExtendHeight: true),
        ];
      case 2:
        return [
          const Text("Daylight", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16.0),
          ImageUploadMultipleField(),
          const SizedBox(height: 32.0),
          const Text("Night time", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16.0),
          ImageUploadMultipleField(),
        ];
      case 3:
        return [
          CustomTextInput(hintText: "Max width", controller: widthTextEditingController),
          const SizedBox(height: 16.0),
          CustomTextInput(hintText: "Max height", controller: heightTextEditingController),
          const SizedBox(height: 16.0),
          CustomTextInput(hintText: "Price (\$)", controller: priceTextEditingController),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: CustomTextInput(hintText: "Min rental time", controller: minRentalTimeTextEditingController),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: CustomDropDownList(
                  hintText: "unit",
                  list: getRentalTimeUnitAsMap(),
                  onChanged: (value) {
                    setState(() {
                      _selectedMinRentalUnit = value;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          CustomDropDownList(
            hintText: "Status",
            list: getSpaceStatusAsMap(),
            onChanged: (value) {
              setState(() {
                _selectedSpaceStatus = value;
              });
            },
          ),
        ];
      default:
        return [];
    }
  }

  List<Widget> getBottomButtons() {
    List<Widget> buttons = [];
    if (currentStep > 1) {
      buttons.add(Expanded(
        child: CustomButton(
          functionName: "Back",
          onPressed: () {
            setState(() {
              currentStep--;
            });
          },
          buttonBackgroundColor: Colors.grey,
          textColor: Colors.white,
        ),
      ));
    }
    buttons.add(const SizedBox(width: 16.0));
    buttons.add(Expanded(
      child: CustomButton(
        functionName: currentStep < 3 ? "Next" : "Preview",
        onPressed: () {
          if (currentStep < 3) {
            setState(() {
              currentStep++;
            });
          } else {
            Navigator.pushNamed(context, AppRoutes.acLocationDetail);
          }
        },
        buttonBackgroundColor: Palette.blueButton,
        textColor: Colors.white,
      ),
    ));
    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 50),
        children: [
          BackButtonCustom(
            title: "Advertising space",
            buttonTitleDistance: 35,
            context: context,
            backToRoute: AppRoutes.bottombar,
            previousPage: 0,
          ),
          const SizedBox(height: 30.0),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: currentStep.toDouble()),
            duration: const Duration(milliseconds: 500),
            builder: (context, value, child) {
              return ProgressBarScreen(currentStep: value.toInt(), totalSteps: 3);
            },
          ),
          const SizedBox(height: 30.0),
          getCurrentStepContent(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(children: getBottomButtons()),
      ),
    );
  }
}
