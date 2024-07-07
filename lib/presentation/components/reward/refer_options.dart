
  import 'package:flutter/material.dart';
import 'package:one_car_rental_app/presentation/components/common/common_text.dart';
import 'package:one_car_rental_app/res/colors/colors.dart';

Widget buildReferOption(IconData icon, String text) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: grey.withOpacity(0.4),
          child: IconButton(
            icon: Icon(
              icon,
              color: primaryColors,
            ),
            onPressed: () {},
          ),
        ),
        const SizedBox(height: 5),
        CustomText(text: text, style: TextStyle(color: primaryColors)),
      ],
    );
  }
