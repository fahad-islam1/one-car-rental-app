import 'package:get/get.dart';

class YourTripViewModel extends GetxController {
  // Reactive variable to store the selected value
  var selectedValue = 'Past Active'.obs;

  // Method to update the selected value
  void updateSelectedValue(String? newValue) {
    selectedValue.value = newValue!;
  }
}
