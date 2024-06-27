import 'package:one_car_rental_app/presentation/components/common/common_text.dart';
import 'package:flutter/material.dart';

class SavedCarLocation extends StatefulWidget {
  const SavedCarLocation({super.key});

  @override
  _SavedCarLocationState createState() => _SavedCarLocationState();
}

class _SavedCarLocationState extends State<SavedCarLocation> {
  String selectedLocation = 'Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'Save Locations',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(thickness: 5, height: 10, color: Colors.grey),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Title',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter title',
                  ),
                ),
                const SizedBox(height: 16),
                CustomText(
                  text: 'Enter Address',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter address',
                  ),
                ),
                const SizedBox(height: 16),
                CustomText(
                  text: 'Location Type',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    buildLocationButton('Home'),
                    const SizedBox(
                      width: 10,
                    ),
                    buildLocationButton('Office'),
                    const SizedBox(
                      width: 10,
                    ),
                    buildLocationButton('Other'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLocationButton(String location) {
    bool isSelected = selectedLocation == location;

    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedLocation = location;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.black : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        side: const BorderSide(color: Colors.black),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(location),
    );
  }
}
