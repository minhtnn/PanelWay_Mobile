import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/app/app_routes.dart';
import 'package:panelway_mobile/core/constants/role_constant.dart';
import 'package:panelway_mobile/core/widgets/custom_field.dart';
import 'package:panelway_mobile/features/auth/view_models/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? _selectedRole;
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
                    hintText: 'Your email address',
                    labelText: 'Email',
                    controller: emailController),
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
                    : ElevatedButton(
                        onPressed: () async {
                          // final email = emailController.text.trim();
                          // final password = passwordController.text.trim();
                          // // debugPrint(email + ", " + password + ", " + (_selectedRole?? "null") );
                          // await authViewModel.login(
                          //     email, password, _selectedRole ?? '');
                          // debugPrint(authViewModel.account?.fullName);
                          // if (authViewModel.errorMessage != null ||
                          //     authViewModel.account?.accessToken == null) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(
                          //         content: Text(authViewModel.errorMessage!)),
                          //   );
                          // } else {
                            Navigator.pushReplacementNamed(context, AppRoutes.acHomeMain);
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
                        child: Container(
                          child: const Text(
                            'Login',
                            style:
                                TextStyle(color: Palette.lightText, fontSize: 16),
                          ),
                        ),
                      ),
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
                const SizedBox(height: 100),
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
                            Navigator.pushReplacementNamed(context, AppRoutes.signup);
                            print("Register tapped");
                          },
                      ),
                    ],
                  )),
                ),
              ],
            ),
          ),
        ));
  }
}
