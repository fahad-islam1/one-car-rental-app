import 'package:one_car_rental_app/presentation/components/common/common_text.dart';
import 'package:one_car_rental_app/res/colors/colors.dart';
import 'package:one_car_rental_app/res/utils/termcondtion.dart';
import 'package:flutter/material.dart';

class TermAndConditonScreem extends StatelessWidget {
  const TermAndConditonScreem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColors,
        child: Icon(
          Icons.chat,
          color: white,
        ),
      ),
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: true,
        title: const CustomText(
          text: 'Terms & Conditions',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.orange, // Use your primary color here
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/logo2.png', // Replace with your app logo path
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.orange, // Use your primary color here
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    child: const CustomText(
                      text: 'Terms and Conditions',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      termsAndConditions,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
