import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/app/app_routes.dart';
import 'package:panelway_mobile/core/widgets/bottom_bar.dart';
import 'package:panelway_mobile/data/repositories/rentalLocationImageRepository.dart';
import 'package:panelway_mobile/data/repositories/rentalLocationRepository.dart';
import 'package:panelway_mobile/data/repositories/subcriptionRepository.dart';
import 'package:panelway_mobile/data/services/api_service.dart';
import 'package:panelway_mobile/features/auth/screen/login_screen.dart';
import 'package:panelway_mobile/features/home/view_models/rental_location_viewmodel.dart';
import 'package:panelway_mobile/features/home/view_models/retal_location_detail_viewmodel.dart';
import 'package:panelway_mobile/features/package_plan/view_model/subcription_view_model.dart';
import 'package:provider/provider.dart';
import 'package:panelway_mobile/data/repositories/authenticationRepository.dart';
import 'package:panelway_mobile/data/services/storage_service.dart';
import 'package:panelway_mobile/features/auth/view_models/auth_viewmodel.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final apiService = ApiService(navigatorKey);
  final storageService = StorageService();
  runApp(
    MultiProvider(
      providers: [
        Provider<ApiService>.value(value: apiService),
        Provider<StorageService>.value(value: storageService),
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(
            authRepository:
                AuthenticationRepository(apiService), // Use the same instance
            storageService: storageService
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RentalLocationViewmodel(
              rentalLocationRepository: RentalLocationRepository(apiService),
              rentalLocationImageRepository:
                  RentalLocationImageRepository(apiService)),
        ),
        ChangeNotifierProvider(
          create: (context) => RetalLocationDetailViewmodel(
              rentalLocationRepository: RentalLocationRepository(apiService),
              rentalLocationImageRepository:
                  RentalLocationImageRepository(apiService)),
        ),
        ChangeNotifierProvider(
          create: (context) => SubcriptionViewModel(
              subcriptionrepository: Subcriptionrepository(apiService)),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthViewModel>(context, listen: false).checkLoginStatus();
    });
    return MaterialApp(
      navigatorKey: navigatorKey,
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
              color: Colors.white, shadowColor: Palette.shadowForButton)),
      home: AuthWrapper(),
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}

class AuthWrapper extends StatefulWidget {
  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    super.initState();
    // Check stored credentials on app start
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthViewModel>().checkLoginStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, authVM, _) {
        // Show loading indicator while checking login status
        if (authVM.isInitializing) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // If logged in, show HomeView, otherwise show LoginView
        return authVM.isLoggedIn ? BottomBarWidget() : LoginScreen();
      },
    );
  }
}
