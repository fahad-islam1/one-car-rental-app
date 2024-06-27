import 'package:flutter/material.dart';
import 'package:one_car_rental_app/presentation/components/common/common_text.dart';
import 'package:one_car_rental_app/res/colors/colors.dart';

class YourTrip extends StatefulWidget {
  const YourTrip({super.key});

  @override
  _YourTripState createState() => _YourTripState();
}

class _YourTripState extends State<YourTrip> {
  String _selectedValue = 'Past';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Container(
              width: 120,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: primaryColors,
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedValue,
                  dropdownColor: primaryColors,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                  style: const TextStyle(color: Colors.white),
                  items: <String>['Past', 'Active', 'Scheduled']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: const TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedValue = newValue!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: CustomText(
                    text: 'Your Trips',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Divider(
                color: grey,
              ),
            ),
            Expanded(
              child: Center(
                child: CustomText(
                  text: 'No Ride Found',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ],
        ));
  }
}
