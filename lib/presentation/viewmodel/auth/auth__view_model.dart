import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:one_car_rental_app/data/services/firebase/firestore_service.dart';
import 'package:one_car_rental_app/data/services/sharedpreference/shared_pref_service.dart';
import 'package:one_car_rental_app/presentation/viewmodel/profilemodel/profile_view_model.dart';
import 'package:one_car_rental_app/presentation/views/auth/login_screen.dart';
import 'package:one_car_rental_app/presentation/views/auth/otp_veify_screen.dart';
import 'package:one_car_rental_app/presentation/views/auth/sign_up_screen.dart';
import 'package:one_car_rental_app/presentation/views/home/bottom_nav.dart';
import 'package:one_car_rental_app/res/utils/snackbarmsg.dart';

class AuthViewModel extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ProfileViewModel profileController = Get.put(ProfileViewModel());

  final FirestoreService _firestoreService = FirestoreService();
  var isLoading = false.obs;
  String verificationId = '';
  final countryCode = '+971'.obs;
  final numberController = TextEditingController();
  final otp = List<String>.filled(6, '').obs;

  void clearOtp() {
    otp.clear();
    otp.assignAll(List<String>.filled(6, ''));
  }

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    isLoading.value = true;
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          Message.showSuccess('Success', 'Verification completed successfully');
        },
        verificationFailed: (FirebaseAuthException e) {
          Message.showError('Error', 'Verification failed: ${e.message}');
          print('Verification failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId = verificationId;

          Get.to(
            () => OtpVerificationScreen(
              phonenumber: phoneNumber,
            ),
            transition: Transition.leftToRight,
            duration: const Duration(milliseconds: 700),
          );

          print('OTP Sent. Verification ID: $verificationId');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId = verificationId;
          // Message.showError('Error', 'Auto retrieval timeout');
          print('Auto retrieval timeout. Verification ID: $verificationId');
        },
      );
    } catch (e) {
      Message.showError('Error', 'Failed to verify phone number: $e');
      print('Failed to verify phone number: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp(String phoneNumber) async {
    isLoading.value = true;
    try {
      String smsCode = otp.join('');
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      await _auth.signInWithCredential(credential);

      bool isPhoneNumberRegistered =
          await _firestoreService.isPhoneNumberRegistered(phoneNumber);

      if (isPhoneNumberRegistered) {
        await SharedPrefService.saveLoggedIn(true);
        await SharedPrefService.savePhoneNumber(phoneNumber);
        profileController.firestoreService.getUserDataStream(phoneNumber);
        profileController.phonenumber = phoneNumber;
        Get.offAll(
          () => const BottomNavHome(),
          transition: Transition.leftToRight,
          duration: const Duration(milliseconds: 700),
        );
        Message.showSuccess('Success', 'OTP Verified!');
        print('OTP Verified successfully');
      } else {
        Get.to(
          () => SignUpScreen(
            phoneNumber: phoneNumber,
          ),
          transition: Transition.leftToRight,
          duration: const Duration(milliseconds: 700),
        );
      }
    } catch (e) {
      Message.showError('Error', 'Invalid OTP');
      print('Invalid OTP error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
  }) async {
    isLoading.value = true;
    try {
      await _firestoreService.addUser(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
      );

      await SharedPrefService.saveLoggedIn(true);
      await SharedPrefService.savePhoneNumber(phoneNumber);

      profileController.firestoreService.getUserDataStream(phoneNumber);
      profileController.phonenumber = phoneNumber;

      Get.offAll(
        () => const BottomNavHome(),
        transition: Transition.leftToRight,
        duration: const Duration(milliseconds: 700),
      );
      Message.showSuccess('One Car Rental App', 'Login successful');
    } catch (e) {
      Message.showError('Error', 'Failed to sign up: $e');
      print('Failed to sign up: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    isLoading.value = true;
    try {
      await _auth.signOut();
      await SharedPrefService.clearLoggedIn();
      Get.offAll(
        () => const LoginScreen(),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 700),
      );
      Message.showSuccess(
          'Logged out', 'You have been successfully logged out.');
    } catch (e) {
      Message.showError('Error', 'Failed to log out: $e');
      print('Failed to log out: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
