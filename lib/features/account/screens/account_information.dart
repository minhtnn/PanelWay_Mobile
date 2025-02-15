import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/app/app_routes.dart';
import 'package:panelway_mobile/core/widgets/back_page.dart';
import 'package:panelway_mobile/core/widgets/bottom_bar.dart';
import 'package:panelway_mobile/core/widgets/custom_button.dart';
import 'package:panelway_mobile/core/widgets/custom_field.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({super.key});

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        dateOfBirthController.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        physics: const BouncingScrollPhysics(),
        children: [
          BackButtonCustom(
            context: context,
            backToRoute: AppRoutes.bottombar,
            title: "Account Profile",
            previousPage: 2,
          ),
          const SizedBox(height: 20),
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Palette.white,
                  backgroundImage:
                      AssetImage('lib\\assets\\default-avatar.png'),
                ),
                GestureDetector(
                  onTap: () {
                    // TODO: Thêm logic chọn ảnh
                  },
                  child: const CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.black,
                    child: Icon(Icons.edit, color: Colors.white, size: 16),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          CustomTextInput(
            hintText: "Full name",
            controller: fullNameController,
            hasValue: true,
          ),
          const SizedBox(height: 10),
          CustomTextInput(
            hintText: "Email address",
            controller: emailController,
            hasValue: true,
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: CustomTextInput(
                hintText: "Date of birth",
                controller: dateOfBirthController,
                hasValue: true,
              ),
            ),
          ),
          const SizedBox(height: 10),
          CustomTextInput(
            hintText: "Change password",
            controller: passwordController,
            hasValue: true,
            isObscureText: true,
          ),
          const SizedBox(height: 40),
          CustomButton(
            functionName: "Update profile",
            onPressed: () {
              // TODO: Xử lý cập nhật thông tin người dùng
            },
            buttonBackgroundColor: Palette.blueButton,
            textColor: Palette.white,
          ),
        ],
      ),
    );
  }
}
