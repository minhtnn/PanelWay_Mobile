import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/app/app_routes.dart';
import 'package:panelway_mobile/core/constants/role_constant.dart';
import 'package:panelway_mobile/core/enum/bottom_bar_page.dart';
import 'package:panelway_mobile/core/widgets/custom_button.dart';
import 'package:panelway_mobile/core/widgets/custom_field.dart';
import 'package:panelway_mobile/features/auth/view_models/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? _selectedRole;
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
        body: Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Welcome to, Panelway",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 15),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Enter your account to continue",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox(height: 40),
              CustomTextInput(
                  hintText: 'Your phoneNumber',
                  labelText: 'Phone number',
                  controller: phoneNumberController),
              SizedBox(height: 16),
              CustomTextInput(
                hintText: 'Your password',
                labelText: 'Password',
                controller: passwordController,
                isObscureText: true,
              ),
              const SizedBox(height: 16),
              CustomDropDownList(
                hintText: 'Choose your role',
                list: roles,
                selectedValue: _selectedRole,
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              authViewModel.isLoading
                  ? const Align(
                      child: CircularProgressIndicator(),
                    )
                  : CustomButton(
                      functionName: "Login",
                      onPressed: () async {
                        final email = phoneNumberController.text.trim();
                        final password = passwordController.text.trim();
                        final success = await authViewModel.login(
                            email, password, _selectedRole ?? '');
                        if (success && mounted) {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.bottombar,
                              arguments: BottomBarPage.home.index);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(authViewModel.error!)),
                          );
                        }
                      },
                      buttonBackgroundColor: Palette.blueButton,
                      textColor: Palette.lightText),
              const SizedBox(height: 20),
              Align(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.forgetPassword);
                      print("Forgot password!");
                    },
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(
                          color: Palette.deactivatedText,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.12),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Or login with",
                  style: TextStyle(
                      color: Palette.deactivatedText,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: RichText(
                    text: TextSpan(
                  text: "Didn’t have a Panelway account? ",
                  style: TextStyle(
                      color: Palette.deactivatedText, // Màu chữ mặc định
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                      text: "Register",
                      style: TextStyle(
                        color: Palette.blueButton, // Màu chữ của "Register"
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.signup);
                        },
                    ),
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    ));
  }
  @override
  void dispose() {
    phoneNumberController.dispose();
    passwordController.dispose();
    _selectedRole = '';
    super.dispose();
  }
}
