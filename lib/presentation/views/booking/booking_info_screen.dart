import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:one_car_rental_app/presentation/components/common/common_text.dart';

import 'package:one_car_rental_app/presentation/viewmodel/booking/booking_viewmodel.dart';
import 'package:one_car_rental_app/presentation/viewmodel/home/choose_service_viewmodel.dart';
import 'package:one_car_rental_app/res/colors/colors.dart';

class BookingInformation extends StatelessWidget {
  final String? pickupAddress;
  final String? dropoffAddress;
  final String? bookingTime;

  const BookingInformation({
    Key? key,
    required this.pickupAddress,
    required this.dropoffAddress,
    required this.bookingTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BookingInformationViewModel viewModel =
        Get.put(BookingInformationViewModel());
    final ChooseServiceViewmodel chooseServiceController =
        Get.put(ChooseServiceViewmodel());
    chooseServiceController.setInitialLocations(pickupAddress, dropoffAddress);

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
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Booking Information',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              bookingTime!.substring(8),
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.error,
                              color: Colors.grey.shade400,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Additional time will be charged on 0.63 AED per minute',
                              style:
                                  TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                            RichText(
                              text: const TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: 'AED ',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text: '220',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          viewModel.onTapCarDetails();
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.car_rental),
                            Obx(() {
                              return Text(
                                viewModel.selectedCar.value?.carName ??
                                    'Choose Car',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.05),
                            const Icon(CupertinoIcons.right_chevron),
                          ],
                        ),
                      ),
                      const Divider(),
                      Row(
                        children: [
                          const Icon(Icons.car_rental),
                          const Text('Google pay',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(width: size.width * 0.05),
                          const Icon(CupertinoIcons.right_chevron),
                        ],
                      ),
                      const Divider(),
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                    text: 'Promo Code',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18)),
                                const Icon(CupertinoIcons.right_chevron),
                              ],
                            ),
                            CustomText(
                                text: 'Optional',
                                style: TextStyle(color: grey, fontSize: 16)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                    text: 'Add Note',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18)),
                                const Icon(CupertinoIcons.right_chevron),
                              ],
                            ),
                            CustomText(
                                text: 'Optional',
                                style: TextStyle(color: grey, fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 0.5,
                  color: Colors.grey.shade300,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Divider(
                        thickness: 1,
                        color: Colors.grey.shade300,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: primaryColors,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Center(
                              child: CustomText(
                                  text: 'Next',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
