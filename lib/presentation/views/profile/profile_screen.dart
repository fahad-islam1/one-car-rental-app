import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_car_rental_app/presentation/components/common/common_text.dart';
import 'package:one_car_rental_app/presentation/viewmodel/profilemodel/profile_view_model.dart';
import 'package:one_car_rental_app/presentation/views/profile/edit_screen.dart';
import 'package:one_car_rental_app/presentation/views/profile/help_screen.dart';
import 'package:one_car_rental_app/presentation/views/profile/payment_method_screen.dart';
import 'package:one_car_rental_app/presentation/views/profile/privacy_policy_screen.dart';
import 'package:one_car_rental_app/presentation/views/profile/term_and_conditon_screem.dart';
import 'package:one_car_rental_app/presentation/views/reward/refer_earn_screen.dart';
import 'package:one_car_rental_app/presentation/views/profile/saved_location.dart';
import 'package:one_car_rental_app/res/colors/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final ProfileViewModel profileController = Get.put(ProfileViewModel());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<Map<String, dynamic>?>(
            stream: profileController.firestoreService
                .getUserDataStream(profileController.phonenumber),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final userData = snapshot.data ?? {};
              final String imageUrl = userData['imageUrl'] ?? '';
              final bool hasImage = imageUrl.isNotEmpty;

              return Column(
                children: [
                  ListTile(
                    title: CustomText(
                      text: userData['firstName'] ?? 'User',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: hasImage
                          ? NetworkImage(imageUrl)
                          : AssetImage('assets/images/avatar.png')
                              as ImageProvider,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_outlined),
                    subtitle: CustomText(
                      text: 'Tap to edit profile',
                      style: TextStyle(color: grey),
                    ),
                    onTap: () {
                      Get.to(() => EditProfileScreen(userData: userData),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 790));
                    },
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  ListTile(
                    title: const CustomText(
                      text: 'Payment Method',
                    ),
                    onTap: () {
                      Get.to(() => const PAymentMethods(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 790));
                    },
                    trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    onTap: () {
                      Get.to(() => const SavedLocationScreen(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 790));
                    },
                    title: const CustomText(
                      text: 'Saved Locations',
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    title: const CustomText(
                      text: 'Help',
                    ),
                    onTap: () {
                      Get.to(() => const HelpScreen(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 790));
                    },
                    trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    title: const CustomText(
                      text: 'Terms & Conditions',
                    ),
                    onTap: () {
                      Get.to(() => const TermAndConditonScreem(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 790));
                    },
                    trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    onTap: () {
                      Get.to(() => const PrivacyPolicyScreen(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 790));
                    },
                    title: const CustomText(
                      text: 'Privacy & Policy',
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    title: const CustomText(
                      text: 'Refer & Earn',
                    ),
                    onTap: () {
                      Get.to(() => const ReferAndEarnScreen(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 790));
                    },
                    trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    title: CustomText(
                      text: 'Logout',
                    ),
                    onTap: () {
                      profileController.logout();
                    },
                    trailing: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
