import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/app/app_routes.dart';
import 'package:panelway_mobile/core/widgets/back_page.dart';
import 'package:panelway_mobile/core/widgets/custom_button.dart';
import 'package:panelway_mobile/core/widgets/custom_field.dart';
import 'package:panelway_mobile/features/auth/view_models/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      body: Stack(
        children: [
          BackButtonCustom(context: context, backToRoute: AppRoutes.login,),
          Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft, // Căn tiêu đề sang phải
                    child: Text(
                      "Forget password",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 40),
                  CustomTextInput(
                      hintText: 'Your email address',
                      labelText: 'Email',
                      controller: emailController),
                  const SizedBox(height: 16),
                  CustomTextInput(
                      hintText: 'Old password',
                      labelText: 'Old password',
                      controller: oldPasswordController),
                  const SizedBox(height: 16),
                  CustomTextInput(
                      hintText: 'New password',
                      labelText: 'New password',
                      controller: newPasswordController),
                  const SizedBox(height: 20),
                  authViewModel.isLoading
                      ? const Align(
                          child: CircularProgressIndicator(),
                        )
                      : CustomButton(
                          functionName: "Change password",
                          onPressed: () async {
                            final email = emailController.text.trim();
                            final oldPassword = oldPasswordController.text.trim();
                            final newPassword = newPasswordController.text.trim();
          
                            // await authViewModel;
                            // print(authViewModel.account?.toJson());
                            // if (authViewModel.errorMessage != null ||
                            //     authViewModel.account?.accessToken == null) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     SnackBar(
                            //         content: Text(authViewModel.errorMessage!)),
                            //   );
                            // } else {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     SnackBar(content: Text('Change password successful!')),
                            //   );
                            // }
                          },
                          buttonBackgroundColor: Palette.blueButton,
                          textColor: Palette.lightText),
                ],
              ),
            ),
          ),
        ),
        ],
      ),
    );
  }
}
