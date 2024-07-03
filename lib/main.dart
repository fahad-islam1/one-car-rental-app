import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:one_car_rental_app/data/services/sharedpreference/shared_pref_service.dart';
import 'package:one_car_rental_app/firebase_options.dart';
import 'package:one_car_rental_app/presentation/views/auth/login_screen.dart';
import 'package:one_car_rental_app/presentation/views/chat/chat_screen.dart';
import 'package:one_car_rental_app/presentation/views/home/bottom_nav.dart';
import 'package:one_car_rental_app/presentation/viewmodel/profilemodel/profile_view_model.dart';
import 'package:one_car_rental_app/presentation/views/ride/ride_details_screen.dart';

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
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
        future: SharedPrefService.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            bool isLoggedIn = snapshot.data ?? false;
            if (isLoggedIn) {
              return FutureBuilder<String?>(
                future: SharedPrefService.getPhoneNumber(),
                builder: (context, phoneSnapshot) {
                  if (phoneSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    String? phoneNumber = phoneSnapshot.data;
                    if (phoneNumber != null) {
                      final ProfileViewModel profileController =
                          Get.put(ProfileViewModel());
                      profileController.phonenumber = phoneNumber;
                      profileController.firestoreService
                          .getUserDataStream(profileController.phonenumber);
                    }
                    return BottomNavHome();
                  }
                },
              );
            } else {
              return const LoginScreen();
            }
          }
        },
      ),
    );
  }
}
