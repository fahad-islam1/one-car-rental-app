import 'package:flutter/material.dart';
import 'package:one_car_rental_app/presentation/components/common/common_text.dart';
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
        title: CustomText(
            text: 'Refer & Earn',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Image(
            image: AssetImage('assets/images/car1.jpg'),
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          ),
          SizedBox(
            height: 10,
          ),
          CustomText(
              text: 'HOW IT WORK',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: grey.withOpacity(0.4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                _buildTimelineStep('Invite Your Friend', showLine: true),
                _buildTimelineStep('They got AED 60 OFF', showLine: true),
                _buildTimelineStep('You Earn AED 60 OFF', showLine: false),
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: Divider(color: primaryColors)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomText(
                    text: 'REFER VIA',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Expanded(child: Divider(color: primaryColors)),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildReferOption(Icons.call, 'WhatsApp'),
              _buildReferOption(Icons.chat, 'Messenger'),
              _buildReferOption(Icons.share, 'Share'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineStep(String text, {required bool showLine}) {
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
        SizedBox(width: 10),
        Expanded(
          child: CustomText(
            text: text,
            style: TextStyle(fontSize: 16, color: primaryColors),
          ),
        ),
      ],
    );
  }

  Widget _buildReferOption(IconData icon, String text) {
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
        SizedBox(height: 5),
        CustomText(text: text, style: TextStyle(color: primaryColors)),
      ],
    );
  }
}
