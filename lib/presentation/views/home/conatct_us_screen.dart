import 'package:one_car_rental_app/presentation/components/home/bottm_btn.dart';
import 'package:one_car_rental_app/res/colors/colors.dart';
import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CommonButton(
        title: 'Conatact Us',
        width: 300,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: primaryColors, // Use your primary color here
            height: 250,
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
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Looking for a ',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Fulltime Luxury',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Chauffeur',
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
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Looking for a full-time Chauffer ?',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Introducing One Car Rental BLACK, your new luxury chauffeur',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Experience our new subscription-based service, One Car Rental Black.',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Features',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '''
                        Flexible Monthly subscription
                        Summon your chauffeur with one click 
                        Real-time tracking
                        Share with your friends and family.
                        Interested? Please click the button below.''',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // Add more scrollable content if needed
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(color: grey.withOpacity(0.4)),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'FAQS',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          ExpansionTile(
                            title: Text('How to book a ride?'),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'To book a ride, simply open our app, choose your destination, and confirm your booking.'),
                              ),
                            ],
                          ),
                          ExpansionTile(
                            title: Text('What are the payment options?'),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'You can pay using credit/debit cards, and various online payment methods available in the app.'),
                              ),
                            ],
                          ),
                          ExpansionTile(
                            title: Text('Can I schedule a ride in advance?'),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'Yes, you can schedule a ride in advance through our app. Choose the date and time that suits you best.'),
                              ),
                            ],
                          ),
                          ExpansionTile(
                            title: Text('How can I contact customer support?'),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'You can contact our customer support through the app or by calling our support hotline.'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
