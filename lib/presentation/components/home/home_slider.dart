
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:one_car_rental_app/presentation/views/home/conatct_us_screen.dart';
import 'package:one_car_rental_app/presentation/views/home/safetytrip_screen.dart';
import 'package:one_car_rental_app/presentation/views/home/travelingtonext_city_screen.dart';
import 'package:one_car_rental_app/presentation/views/reward/refer_earn_screen.dart';
import 'package:one_car_rental_app/res/utils/home_slider.dart';

class ImageSlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<ImageSlider> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return GestureDetector(
              onTap: () {
                switch (index) {
                  case 0:
                    Get.to(() => const TravelingtonextCityScreen(),
                        transition: Transition.rightToLeft);
                    break;
                  case 1:
                    Get.to(() => const ReferAndEarnScreen(),
                        transition: Transition.rightToLeft);
                  case 2:
                    Get.to(() => const ContactUsScreen(),
                        transition: Transition.rightToLeft);

                  case 3:
                    Get.to(() => const SafetytripScreen(),
                        transition: Transition.rightToLeft);

                    break;
                  case 4:
                    Get.to(() => const TravelingtonextCityScreen(),
                        transition: Transition.rightToLeft);
                    break;

                  // Add more cases for additional screens if needed
                  default:
                    break;
                }
              },
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage(images[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    child: Text(
                      title[index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: images.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(entry.key),
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (_current == entry.key
                                  ? Colors.blue
                                  : Colors.grey),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          },
          carouselController: _controller,
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: MediaQuery.of(context).size.width / 200,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
      ],
    );
  }
}
