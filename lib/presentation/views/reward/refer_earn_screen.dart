import 'package:flutter/material.dart';
import 'package:one_car_rental_app/presentation/components/common/common_text.dart';
import 'package:one_car_rental_app/presentation/components/reward/refer_options.dart';
import 'package:one_car_rental_app/presentation/components/reward/timelinestep.dart';
import 'package:one_car_rental_app/res/colors/colors.dart';

class ReferAndEarnScreen extends StatelessWidget {
  const ReferAndEarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: true,
        title: const CustomText(
            text: 'Refer & Earn',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          const Image(
            image: AssetImage('assets/images/car1.jpg'),
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          ),
          const SizedBox(
            height: 10,
          ),
          const CustomText(
              text: 'HOW IT WORK',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: grey.withOpacity(0.4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                buildTimelineStep('Invite Your Friend', showLine: true),
                buildTimelineStep('They got AED 60 OFF', showLine: true),
                buildTimelineStep('You Earn AED 60 OFF', showLine: false),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: Divider(color: primaryColors)),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomText(
                    text: 'REFER VIA',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Expanded(child: Divider(color: primaryColors)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildReferOption(Icons.call, 'WhatsApp'),
              buildReferOption(Icons.chat, 'Messenger'),
              buildReferOption(Icons.share, 'Share'),
            ],
          ),
        ],
      ),
    );
  }
}
