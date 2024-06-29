import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:one_car_rental_app/presentation/components/home/bottm_btn.dart';
import 'package:one_car_rental_app/presentation/viewmodel/auth/auth__view_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthViewModel authController = Get.put(AuthViewModel());

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logo2.png',
                  height: 100.0,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Please enter your number',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              IntlPhoneField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                initialCountryCode: 'AE',
                onChanged: (phone) {
                  authController.countryCode.value = phone.countryCode;
                  authController.numberController.text = phone.number;
                },
                onCountryChanged: (country) {
                  authController.countryCode.value = country.dialCode;
                  print('Selected country code: ${country.dialCode}');
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: InkWell(
                  onTap: () {
                    authController.verifyPhoneNumber(
                      '${authController.countryCode.value}${authController.numberController.text}',
                    );
                  },
                  child: Obx(
                    () => CommonButton(
                      isLoading: authController.isLoading.value,
                      title: 'Login',
                      width: 200.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
