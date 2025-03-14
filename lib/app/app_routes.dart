import 'package:flutter/material.dart';
import 'package:panelway_mobile/core/widgets/bottom_bar.dart';
import 'package:panelway_mobile/data/payloads/requests/register_request.dart';
import 'package:panelway_mobile/features/account/screens/account_information.dart';
import 'package:panelway_mobile/features/account/screens/account_setting.dart';
import 'package:panelway_mobile/features/auth/screen/forgetpassword_screen.dart';
import 'package:panelway_mobile/features/auth/screen/login_screen.dart';
import 'package:panelway_mobile/features/auth/screen/otp-screen.dart';
import 'package:panelway_mobile/features/auth/screen/signup_screen.dart';
import 'package:panelway_mobile/features/booking/rent_client/upload_ad_content.dart';
import 'package:panelway_mobile/features/booking/space_provider/create_space_provider.dart';
import 'package:panelway_mobile/features/home/screen/ac_booking.dart';
import 'package:panelway_mobile/features/home/screen/ac_home_main.dart';
import 'package:panelway_mobile/features/home/screen/ac_location_detail.dart';
import 'package:panelway_mobile/features/home/screen/ac_map_screen.dart';
import 'package:panelway_mobile/features/notification/screen/notification_list_screen.dart';
import 'package:panelway_mobile/features/history/screen/history.dart';
import 'package:panelway_mobile/features/payment/screens/payment.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String signup = '/sign-up';
  static const String forgetPassword = '/forget-password';
  static const String otp = "/otp";
  static const String reset = "/reset-password";
  static const String acHomeMain = '/ac-home-main';
  static const String acMap = '/ac-map';
  static const String acLocationDetail = '/ac-location-detail';
  static const String notification = '/notification';
  static const String acBookingAppointment = '/booking-appointment';
  static const String eWallet = '/e-wallet';
  static const String accountSetting = "/account-setting";
  static const String accountInformation = "/account-information";
  static const String bottombar = "/bottom-bar";
  static const String uploadContent = "/upload-ad-content";
  static const String uploadSpace = "/upload-space";
  static const String history = "/history";
  static const String qrPayment = "/payment";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case forgetPassword:
        return MaterialPageRoute(builder: (_) => ForgetPassword());
      case otp:
        final RegisterRequest? registerRequest =
            settings.arguments as RegisterRequest;
        return MaterialPageRoute(
            builder: (_) => OTPScreen(
                  request: registerRequest,
                ));
      case acHomeMain:
        return MaterialPageRoute(
            builder: (_) => ACHomeMain(
                  bottomBarIndex: 1,
                ));
      case notification:
        return MaterialPageRoute(builder: (_) => NotificationListScreen());
      case acMap:
        return MaterialPageRoute(builder: (_) => MapScreen());
      case acLocationDetail:
        final String? rentalLocationId = settings.arguments as String?;
        return MaterialPageRoute(
            builder: (_) =>
                ACLocationDetail(rentalLocationId: rentalLocationId));
      case acBookingAppointment:
        return MaterialPageRoute(builder: (_) => DateTimePickerScreen());
      case accountSetting:
        return MaterialPageRoute(builder: (_) => AccountSetting());
      case accountInformation:
        return MaterialPageRoute(builder: (_) => AccountInformation());
      case uploadContent:
        return MaterialPageRoute(builder: (_) => UploadAdContent());
      case uploadSpace:
        return MaterialPageRoute(builder: (_) => UploadSpaceInformation());
      case history:
        return MaterialPageRoute(builder: (_) => UserHistory());
      case bottombar:
        final int previousPage = settings.arguments as int? ?? 0;
        return MaterialPageRoute(
            builder: (cont) => BottomBarWidget(
                  pageIndex: previousPage,
                ));
      case qrPayment:
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        final String qrCode = args['qrCode'] ?? "";
        final String subscriptionId = args['subscriptionId'] ?? "";
        return MaterialPageRoute(
            builder: (_) => QRCodeScreen(
                  qrCodeData: qrCode,
                  subscriptionId: subscriptionId,
                ));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
