// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:one_car_rental_app/presentation/viewmodel/home/choose_service_viewmodel.dart';
import 'package:one_car_rental_app/presentation/views/booking/booking_info_screen.dart';
import 'package:one_car_rental_app/res/colors/colors.dart';

class ChooseSeriviceContainer extends StatelessWidget {
  final String? pickupAddress;
  final String? dropoffAddress;
  const ChooseSeriviceContainer({
    Key? key,
    required this.pickupAddress,
    required this.dropoffAddress,
    required this.size,
    required this.chooseServiceController,
  }) : super(key: key);

  final Size size;
  final ChooseServiceViewmodel chooseServiceController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                chooseServiceController.isSelectedPerMinute.value = true;
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Choose Service Type',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Pay per Minute',
                        style: TextStyle(
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
                        'Care calculated by minutes of your trip',
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'AED ',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                            TextSpan(
                              text: '53 - 59',
                              style: TextStyle(fontWeight: FontWeight.bold),
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
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Hourly Booking (5 Hours)',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.error,
                        color: Colors.grey.shade400,
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      chooseServiceController.isSelectedPerMinute = true.obs;
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Additional time will be charged on 0.63 AED per minute',
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: 'AED ',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: '220',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: chooseServiceController.categoryList.length,
                itemBuilder: (context, index) {
                  chooseServiceController.isSelected.value =
                      chooseServiceController.categoryList[index] ==
                          chooseServiceController.selectedCategoryName.value;
                  return InkWell(
                    onTap: () {
                      chooseServiceController.selectCategory(
                          chooseServiceController.categoryList[index]);
                      chooseServiceController.isSelectedPerMinute = false.obs;
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Obx(
                        () => Container(
                          width: 85,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: chooseServiceController.isSelected.value
                                ? primaryColors
                                : Colors.white,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(color: primaryColors),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  chooseServiceController.categoryList[index],
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color:
                                        chooseServiceController.isSelected.value
                                            ? Colors.white
                                            : primaryColors,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (chooseServiceController.isSelected.value)
                                  Text(
                                    " hours",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )),
          InkWell(
            onTap: () {
              Get.to(
                  () => BookingInformation(
                        pickupAddress: pickupAddress,
                        dropoffAddress: dropoffAddress,
                        bookingTime: chooseServiceController
                                    .isSelectedPerMinute.value ==
                                true
                            ? 'Confirm Per Minutes Booking '
                            : chooseServiceController
                                    .selectedCategoryName.value.isNotEmpty
                                ? 'Confirm Hourly Booking (${chooseServiceController.selectedCategoryName.value} hours)'
                                : 'Confirm Hourly Booking',
                      ),
                  transition: Transition.rightToLeft,
                  duration: const Duration(milliseconds: 790));
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryColors,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Obx(() {
                  return Text(
                    chooseServiceController.isSelectedPerMinute.value == true
                        ? 'Confirm Per Minutes Booking '
                        : chooseServiceController
                                .selectedCategoryName.value.isNotEmpty
                            ? 'Confirm Hourly Booking (${chooseServiceController.selectedCategoryName.value} hours)'
                            : 'Confirm Hourly Booking',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
