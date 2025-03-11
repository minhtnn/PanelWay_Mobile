import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/app/app_routes.dart';
import 'package:panelway_mobile/core/widgets/custom_button.dart';
import 'package:panelway_mobile/core/widgets/custom_field.dart';
import 'package:panelway_mobile/data/payloads/requests/register_request.dart';
import 'package:panelway_mobile/features/auth/view_models/auth_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? _selectedGender;
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final _formKey = GlobalKey<FormState>();
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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      CustomTextInput(
                        hintText: 'Your username',
                        labelText: 'Username',
                        controller: userNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextInput(
                        hintText: 'Your fullname',
                        labelText: 'Fullname',
                        controller: fullNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextInput(
                              hintText: "Age",
                              controller: ageController,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your age';
                                }
                                final age = int.tryParse(value);
                                if (age == null || age <= 0) {
                                  return 'Please enter a valid age';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomDropDownList(
                              hintText: "Gender",
                              selectedValue: _selectedGender,
                              list: [
                                {'label': 'Male', 'value': 'Male'},
                                {'label': 'Female', 'value': 'Female'},
                                {'label': 'Other', 'value': 'Other'}
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomTextInput(
                        hintText: 'Your phone number: (+84)xxx.xxx.xxx',
                        labelText: 'Phone number',
                        controller: phoneNumberController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (!RegExp(r'^\+?\d{10,15}$').hasMatch(value)) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextInput(
                        hintText: 'Your password',
                        labelText: 'Password',
                        controller: passwordController,
                        isObscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
                            return 'Password must contain at least one uppercase letter';
                          }
                          if (!RegExp(r'^(?=.*[!@#$%^&*(),.?":{}|<>])')
                              .hasMatch(value)) {
                            return 'Password must contain at least one special character';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                authViewModel.isLoading
                    ? const Align(
                        child: CircularProgressIndicator(),
                      )
                    : CustomButton(
                        functionName: "Register",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (_selectedGender == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please select a gender')),
                              );
                              return;
                            }

                            var signUpRequest = RegisterRequest(
                              age: ageController.text,
                              fullName: fullNameController.text,
                              gender: _selectedGender!,
                              phoneNumber: phoneNumberController.text,
                              userName: userNameController.text,
                              password: passwordController.text,
                            );
                            // Only navigate after validation succeeds
                            Navigator.pushNamed(context, AppRoutes.otp,
                                arguments: signUpRequest);
                          }
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
