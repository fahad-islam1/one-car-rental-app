import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:one_car_rental_app/presentation/components/home/bottm_btn.dart';
import 'package:one_car_rental_app/presentation/viewmodel/auth/auth__view_model.dart';
import 'package:one_car_rental_app/presentation/viewmodel/profilemodel/profile_view_model.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String phonenumber;

  OtpVerificationScreen({
    super.key,
    required this.phonenumber,
  });

  final AuthViewModel authController = Get.put(AuthViewModel());

  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Verify OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/logo2.png',
                height: 100.0,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(6, (index) => buildOtpField(index)),
            ),
            const SizedBox(height: 20),
            Center(
              child: InkWell(
                onTap: () {
                  authController.verifyOtp(phonenumber);
      
                },
                child: Obx(
                  () => BottmBtn(
                    isLoading: authController.isLoading.value,
                    title: 'Verify OTP',
                    width: 200,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOtpField(int index) {
    return SizedBox(
      width: 50,
      child: TextField(
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        onChanged: (value) {
          authController.otp[index] = value;
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(Get.context!).requestFocus(_focusNodes[index + 1]);
          }
        },
        decoration: const InputDecoration(
          counter: Offstage(),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
