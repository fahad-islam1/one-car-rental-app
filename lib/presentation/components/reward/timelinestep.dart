
  import 'package:flutter/material.dart';
import 'package:one_car_rental_app/presentation/components/common/common_text.dart';

import '../../../res/colors/colors.dart';

Widget buildTimelineStep(String text, {required bool showLine}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: primaryColors,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                color: white,
                size: 16,
              ),
            ),
            if (showLine)
              Container(
                width: 2,
                height: 40,
                color: primaryColors,
              ),
          ],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CustomText(
            text: text,
            style: TextStyle(fontSize: 16, color: primaryColors),
          ),
        ),
      ],
    );
  }
