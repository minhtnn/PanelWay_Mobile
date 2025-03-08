import 'dart:async';

import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/app/app_routes.dart';
import 'package:panelway_mobile/core/enum/bottom_bar_page.dart';
import 'package:panelway_mobile/core/widgets/back_page.dart';
import 'package:panelway_mobile/data/payloads/requests/register_request.dart';
import 'package:panelway_mobile/features/auth/view_models/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
  final RegisterRequest? request;
  const OTPScreen({super.key, this.request});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  var response;
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  
  // Add timer variables
  Timer? _timer;
  int _remainingSeconds = 30;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    // Start the initial timer when screen loads
    _startResendTimer();
  }

  @override
  void dispose() {
    // Cancel timer when screen is disposed
    _timer?.cancel();
    
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // Method to start/restart the timer
  void _startResendTimer() {
    setState(() {
      _canResend = false;
      _remainingSeconds = 30;
    });
    
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }

  void _handleInput(String value, int index) {
    if (value.length == 1 && index < _focusNodes.length - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.length == 0 && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    
    if(response == null){
      response = authViewModel.SendOTP(widget.request!.phoneNumber);
    }
    // final request =
    //   ModalRoute.of(context)!.settings.arguments as RegisterRequest;
    return Scaffold(
      body: Stack(
        children: [
          BackButtonCustomPosition(
            context: context,
            backToRoute: AppRoutes.signup,
            topSide: 30,
            leftSide: 16,
          ),
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
                        "Welcome to, Panelway",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "We already sent you 4 digit numbers to your phone",
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
                      children: List.generate(4, (index) {
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
                          onTap: _canResend ? () {
                            response = authViewModel.SendOTP(
                                widget.request!.phoneNumber);
                            // Restart timer when resend is clicked
                            _startResendTimer();
                          } : null,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Resend",
                                style: TextStyle(
                                    color: _canResend ? Palette.blueButton : Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              if (!_canResend) 
                                Text(
                                  " ($_remainingSeconds s)",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                            ],
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
                            onPressed: () async {
                              String code = _controllers
                                  .map((controller) => controller.text)
                                  .join();
                              print('Verification code entered: $code');
                              var otp = await response;
                              if (otp!.OtpCode == code) {
                                final success = await authViewModel
                                    .register(widget.request!);
                                if (success && mounted) {
                                  Navigator.pushReplacementNamed(
                                      context, AppRoutes.bottombar,
                                      arguments: BottomBarPage.home.index);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(authViewModel.error!)),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Palette.blueButton, // Nền giống TextFormField
                              foregroundColor: Colors.black, // Màu chữ
                              padding: EdgeInsets.symmetric(
                                horizontal: 30, // Thụt vào hai bên
                                vertical: 16, // Khoảng cách trên/dưới
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12.0), // Bo góc
                              ),
                              side: BorderSide(color: Colors.transparent),
                              elevation: 0,
                              minimumSize: Size(double.infinity, 56),
                            ),
                            child: const Text(
                              'Continue',
                              style: TextStyle(
                                  color: Palette.lightText, fontSize: 16),
                            ),
                          ),
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