import 'package:one_car_rental_app/presentation/components/common/common_text.dart';
import 'package:one_car_rental_app/res/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTikcetScreen extends StatelessWidget {
  const MyTikcetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: white,
          ),
        ),
        backgroundColor: primaryColors,
        centerTitle: true,
        title: CustomText(
            text: 'My Ticket',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: white)),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: grey,
              child: Icon(
                Icons.photo_sharp,
                color: white,
                size: 50,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomText(
                text:
                    'Conservations started from this app will \n be vissible here ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: primaryColors,
                )),
            SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.all(10),
                height: 45,
                width: MediaQuery.of(context).size.width * .6,
                decoration: BoxDecoration(
                  color: primaryColors,
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.center,
                child: CustomText(
                    text: 'Start a Conservation',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: white,
                      fontSize: 20,
                    )))
          ],
        ),
      ),
    );
  }
}
