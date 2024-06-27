import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:one_car_rental_app/data/services/sharedpreference/shared_pref_service.dart';
import 'package:one_car_rental_app/firebase_options.dart';
import 'package:one_car_rental_app/presentation/views/auth/login_screen.dart';
import 'package:one_car_rental_app/presentation/views/home/bottom_nav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'One Car Rental App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(backgroundColor: Colors.white),
        // Define your app's theme here
        primarySwatch: Colors.blue,
      ),

      // Check if user is logged in and show appropriate screen
      home: FutureBuilder<bool>(
        future: SharedPrefService.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Or loading screen
          } else {
            bool isLoggedIn = snapshot.data ?? false;
            return isLoggedIn ? BottomNavHome() : LoginScreen();
          }
        },
      ),
    );
  }
}
