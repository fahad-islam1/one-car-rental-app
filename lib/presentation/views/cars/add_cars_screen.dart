import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:one_car_rental_app/presentation/components/home/bottm_btn.dart';
import 'package:one_car_rental_app/presentation/viewmodel/cars/add_cars_view_model.dart';
import 'package:one_car_rental_app/res/colors/colors.dart';
import 'package:one_car_rental_app/data/model/car_model.dart';
import 'package:one_car_rental_app/res/utils/cars.dart';

class AddCarsScreen extends StatelessWidget {
  const AddCarsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddCarsViewModel controller = Get.put(AddCarsViewModel());
    final PageController pageController = PageController();

    return Scaffold(
      backgroundColor: primaryColors,
      body: Column(
        children: [
          const SizedBox(height: 50),
          Obx(() => Center(
                child: Text(
                  'Step ${controller.currentPage.value + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              )),
          const SizedBox(height: 20),
          Obx(() => Container(
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: LinearProgressIndicator(
                    minHeight: 20,
                    value: (controller.currentPage.value + 1) / 4,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                ),
              )),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                if (controller.currentPage.value > 0) {
                  controller.setCurrentPage(controller.currentPage.value - 1);
                  pageController.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                }
              },
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(17),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: const Icon(Icons.arrow_back),
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (index) {
                controller.setCurrentPage(index);
              },
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (index == 0) ...[
                          Obx(() {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Search your brand',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Search Car Model or Category',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.0,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 12.0,
                                        horizontal: 16.0,
                                      ),
                                      suffixIcon: const Icon(Icons.search),
                                    ),
                                    onChanged: (value) {
                                      controller.search(value);
                                    },
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 200,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: controller.filteredCars.length,
                                      itemBuilder: (context, carIndex) {
                                        Car car =
                                            controller.filteredCars[carIndex];
                                        return GestureDetector(
                                          onTap: () {
                                            controller.selectCar(car);
                                            controller.setCurrentPage(1);
                                            pageController.animateToPage(
                                              1,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.ease,
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  car.imageUrl,
                                                  width: 120,
                                                  height: 120,
                                                  fit: BoxFit.cover,
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  car.name,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  car.category,
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ] else if (index == 1) ...[
                          ListTile(
                            leading: Image.asset(
                              controller.selectedCar.value.imageUrl,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              'Selected Car: ${controller.selectedCar.value.name}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Divider(),
                          const Text(
                            'Select Car Color',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 12,
                              itemBuilder: (context, colorIndex) {
                                Color color = getColorByIndex(colorIndex);
                                String colorName = getColorName(color);
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.selectColor(color);
                                          controller.setCurrentPage(2);
                                          pageController.animateToPage(
                                            2,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.ease,
                                          );
                                        },
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: color,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        colorName,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ] else if (index == 2) ...[
                          const SizedBox(height: 10),
                          ListTile(
                            leading: Image.asset(
                              controller.selectedCar.value.imageUrl,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              'Selected Car: ${controller.selectedCar.value.name}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Color: ${getColorName(controller.selectedColor.value)}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          const Divider(),
                          const Text(
                            'Choose Your City',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Obx(() => DropdownButton<String>(
                                value: controller.selectedCity.value,
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    controller.setSelectedCity(newValue);
                                  }
                                },
                                items: controller.cities
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )),
                          const Divider(),
                          const Text(
                            'Choose Alphabet',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Obx(() => DropdownButton<String>(
                                value: controller.selectedAlphabet.value,
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    controller.setSelectedAlphabet(newValue);
                                  }
                                },
                                items: controller.alphabets
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )),
                          const Divider(),
                          const Text(
                            'Enter Number Plate',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .03),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Number Plate',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 16.0,
                              ),
                            ),
                            onChanged: (value) {
                              controller.setNumberPlate(value);
                            },
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .06),
                          Obx(() {
                            if (controller.isFormComplete) {
                              return InkWell(
                                onTap: () {
                                  controller.setCurrentPage(3);
                                  pageController.animateToPage(
                                    3,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  );

                                  controller.uploadAssetImage();
                                },
                                child: CommonButton(title: 'Next', width: 400),
                              );
                            } else {
                              return Container();
                            }
                          }),
                        ] else if (index == 3) ...[
                          const Divider(),
                          const Text(
                            'Confirmation',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Selected Car: ${controller.selectedCar.value.name}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Image.asset(
                                  controller.selectedCar.value.imageUrl,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Color: ${getColorName(controller.selectedColor.value)}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'City: ${controller.selectedCity.value}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Alphabet: ${controller.selectedAlphabet.value}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Number Plate: ${controller.numberPlate.value}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Divider(),
                                Text(
                                  'Transmission Type',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Row(
                                  children: [
                                    Text('Automatic'),
                                    Switch(
                                      value: controller.isAutomatic.value,
                                      onChanged: (value) {
                                        controller.setTransmissionType(value);
                                      },
                                    ),
                                    Text('Manual'),
                                  ],
                                ),
                                Divider(),
                                Text(
                                  'Do You have Comprehensive insurance ?',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Row(
                                  children: [
                                    Text('Yes'),
                                    Switch(
                                      value: controller.hasInsurance.value,
                                      onChanged: (value) {
                                        controller.setInsurance(value);
                                      },
                                    ),
                                    Text('No'),
                                  ],
                                ),
                                SizedBox(height: 12),
                                InkWell(
                                  onTap: () {
                                    controller.addCarToFirestore();
                                  },
                                  child: CommonButton(
                                      isLoading: controller.isLoading.value,
                                      title: 'Submit',
                                      width: 400),
                                ),
                              ],
                            ),
                          )
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
