import 'package:flutter/material.dart';
import 'package:one_car_rental_app/presentation/components/common/common_text.dart';
import 'package:one_car_rental_app/res/colors/colors.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    Key? key,
    required this.title,
    required this.width,
    this.isLoading = false,
  }) : super(key: key);

  final String title;
  final double width;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
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
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
    );
  }
}
