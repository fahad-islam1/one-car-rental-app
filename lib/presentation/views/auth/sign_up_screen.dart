import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_car_rental_app/presentation/components/common/common_textfield.dart';
import 'package:one_car_rental_app/presentation/components/home/bottm_btn.dart';
import 'package:one_car_rental_app/presentation/viewmodel/auth/auth__view_model.dart';

class SignUpScreen extends StatelessWidget {
  final String phoneNumber;

  SignUpScreen({Key? key, required this.phoneNumber}) : super(key: key);

  final AuthViewModel authViewModel = Get.find<AuthViewModel>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final RxBool _firstNameValid = true.obs;
  final RxBool _lastNameValid = true.obs;
  final RxBool _emailValid = true.obs;
  final RxBool _phoneNumberValid = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up', style: TextStyle(fontSize: 18)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logo2.png', // Replace with your logo path
                  height: 100.0,
                ),
              ),
              const SizedBox(height: 20),
              buildFieldLabel('First Name'),
              const SizedBox(height: 8),
              buildTextField(
                labelText: 'First Name',
                controller: _firstNameController,
                isValid: _firstNameValid.value,
                onChanged: (value) {
                  _firstNameValid.value = value.isNotEmpty;
                },
              ),
              const SizedBox(height: 12),
              buildFieldLabel('Last Name'),
              const SizedBox(height: 8),
              buildTextField(
                labelText: 'Last Name',
                controller: _lastNameController,
                isValid: _lastNameValid.value,
                onChanged: (value) {
                  _lastNameValid.value = value.isNotEmpty;
                },
              ),
              const SizedBox(height: 12),
              buildFieldLabel('Email'),
              const SizedBox(height: 8),
              buildTextField(
                labelText: 'Email',
                controller: _emailController,
                isValid: _emailValid.value,
                onChanged: (value) {
                  _emailValid.value = value.isNotEmpty;
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: InkWell(
                  onTap: () {
                    _firstNameValid.value =
                        _firstNameController.text.isNotEmpty;
                    _lastNameValid.value = _lastNameController.text.isNotEmpty;
                    _emailValid.value = _emailController.text.isNotEmpty;

                    if (_firstNameValid.value &&
                        _lastNameValid.value &&
                        _emailValid.value &&
                        _phoneNumberValid.value) {
                      // Call signUp method from AuthViewModel
                      authViewModel.signUp(
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          email: _emailController.text,
                          phoneNumber: phoneNumber);
                    } else {
                      print('error');
                    }
                  },
                  child: BottmBtn(
                    title: 'Submit',
                    width: 200,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
