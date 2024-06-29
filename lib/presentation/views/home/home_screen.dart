import 'package:one_car_rental_app/presentation/components/home/bottm_btn.dart';
import 'package:one_car_rental_app/presentation/components/home/custom_service.dart';
import 'package:one_car_rental_app/presentation/components/home/home_slider.dart';
import 'package:one_car_rental_app/presentation/viewmodel/profilemodel/profile_view_model.dart';
import 'package:one_car_rental_app/presentation/views/home/car_delivery_service_screen.dart';
import 'package:one_car_rental_app/presentation/views/home/car_services1_screen.dart';
import 'package:flutter/material.dart';
import 'package:one_car_rental_app/presentation/components/common/common_text.dart';
import 'package:one_car_rental_app/presentation/views/profile/profile_screen.dart';
import 'package:one_car_rental_app/res/colors/colors.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white.withOpacity(.92),
      appBar: AppBar(
        actions: [
          Image(
            image: AssetImage('assets/images/logo2.png'),
            width: 100,
            height: 80,
            fit: BoxFit.cover,
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        // title: GetBuilder<ProfileViewModel>(
        //   builder: (profileController) => GestureDetector(
        //     onTap: () {
        //       Get.to(() => ProfileScreen());
        //     },
        //     child: Row(
        //       children: [
        //         // CircleAvatar(
        //         //   radius: 20,
        //         //   backgroundImage: profileController.userData != null &&
        //         //           profileController.userData['imageUrl'].isNotEmpty
        //         //       ? NetworkImage(profileController.userData['imageUrl'])
        //         //       : AssetImage('assets/images/avatar.png'),
        //         // ),
        //         // SizedBox(width: 8),
        //         CustomText(
        //           text: profileController.userData['firstName'] ?? 'User',
        //           style: Theme.of(context).textTheme.bodyLarge,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: 'Choose a Service',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  Get.to(
                    () => CarServices1Screen(),
                    transition: Transition.rightToLeft,
                    duration: Duration(milliseconds: 790),
                  );
                },
                child: const ChooseServiceWidget(
                  title: 'Personal Chauffer',
                  subtitle: 'Pay-Per-Minute | Hourly Booking',
                  btnTitle: 'Book | Schedule ',
                  image: 'assets/icons/policeman.png',
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.to(
                    () => CarDeliveryService(),
                    transition: Transition.rightToLeft,
                    duration: Duration(milliseconds: 790),
                  );
                },
                child: const ChooseServiceWidget(
                  title: 'Garage Pick up / Drop',
                  subtitle: 'Fixed fare of AED 59',
                  btnTitle: 'Book | Schedule ',
                  image: 'assets/icons/carservice.png',
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.to(
                    () => CarDeliveryService(),
                    transition: Transition.rightToLeft,
                    duration: Duration(milliseconds: 790),
                  );
                },
                child: const ChooseServiceWidget(
                  title: 'RTA Vehicle Inspection',
                  subtitle: 'Fixed fare of AED 69',
                  btnTitle: 'Book | Schedule ',
                  image: 'assets/icons/icon2.png',
                ),
              ),
              const SizedBox(height: 20),
              CommonButton(
                title: 'Car For Rent',
                width: 130,
              ),
              const CustomText(
                text: 'Did you know you can use One Car Rental for ?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ImageSlider(),
            ],
          ),
        ),
      ),
    );
  }
}
