import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/app/app_routes.dart';
import 'package:panelway_mobile/features/auth/screen/login_screen.dart';
import 'package:panelway_mobile/features/auth/view_models/auth_viewmodel.dart';
import 'package:panelway_mobile/features/booking/rent_client/upload_ad_content.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white, // Màu nền trắng cho AppBar
          iconTheme: IconThemeData(color: Colors.black), // Màu icon
          titleTextStyle: TextStyle(
            color: Colors.black, // Màu chữ cho tiêu đề
            fontSize: 20,
          ),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.white,
          shadowColor: Palette.shadowForButton
        )
      ),
      home: LoginScreen(),
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
