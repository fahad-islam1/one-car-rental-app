import 'package:one_car_rental_app/presentation/components/home/bottm_btn.dart';
import 'package:flutter/material.dart';

class TravelingtonextCityScreen extends StatelessWidget {
  const TravelingtonextCityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CommonButton(
        title: 'Book Now',
        width: 300,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/trip.jpg'),
                      fit: BoxFit.cover)),
              width: double.infinity,
              height: 300,
              child: Stack(
                children: [
                  Positioned(
                    top: 40,
                    left: 16,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child:
                            const Icon(Icons.arrow_back, color: Colors.black),
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 100,
                    left: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Travelling to the Next City !',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'We will take care of you',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Book your personal chauffeur to take you around anywhere around the country on an hourly basis. Price applicable are as below:\n\n'
                '2 hours - AED 100 (AED 50/hour)\n\n'
                '3 hours - AED 144 (AED 48/hour)\n\n'
                '4 hours - AED 180 (AED 45/hour)\n\n'
                '5 hours - AED 220 (AED 44/hour)\n\n'
                '6 hours - AED 252 (AED 42/hour)\n\n'
                '7 hours - AED 280 (AED 40/hour)\n\n'
                '8 hours - AED 304 (AED 38/hour)\n\n'
                'An additional fee will be charged for Inter-city services when the journey begins in one emirate and ends in another.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.4)),
              width: double.infinity,
              child: const Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'FAQS',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  ExpansionTile(
                    title: Text('How to book a ride?'),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            'To book a ride, simply open our app, choose your destination, and confirm your booking.'),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text('What are the payment options?'),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            'You can pay using credit/debit cards, and various online payment methods available in the app.'),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text('Can I schedule a ride in advance?'),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            'Yes, you can schedule a ride in advance through our app. Choose the date and time that suits you best.'),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text('How can I contact customer support?'),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            'You can contact our customer support through the app or by calling our support hotline.'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
