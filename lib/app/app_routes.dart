import 'package:flutter/material.dart';
import 'package:panelway_mobile/features/auth/screen/forgetpassword_screen.dart';
import 'package:panelway_mobile/features/auth/screen/login_screen.dart';
import 'package:panelway_mobile/features/auth/screen/otp-screen.dart';
import 'package:panelway_mobile/features/auth/screen/signup_screen.dart';
import 'package:panelway_mobile/features/home/screen/ac_home_main.dart';
import 'package:panelway_mobile/features/home/screen/ac_map_screen.dart';
import 'package:panelway_mobile/features/notification/screen/notification_list_screen.dart';
class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String signup = '/sign-up';
  static const String forgetPassword = '/forget-password';
  static const String otp = "/otp";
  static const String reset = "/reset-password";
  static const String acHomeMain = '/ac-home-main';
  static const String notification = '/notification';
  static const String acMap = '/ac-map';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case forgetPassword:
        return MaterialPageRoute(builder: (_) => ForgetPassword());
      case otp:
        return MaterialPageRoute(builder: (_) => OTPScreen());
      case acHomeMain:
        return MaterialPageRoute(builder: (_) => ACHomeMain());
      case notification:
        return MaterialPageRoute(builder: (_) => NotificationListScreen());
      case acMap:
        return MaterialPageRoute(builder: (_) => MapScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}