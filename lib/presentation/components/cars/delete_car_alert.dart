import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_car_rental_app/data/model/add_car_details_model.dart';
import 'package:one_car_rental_app/data/services/firebase/addcars.db.dart';
import 'package:one_car_rental_app/res/colors/colors.dart';

void showDeleteConfirmationDialog(BuildContext context, AddCarDetails car,
    AddCarDetailsFireStore addCarDetailsFirestore) {
  Get.dialog(
    AlertDialog(
      backgroundColor: white,
      title: Text('Delete Car'),
      content: Text('Are you sure you want to delete this car?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('No'),
        ),
        TextButton(
          onPressed: () async {
            if (car.carId != null) {
              Get.back();

              await addCarDetailsFirestore.deleteCar(car.carId!).then((val) {});
            }
          },
          child: Text('Yes'),
        ),
      ],
    ),
  );
}
