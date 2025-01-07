import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';
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
      appBar: AppBar(),
      body: SingleChildScrollView(
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
              SizedBox(height: 16),
              CustomTextInput(
                  hintText: 'Old password',
                  labelText: 'Old password',
                  controller: oldPasswordController),
              SizedBox(height: 16),
              CustomTextInput(
                  hintText: 'New password',
                  labelText: 'New password',
                  controller: newPasswordController),
              SizedBox(height: 16),
              const SizedBox(height: 20),
              authViewModel.isLoading
                  ? const Align(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Palette.blueButton, // Nền giống TextFormField
                        foregroundColor: Colors.black, // Màu chữ
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30, // Thụt vào hai bên
                          vertical: 16, // Khoảng cách trên/dưới
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0), // Bo góc
                        ),
                        side: BorderSide(color: Colors.transparent),
                        elevation: 0,
                        minimumSize: Size(double.infinity, 56),
                      ),
                      child: const Text(
                        'Change password',
                        style:
                            TextStyle(color: Palette.lightText, fontSize: 16),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
