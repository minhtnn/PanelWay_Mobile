import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/app/app_routes.dart';
import 'package:panelway_mobile/features/auth/view_models/auth_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:panelway_mobile/features/payment/payment.dart';

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
      home: QRCodeScreen(qrCodeData: "00020101021238590010A000000727012900069704180115V3CAS62202836280208QRIBFTTA53037045405200005802VN62220818CSCKXFX4XW6 string6304A086",),
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
