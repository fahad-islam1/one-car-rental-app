import 'package:one_car_rental_app/presentation/components/common/common_text.dart';
import 'package:one_car_rental_app/res/colors/colors.dart';
import 'package:flutter/material.dart';

class SavedLocationScreen extends StatelessWidget {
  const SavedLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CustomText(
              text: 'Saved Locations',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          actions: [
            CustomText(
                text: 'Add New', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        body: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Divider(
                thickness: 10,
                color: grey,
              ),
            ),
            Expanded(
              child: Center(
                child: CustomText(
                  text: 'No Saved Places Found',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ],
        ));
  }
}
