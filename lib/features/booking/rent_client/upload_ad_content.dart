import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/app/app_routes.dart';
import 'package:panelway_mobile/core/widgets/back_page.dart';
import 'package:panelway_mobile/core/widgets/custom_button.dart';
import 'package:panelway_mobile/core/widgets/custom_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panelway_mobile/core/widgets/custom_upload_image.dart';
import 'dart:io';

class UploadAdContent extends StatefulWidget {
  const UploadAdContent({super.key});

  @override
  State<UploadAdContent> createState() => _UploadAdContentState();
}

class _UploadAdContentState extends State<UploadAdContent> {
  final TextEditingController titleTextEditingController = TextEditingController();
  final TextEditingController contentTextEditingController = TextEditingController();
  final TextEditingController widthTextEditingController = TextEditingController();
  final TextEditingController heightTextEditingController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 50, bottom: 50, left: 32, right: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BackButtonCustom(title: "Advertising content", buttonTitleDistance: 35,context: context, backToRoute: AppRoutes.bottombar,previousPage: 0,),
                const SizedBox(height: 50.0),
                CustomTextInput(
                    hintText: "Title", controller: titleTextEditingController),
                const SizedBox(height: 16.0),
                ImageUploadOneField(),
                const SizedBox(height: 16.0),
                CustomTextInput(
                    hintText: "Content", controller: contentTextEditingController, needExtendHeight: true,),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextInput(
                          hintText: "Width",
                          controller: widthTextEditingController),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: CustomTextInput(
                          hintText: "Height",
                          controller: heightTextEditingController),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                CustomButton(
                    functionName: "Upload",
                    onPressed: () {
                      // Handle the upload with all form data including image
                        print('Title: ${titleTextEditingController.text}');
                        print('Content: ${contentTextEditingController.text}');
                        print('Width: ${widthTextEditingController.text}');
                        print('Height: ${heightTextEditingController.text}');
                      
                    },
                    buttonBackgroundColor: Palette.blueButton,
                    textColor: Palette.white)
              ],
            ),
          ),
        ],
      ),
    );
  }
}