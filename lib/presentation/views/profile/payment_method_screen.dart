import 'package:one_car_rental_app/presentation/components/common/common_text.dart';
import 'package:one_car_rental_app/presentation/views/profile/add_new_card_screen.dart';
import 'package:one_car_rental_app/res/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PAymentMethods extends StatelessWidget {
  const PAymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: true,
        title: const CustomText(
            text: 'Payment Method',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 30),
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: primaryColors),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      text: 'One Car Rental Wallet Balanace',
                      style: TextStyle(
                        color: white,
                        fontSize: 15,
                      )),
                  CustomText(
                      text: 'AED 0',
                      style: TextStyle(
                          color: white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: white),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: white,
                                  size: 16,
                                ),
                                onPressed: () {}),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: CustomText(
                                  text: 'Top Up',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: white,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                            border: Border.all(color: white),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.alarm,
                                  color: white,
                                  size: 15,
                                ),
                                onPressed: () {}),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: CustomText(
                                  text: 'Wallet History',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: white,
                                  )),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomText(
                text: 'Your Card',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: 170,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primaryColors),
                    alignment: Alignment.center,
                    child: const Image(
                      image: AssetImage('assets/images/gpay.png'),
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    )),
                InkWell(
                  onTap: () {
                    Get.to(() => const AddNewCard(),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 790));
                  },
                  child: Container(
                      height: 200,
                      width: 170,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: grey)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: grey,
                            size: 60,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomText(
                              text: 'Add New Card',
                              style: TextStyle(
                                  color: grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
