import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/app/app_routes.dart';
import 'package:panelway_mobile/core/constants/role_constant.dart';
import 'package:panelway_mobile/core/widgets/custom_button.dart';
import 'package:panelway_mobile/core/widgets/custom_field.dart';
import 'package:panelway_mobile/features/auth/view_models/auth_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
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
                  alignment: Alignment.centerLeft, // Căn tiêu đề sang phải
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
                    hintText: 'Your fullname',
                    labelText: 'Fullname',
                    controller: fullNameController),
                const SizedBox(height: 16),
                CustomTextInput(
                    hintText: 'Your email address',
                    labelText: 'Email',
                    controller: emailController),
                const SizedBox(height: 16),
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
                        functionName: "Register",
                        onPressed: () async {
                          Navigator.pushNamed(context, AppRoutes.otp);
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
                const SizedBox(height: 100),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                      text: TextSpan(
                    text: "Already have a Panelway account? ",
                    style: TextStyle(
                        color: Palette.deactivatedText, // Màu chữ mặc định
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(
                        text: "Login",
                        style: TextStyle(
                          color: Palette.blueButton, // Màu chữ của "Register"
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.login);
                            // Navigator.pushNamed(context, "/signup");
                            // Navigator.push(context, LoginScreen());
                          },
                      ),
                    ],
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
