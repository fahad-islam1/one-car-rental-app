import 'package:flutter/material.dart';
import 'package:one_car_rental_app/presentation/components/common/common_text.dart';
import 'package:one_car_rental_app/res/colors/colors.dart';

class BottmBtn extends StatelessWidget {
  const BottmBtn({
    super.key,
    required this.title,
    required this.width,
    this.isLoading = false,
  });

  final String title;
  final double width;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 45,
      width: width,
      decoration: BoxDecoration(
        color: primaryColors,
        borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.center,
      child: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : CustomText(
              text: title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
    );
  }
}
