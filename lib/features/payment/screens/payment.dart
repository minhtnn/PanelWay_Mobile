import 'dart:async';

import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/app/app_routes.dart';
import 'package:panelway_mobile/core/enum/bottom_bar_page.dart';
import 'package:panelway_mobile/core/enum/status_enum.dart';
import 'package:panelway_mobile/core/widgets/back_page.dart';
import 'package:panelway_mobile/core/widgets/custom_button.dart';
import 'package:panelway_mobile/features/auth/view_models/auth_viewmodel.dart';
import 'package:panelway_mobile/features/package_plan/view_model/subcription_view_model.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeScreen extends StatefulWidget {
  final String qrCodeData;
  final int timeoutSeconds;

  const QRCodeScreen({
    super.key,
    required this.qrCodeData,
    this.timeoutSeconds = 180,
  });

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen>
    with TickerProviderStateMixin {
  late int remainingSeconds;
  Timer? countdownTimer;
  AnimationController? _animationController;
  bool isLoading = false;
  bool paymentSuccessful = false;

  @override
  void initState() {
    super.initState();
    remainingSeconds = widget.timeoutSeconds;

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.timeoutSeconds),
    );

    _animationController!.forward();
    startTimer();
    simulatePaymentCheck();
  }

  void simulatePaymentCheck() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      checkPaymentStatus().then((success) {
        if (success) {
          paymentSuccessful = true;
          timer.cancel();
          handlePaymentSuccess();
        }
      });
    });
  }

  // Add this method to make the API call
  Future<bool> checkPaymentStatus() async {
    try {
      // Replace with your actual API call
      // For example:
      // final response = await http.get(Uri.parse('your_payment_verification_endpoint'));
      // return response.statusCode == 200 && jsonDecode(response.body)['status'] == 'success';

      final subcriptionViewModel =
          Provider.of<SubcriptionViewModel>(context, listen: false);
      if (subcriptionViewModel.payosQrResponse != null) {
        var payosQrResponse = subcriptionViewModel.payosQrResponse;
        var payosCheckResponse = await subcriptionViewModel
            .getPayOsCheck(payosQrResponse!.orderCode);
        debugPrint("Check payOS order: ${payosCheckResponse!.toJson()}");
        if (payosCheckResponse != null) {
          debugPrint(
              "Check status: ${payosCheckResponse.status == PayOsStatusEnum.PAID.label}");
          return payosCheckResponse.status == PayOsStatusEnum.PAID.label;
        }
      }
      // For testing purposes, you can simulate a successful payment after some time
      await Future.delayed(const Duration(seconds: 10));
      return true; // Simulate success after 10 seconds
    } catch (e) {
      print('Error checking payment status: $e');
      return false;
    }
  }

  void handlePaymentSuccess() {
    countdownTimer?.cancel();
    _animationController?.stop();

    // Show success notification dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Payment Successful"),
        content: const Text(
          "Your payment has been successfully processed.",
          textAlign: TextAlign.center,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog

              // Refresh subscriptions before navigating back
              final subscriptionVM =
                  Provider.of<SubcriptionViewModel>(context, listen: false);
              final authVM = Provider.of<AuthViewModel>(context, listen: false);

              // Reload subscriptions list
              subscriptionVM.getSubcriptions();

              // Reload current subscription
              authVM.getAccount().then((account) {
                if (account != null && account.id != null) {
                  subscriptionVM.getCurrentSubcription(
                      account.id ?? "", "Active");
                }
              });

              // Navigate to bottom bar page
              Navigator.popAndPushNamed(context, AppRoutes.bottombar,
                  arguments: BottomBarPage.packagePlan.index);
            },
            style: const ButtonStyle(
              alignment: Alignment.center,
            ),
            child: const Text("OK",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        timer.cancel();
        _handleTimeout();
      }
    });
  }

  void _handleTimeout() {
    _animationController?.stop();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("QR Code Expired"),
        content: const Text(
          "The QR code has expired. Please return to try again.",
          textAlign: TextAlign.center,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              _cancelPayment(); // Return to previous screen
            },
            style: const ButtonStyle(
              alignment: Alignment.center,
            ),
            child: const Text("OK",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _cancelPayment() {
    countdownTimer?.cancel();
    _animationController?.stop();

    Navigator.popAndPushNamed(context, AppRoutes.bottombar,
        arguments: BottomBarPage.packagePlan.index);
  }

  String get formattedTime {
    int minutes = remainingSeconds ~/ 60;
    int seconds = remainingSeconds % 60;
    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press
        _cancelPayment();
        return false; // We handle navigation ourselves
      },
      child: Scaffold(
        body: isLoading
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text("Processing payment...",
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
              )
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      BackButtonCustom(
                          context: context,
                          backToRoute: AppRoutes.bottombar,
                          title: "QR Code Payment",
                          buttonTitleDistance: 50,
                          previousPage: BottomBarPage.packagePlan.index),
                      // Instructions text
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 24),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            style: TextStyle(
                              color: Palette.darkText,
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(
                                text: "Scan this QR code ",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              TextSpan(
                                text:
                                    "with your banking app to complete payment",
                              ),
                            ],
                          ),
                        ),
                      ),

                      // QR code container
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 24),
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 15,
                                spreadRadius: 1,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Logo
                              Padding(
                                padding: const EdgeInsets.only(bottom: 24),
                                child: Image.asset(
                                  "lib/assets/panelway-black-icon.png",
                                  height: 32,
                                ),
                              ),

                              // QR code
                              Container(
                                padding: const EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  color: Palette.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.1),
                                    width: 1,
                                  ),
                                ),
                                child: QrImageView(
                                  data: widget.qrCodeData,
                                  version: QrVersions.auto,
                                  size: 220.0,
                                  // backgroundColor: Colors.white,
                                  errorCorrectionLevel: QrErrorCorrectLevel.H,
                                  padding: const EdgeInsets.all(8),
                                  eyeStyle: const QrEyeStyle(
                                    eyeShape: QrEyeShape.square,
                                    color: Palette.darkerText,
                                  ),
                                  dataModuleStyle: const QrDataModuleStyle(
                                    dataModuleShape: QrDataModuleShape.square,
                                    color: Palette.darkerText,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 16),

                              // Timer
                              Column(
                                children: [
                                  const Text(
                                    "Code expires in:",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Palette.dark_grey,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        // Background circle
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey.shade50,
                                          ),
                                        ),

                                        // Progress indicator
                                        SizedBox(
                                          height: 60,
                                          width: 60,
                                          child: CircularProgressIndicator(
                                            value: remainingSeconds /
                                                widget.timeoutSeconds,
                                            backgroundColor:
                                                Colors.grey.shade200,
                                            strokeWidth: 6,
                                            color: remainingSeconds < 30
                                                ? Palette.red
                                                : remainingSeconds < 60
                                                    ? Palette.yellow
                                                    : Palette.dark_grey,
                                          ),
                                        ),

                                        // Timer text
                                        Text(
                                          formattedTime,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: remainingSeconds < 30
                                                ? Palette.red
                                                : Palette.darkText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Cancel button
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: CustomButton(
                            functionName: "Cancel",
                            onPressed: _cancelPayment,
                            hasBorder: true,
                            buttonBackgroundColor: Palette.white,
                            textColor: Palette.darkText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
