import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  final List<String> imgList = [
    'assets/images/car1.jpg',
    'assets/images/car2.jpg',
    'assets/images/car3.jpg',
    'assets/images/trip.jpg',
    'assets/images/trip1.jpg',
  ];

  final List<String> title = [
    'Looking for a',
    'Refer & Earn',
    'Your Trip\n is fully \n Insured',
    'Airpot Pickup \n or dropoff',
    'RTa Inspection \n from home',
  ];

  final CarouselController carouselController = CarouselController();
  var current = 0.obs; // Observable for current index

  void setCurrent(int index) {
    current.value = index;
  }

  void changePage(int index) {
    carouselController.animateToPage(index);
  }
}
