// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:one_car_rental_app/presentation/viewmodel/booking/booking_viewmodel.dart';

import 'package:one_car_rental_app/presentation/viewmodel/home/choose_service_viewmodel.dart';

class LookingCarRent extends StatelessWidget {
  final String? pickupAddress;
  final String? dropoffAddress;
  final String? bookingTime;
  final selectedCar;
  const LookingCarRent({
    Key? key,
    required this.pickupAddress,
    required this.dropoffAddress,
    required this.bookingTime,
    this.selectedCar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChooseServiceViewmodel chooseServiceController =
        Get.put(ChooseServiceViewmodel());
    chooseServiceController.setInitialLocations(pickupAddress, dropoffAddress);
    final BookingInformationViewModel viewModel =
        Get.put(BookingInformationViewModel());
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Obx(() {
                  return GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(31.5497, 74.3436),
                      tilt: 5,
                      zoom: 7,
                    ),
                    markers: chooseServiceController.markers,
                    polylines: chooseServiceController.polylines,
                    onMapCreated: (GoogleMapController controller) {
                      chooseServiceController.controller.complete(controller);
                    },
                  );
                }),
                Positioned(
                  top: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (pickupAddress != null)
                          Text(
                            'Pickup: $pickupAddress',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        if (dropoffAddress != null)
                          Text(
                            'Dropoff: $dropoffAddress',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        Obx(() {
                          if (chooseServiceController.distance > 0) {
                            return Text(
                              'Distance: ${chooseServiceController.distance.toStringAsFixed(2)} km',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            );
                          } else {
                            return Container();
                          }
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                const Text('Looking for Car'),
                SizedBox(
                  height: size.height * 0.01,
                ),
                InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.person_outline,
                      size: 70,
                    )),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(bookingTime!),
                SizedBox(
                  height: size.height * 0.01,
                ),
                const Text(
                  'AED 418',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                // Image.network(viewModel.selectedCar.value!.carImage),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  viewModel.selectedCar.value?.carName ?? 'Car',
                ),

                Text(
                  "Owner's Comprehensive insurance: ${viewModel.selectedCar.value?.hasInsurance}",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                const Icon(Icons.settings),
                SizedBox(
                  height: size.height * 0.01,
                ),
                const Text('Cash'),
                SizedBox(
                  height: size.height * 0.02,
                ),

                InkWell(
                  onTap: () {
                    viewModel.selectedCar.value?.color;
                  },
                  child: Container(
                    height: 40,
                    width: 310,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black),
                    ),
                    child: const Center(
                        child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black),
                    )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
