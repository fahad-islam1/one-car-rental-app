import 'package:one_car_rental_app/presentation/components/common/common_text.dart';
import 'package:one_car_rental_app/presentation/views/profile/my_tikcet_screen.dart';
import 'package:one_car_rental_app/res/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
            text: 'Help Section',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: CustomText(
              text: 'Need Further Assistance ?',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Divider(),
          ListTile(
            leading: CircleAvatar(
              radius: 14,
              backgroundColor: primaryColors,
              child: Icon(
                Icons.question_mark,
                color: white,
              ),
            ),
            title: CustomText(
              text: 'Frequently Asked Questions',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.person,
              color: primaryColors,
            ),
            title: CustomText(
              text: 'Chat with Support',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.timer,
              color: primaryColors,
            ),
            title: CustomText(
              text: 'All Tickets',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
            ),
            onTap: () {
              Get.to(() => MyTikcetScreen(),
                  transition: Transition.rightToLeft,
                  duration: Duration(milliseconds: 790));
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
