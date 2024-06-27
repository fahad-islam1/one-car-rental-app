import 'package:one_car_rental_app/presentation/components/home/bottm_btn.dart';
import 'package:flutter/material.dart';

class SafetytripScreen extends StatelessWidget {
  const SafetytripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottmBtn(
        title: 'Book Now',
        width: 300,
      ),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top centered image
            Center(
              child: Image.asset(
                'assets/images/car1.jpg',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            // Safety icon in blue color
            const Icon(
              Icons.security,
              size: 50,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            // Text
            const Text(
              'Your trip is fully insured',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Description text
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Coverage for damage to your own vehicle up to a limit of AED 200,000.\n'
                'In case of an accident, you are required to notify One Car Rental within a 24-hour period.\n'
                'For more detailed information, please refer to our Terms & Conditions.',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
