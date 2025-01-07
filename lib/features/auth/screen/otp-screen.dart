import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/app/app_routes.dart';
import 'package:panelway_mobile/features/auth/view_models/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(5, (_) => TextEditingController());
  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleInput(String value, int index) {
    if (value.length == 1 && index < _focusNodes.length - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.length == 0 && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _onContinue() {
    String code = _controllers.map((controller) => controller.text).join();
    print('Verification code entered: $code');
    // Here you can handle the code, e.g., sending it to the server for verification.
  }

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
                  "Welcome to, Panelway",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "We already sent you 5 digit numbers toyour email: abcd123@panelway.com",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (index) {
                  return Container(
                    width: 50,
                    height: 50,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onChanged: (value) => _handleInput(value, index),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 40),
              Align(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, AppRoutes.forgetPassword);
                      print("Resend OTP");
                    },
                    child: const Text(
                      "Resend",
                      style: TextStyle(
                          color: Palette.blueButton,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              authViewModel.isLoading
                  ? const Align(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: _onContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Palette.blueButton, // Nền giống TextFormField
                        foregroundColor: Colors.black, // Màu chữ
                        padding: EdgeInsets.symmetric(
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
                        'Continue',
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
