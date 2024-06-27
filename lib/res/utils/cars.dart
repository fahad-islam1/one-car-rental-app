import 'package:flutter/material.dart';
import 'package:one_car_rental_app/data/model/car_model.dart';

final List<Car> cars = [
  // Standard Cars
  Car(
      name: 'Mitsubishi Attrage',
      category: 'Standard',
      imageUrl: 'assets/icons/nissan.jpg'),
  Car(
      name: 'Nissan SUNNY',
      category: 'Standard',
      imageUrl: 'assets/icons/nissan_sunny.jpg'),
  Car(
      name: 'Kia PICANTO',
      category: 'Standard',
      imageUrl: 'assets/icons/kia_picanto.jpg'),
  Car(
      name: 'Toyota YARIS',
      category: 'Standard',
      imageUrl: 'assets/icons/toyota_yaris.jpg'),
  Car(
      name: 'Hyundai ELANTRA',
      category: 'Standard',
      imageUrl: 'assets/icons/hyundai_elantra.jpg'),
  Car(
      name: 'Kia SPORTAGE',
      category: 'Standard',
      imageUrl: 'assets/icons/kia_sportage.jpg'),
  Car(
      name: 'Hyundai ACCENT',
      category: 'Standard',
      imageUrl: 'assets/icons/hyundai_accent.jpg'),
  Car(
      name: 'Hyundai i10',
      category: 'Standard',
      imageUrl: 'assets/icons/hyundai_i10.jpg'),
  Car(name: 'MG5', category: 'Standard', imageUrl: 'assets/icons/mg5.jpg'),
  Car(
      name: 'MG RX8',
      category: 'Standard',
      imageUrl: 'assets/icons/mg_rx8.jpg'),
  Car(
      name: 'HAVAL JOLINE',
      category: 'Standard',
      imageUrl: 'assets/icons/haval_joline.jpg'),
  Car(
      name: 'Hyundai CRETA',
      category: 'Standard',
      imageUrl: 'assets/icons/hyundai_creta.jpg'),
  Car(
      name: 'Hyundai TUCSON',
      category: 'Standard',
      imageUrl: 'assets/icons/hyundai_tucson.jpg'),
  Car(
      name: 'Chevrolet IMPALA',
      category: 'Standard',
      imageUrl: 'assets/icons/chevrolet_impala.jpg'),
  Car(
      name: 'Chevrolet Malibu',
      category: 'Standard',
      imageUrl: 'assets/icons/chevrolet_malibu.jpg'),
  Car(
      name: 'Chevrolet Equinox',
      category: 'Standard',
      imageUrl: 'assets/icons/chevrolet_equinox.jpg'),
  Car(name: 'JAC 7', category: 'Standard', imageUrl: 'assets/icons/jac_7.jpg'),
  Car(name: 'RAV 4', category: 'Standard', imageUrl: 'assets/icons/rav_4.jpg'),
  Car(
      name: 'MG RX5',
      category: 'Standard',
      imageUrl: 'assets/icons/mg_rx5.jpg'),

  // Sports Cars
  Car(
      name: 'Lamborghini Evo SPYDER',
      category: 'Sports',
      imageUrl: 'assets/icons/lamborghini_evo_spyder.jpg'),
  Car(
      name: 'FERRARI F8',
      category: 'Sports',
      imageUrl: 'assets/icons/ferrari_f8.jpg'),
  Car(
      name: 'Mercedes BENZ AMG G63',
      category: 'Sports',
      imageUrl: 'assets/icons/mercedes_amg_g63.jpg'),
  Car(
      name: 'FERRARI SP90',
      category: 'Sports',
      imageUrl: 'assets/icons/ferrari_sp90.jpg'),
  Car(
      name: 'PORSCHE 911 GT3',
      category: 'Sports',
      imageUrl: 'assets/icons/porsche_911_gt3.jpg'),
  Car(
      name: 'TESLA 3 Long Range',
      category: 'Sports',
      imageUrl: 'assets/icons/tesla_3_long_range.jpg'),

  // Luxury Cars
  Car(
      name: 'Mercedes Benz GLE 450',
      category: 'Luxury',
      imageUrl: 'assets/icons/mercedes_gle_450.jpg'),
  Car(
      name: 'Mercedes Benz S400',
      category: 'Luxury',
      imageUrl: 'assets/icons/mercedes_s400.jpg'),
  Car(
      name: 'Mercedes Benz S450',
      category: 'Luxury',
      imageUrl: 'assets/icons/mercedes_s450.jpg'),
  Car(
      name: 'Mercedes Benz S550',
      category: 'Luxury',
      imageUrl: 'assets/icons/mercedes_s550.jpg'),
  Car(
      name: 'TESLA Y Long Range',
      category: 'Luxury',
      imageUrl: 'assets/icons/tesla_y_long_range.jpg'),
  Car(
      name: 'TESLA S Plaid',
      category: 'Luxury',
      imageUrl: 'assets/icons/tesla_s_plaid.jpg'),
  Car(
      name: 'TESLA X Plaid',
      category: 'Luxury',
      imageUrl: 'assets/icons/tesla_x_plaid.jpg'),
  Car(
      name: 'BMW 530i',
      category: 'Luxury',
      imageUrl: 'assets/icons/bmw_530i.jpg'),
];
Color getColorByIndex(int index) {
  List<Color> colorList = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.cyan,
    Colors.teal,
    Colors.pink,
    Colors.indigo,
    Colors.amber,
    Colors.brown,
  ];
  return colorList[index % colorList.length];
}

// Helper method to get a color name based on index (for demo purposes)
String getColorNameByIndex(int index) {
  List<String> colorNames = [
    'Red',
    'Blue',
    'Green',
    'Yellow',
    'Orange',
    'Purple',
    'Cyan',
    'Teal',
    'Pink',
    'Indigo',
    'Amber',
    'Brown',
  ];
  return colorNames[index % colorNames.length];
}

String getColorName(Color color) {
  if (color == Colors.red) return 'Red';
  if (color == Colors.green) return 'Green';
  if (color == Colors.blue) return 'Blue';
  if (color == Colors.yellow) return 'Yellow';
  if (color == Colors.orange) return 'Orange';
  if (color == Colors.purple) return 'Purple';
  if (color == Colors.black) return 'Black';
  if (color == Colors.white) return 'White';
  // Add more colors as needed
  return 'Unknown Color';
}