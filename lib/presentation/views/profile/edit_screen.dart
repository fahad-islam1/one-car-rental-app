import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:one_car_rental_app/presentation/components/common/common_text.dart';
import 'package:one_car_rental_app/presentation/viewmodel/profilemodel/profile_view_model.dart';
import 'package:one_car_rental_app/res/colors/colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key, this.userData}) : super(key: key);

  final userData;

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final ProfileViewModel profileViewModel = Get.put(ProfileViewModel());

  String countryCode = '';
  String phoneNumber = '';

  @override
  void initState() {
    super.initState();

    _firstNameController.text = widget.userData['firstName'] ?? '';
    _lastNameController.text = widget.userData['lastName'] ?? '';
    _emailController.text = widget.userData['email'] ?? '';

    String storedPhoneNumber = widget.userData['phoneNumber'] ?? '';
    if (storedPhoneNumber.startsWith('+')) {
      countryCode = storedPhoneNumber.substring(0, 3);
      phoneNumber = storedPhoneNumber.substring(3);
    } else {
      countryCode = '';
      phoneNumber = storedPhoneNumber;
    }

    _phoneNumberController.text = phoneNumber;
    profileViewModel.gender.value = widget.userData['gender'] ?? '';
    profileViewModel.imageUrl.value = widget.userData['imageUrl'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: InkWell(
        onTap: () async {
          await profileViewModel.updateUser(
            _firstNameController.text,
            _lastNameController.text,
            _emailController.text,
            countryCode + _phoneNumberController.text,
          );
        },
        child: Container(
          margin: EdgeInsets.all(10),
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
            color: primaryColors,
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          child: CustomText(
            text: 'Save',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: CustomText(
          text: 'Edit Profile',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Divider(
                thickness: 10,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: <Widget>[
                      Obx(() => Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  profileViewModel.imageUrl.isNotEmpty
                                      ? NetworkImage(
                                          profileViewModel.imageUrl.value)
                                      : AssetImage('assets/images/avatar.png')
                                          as ImageProvider,
                            ),
                          )),
                      Positioned(
                        right: 3,
                        bottom: 10,
                        child: InkWell(
                          onTap: () async {
                            print('object');
                            await profileViewModel.pickImage(phoneNumber);
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: primaryColors,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomText(
                    text: 'First Name',
                    style: TextStyle(fontSize: 15, color: grey),
                  ),
                  TextField(
                    controller: _firstNameController,
                    decoration: InputDecoration(),
                  ),
                  SizedBox(height: 10),
                  CustomText(
                    text: 'Last Name',
                    style: TextStyle(fontSize: 15, color: grey),
                  ),
                  TextField(
                    controller: _lastNameController,
                    decoration: InputDecoration(),
                  ),
                  SizedBox(height: 10),
                  CustomText(
                    text: 'Email',
                    style: TextStyle(fontSize: 15, color: grey),
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(),
                  ),
                  SizedBox(height: 10),
                  CustomText(
                    text: 'Enter Your Number',
                    style: TextStyle(fontSize: 15, color: grey),
                  ),
                  SizedBox(height: 10),
                  IntlPhoneField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                    ),
                    initialCountryCode: '+91',
                    onChanged: (phone) {
                      phoneNumber = phone.completeNumber ?? '';
                    },
                  ),
                  SizedBox(height: 10),
                  CustomText(
                    text: 'Gender',
                    style: TextStyle(fontSize: 15, color: grey),
                  ),
                  SizedBox(height: 10),
                  Obx(() => Row(
                        children: [
                          InkWell(
                            onTap: () {
                              profileViewModel.gender.value = 'Male';
                            },
                            child: Container(
                              height: 45,
                              width: 100,
                              decoration: BoxDecoration(
                                color: profileViewModel.gender.value == 'Male'
                                    ? primaryColors
                                    : Colors.white,
                                border: Border.all(color: primaryColors),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              alignment: Alignment.center,
                              child: CustomText(
                                text: 'Male',
                                style: TextStyle(
                                  fontWeight:
                                      profileViewModel.gender.value == 'Male'
                                          ? FontWeight.w700
                                          : FontWeight.normal,
                                  color: profileViewModel.gender.value == 'Male'
                                      ? Colors.white
                                      : primaryColors,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          InkWell(
                            onTap: () {
                              profileViewModel.gender.value = 'Female';
                            },
                            child: Container(
                              height: 45,
                              width: 100,
                              decoration: BoxDecoration(
                                color: profileViewModel.gender.value == 'Female'
                                    ? primaryColors
                                    : Colors.white,
                                border: Border.all(color: primaryColors),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              alignment: Alignment.center,
                              child: CustomText(
                                text: 'Female',
                                style: TextStyle(
                                  fontWeight:
                                      profileViewModel.gender.value == 'Female'
                                          ? FontWeight.w700
                                          : FontWeight.normal,
                                  color:
                                      profileViewModel.gender.value == 'Female'
                                          ? Colors.white
                                          : primaryColors,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
