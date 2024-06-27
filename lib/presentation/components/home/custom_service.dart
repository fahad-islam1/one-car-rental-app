import 'package:flutter/material.dart';
import 'package:one_car_rental_app/res/colors/colors.dart';

class ChooseServiceWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String btnTitle;
  final String image;

  const ChooseServiceWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.btnTitle,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.025),
      margin: EdgeInsets.all(screenWidth * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
        boxShadow: [
          BoxShadow(
            color: Colors.grey
                .withOpacity(0.3), // Change shadow color and opacity as needed
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: screenHeight * 0.01),
                Container(
                  height: screenHeight * 0.05,
                  width: screenWidth * 0.4,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.005,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColors,
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        btnTitle,
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: screenWidth * 0.03,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Image(image: AssetImage(image)),
        ],
      ),
    );
  }
}
