import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:one_car_rental_app/data/model/car_model.dart';
import 'package:one_car_rental_app/data/model/add_car_details_model.dart';
import 'package:one_car_rental_app/data/services/firebase/addcars.db.dart';
import 'package:one_car_rental_app/data/services/firebase/firestorage_service.dart';
import 'package:one_car_rental_app/res/utils/cars.dart';
import 'package:one_car_rental_app/res/utils/snackbarmsg.dart';

class AddCarsViewModel extends GetxController {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  var searchText = ''.obs;
  var carBrands =
      List<String>.generate(10, (index) => 'Car Brand ${index + 1}').obs;
  var currentPage = 0.obs;
  var cities = [
    'Dubai',
    'Abu Dhabi',
    'Ajman',
    'Fujairah',
    'Ras Al Khaimah',
    'Sharjah',
    'Umm Al Quwain',
    'Others',
  ].obs;
  var alphabets =
      List<String>.generate(26, (index) => String.fromCharCode(65 + index)).obs;
  var selectedCity = 'Dubai'.obs;
  var selectedAlphabet = 'A'.obs;
  var selectedCar = Car(
    category: '',
    imageUrl: '',
    name: '',
  ).obs;
  var selectedColor = Colors.transparent.obs;
  var numberPlate = ''.obs;
  var filteredCars = <Car>[].obs;
  var isAutomatic = false.obs;
  var hasInsurance = false.obs;
  var downloadurls = ''.obs;
  final AddCarDetailsFireStore _addCarDetailsFirestore =
      AddCarDetailsFireStore();

  var userCars = <AddCarDetails>[].obs;

  // Loading state
  var isLoading = false.obs;

  void search(String query) {
    searchText.value = query;
    if (query.isEmpty) {
      filteredCars.assignAll(cars);
    } else {
      filteredCars.assignAll(cars.where((car) {
        return car.name.toLowerCase().contains(query.toLowerCase()) ||
            car.category.toLowerCase().contains(query.toLowerCase());
      }).toList());
    }
  }

  void setCurrentPage(int index) {
    currentPage.value = index;
  }

  void setSelectedCity(String city) {
    selectedCity.value = city;
  }

  void setSelectedAlphabet(String alphabet) {
    selectedAlphabet.value = alphabet;
  }

  void setNumberPlate(String plate) {
    numberPlate.value = plate;
  }

  void selectCar(Car car) {
    selectedCar.value = car;
  }

  void selectColor(Color color) {
    selectedColor.value = color;
  }

  void setTransmissionType(bool isAutomatic) {
    this.isAutomatic.value = isAutomatic;
  }

  void setInsurance(bool hasInsurance) {
    this.hasInsurance.value = hasInsurance;
  }

  bool get isFormComplete {
    return selectedCar.value.name.isNotEmpty &&
        selectedColor.value != Colors.transparent &&
        selectedCity.value.isNotEmpty &&
        selectedAlphabet.value.isNotEmpty &&
        numberPlate.value.isNotEmpty;
  }

  Future<void> uploadAssetImage() async {
    // Read the image file from assets
    ByteData imageData = await rootBundle.load(
      selectedCar.value.imageUrl,
    );
    Uint8List imageBytes = imageData.buffer.asUint8List();

    // Create a reference to the Firebase Storage path
    var ref = firebaseStorage
        .ref()
        .child('images')
        .child('car_image.png'); // Customize the path as per your requirement

    // Upload the file to Firebase Storage
    await ref.putData(imageBytes);

    // Get the download URL of the uploaded file
    String downloadURL = await ref.getDownloadURL();
    downloadurls.value = downloadURL;
    print('Uploaded image URL: ${downloadurls.value}');
    // print('Uploaded image URL: $downloadURL');
  }

  void addCarToFirestore() async {
    if (isFormComplete) {
      isLoading.value = true;
      uploadAssetImage();
      AddCarDetails carDetails = AddCarDetails(
        carName: selectedCar.value.name,
        carImage: downloadurls.value,
        carCategory: selectedCar.value.category,
        color: selectedColor.value.toString(),
        numberPlate: numberPlate.value,
        alphabet: selectedAlphabet.value,
        city: selectedCity.value,
        transmissionType: isAutomatic.value ? 'Automatic' : 'Manual',
        hasInsurance: hasInsurance.value ? 'Yes' : 'No',
      );

      await _addCarDetailsFirestore.addCarDetails(carDetails);

      userCars.add(carDetails);

      clearForm();

      isLoading.value = false;

      Get.back();
    } else {
      Message.showSuccess('Error', 'Please fill all required fields.');
      print('Please fill all required fields.');
    }
  }

  void clearForm() {
    selectedCar.value = Car(category: '', imageUrl: '', name: '');
    selectedColor.value = Colors.transparent;
    numberPlate.value = '';
    selectedCity.value = 'Dubai';
    selectedAlphabet.value = 'A';
    isAutomatic.value = false;
    hasInsurance.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    filteredCars.assignAll(cars);
  }
}
