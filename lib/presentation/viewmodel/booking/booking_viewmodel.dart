import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_car_rental_app/data/model/add_car_details_model.dart';
import 'package:one_car_rental_app/data/services/firebase/addcars.db.dart';
import 'package:one_car_rental_app/presentation/views/cars/add_cars_screen.dart';
import 'package:one_car_rental_app/presentation/views/cars/yours_cars.dart';

class BookingInformationViewModel extends GetxController {
  var isHourlyBooking = true.obs;
  var selectedCar = Rx<AddCarDetails?>(null); // Reactive variable for selected car

  void toggleBookingType() {
    isHourlyBooking.value = !isHourlyBooking.value;
  }

  void onTapCarDetails() async {
    // Check if car is added
    bool carAdded = await checkIfCarAdded();
    if (carAdded) {
      // Car is added, navigate to YourCarsScreen
      navigateToYourCarsScreen();
    } else {
      // Show alert message and add button
      showAddCarAlertDialog();
    }
  }

  Future<bool> checkIfCarAdded() async {
    // Check if user has added cars
    var userCars = await Get.put(AddCarDetailsFireStore()).getUserCars();
    return userCars.isNotEmpty;
  }

  void showAddCarAlertDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('No Cars Added'),
        content: Text('Please add a car to continue booking.'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.to(() => AddCarsScreen(),
                  transition: Transition.rightToLeft,
                  duration: const Duration(milliseconds: 790));
            },
            child: Text('Add Car'),
          ),
        ],
      ),
    );
  }

  void navigateToYourCarsScreen() {
    Get.to(() => YourCarScreen(canSelectCar: true),
            transition: Transition.rightToLeft,
            duration: const Duration(milliseconds: 790))!
        .then((selectedCar) {
      if (selectedCar != null) {
        handleSelectedCar(selectedCar);
      }
    });
  }

  void handleSelectedCar(AddCarDetails selectedCar) {
    this.selectedCar.value = selectedCar; // Store the selected car in the reactive variable
  }
}
