import 'package:geocoder2/geocoder2.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:one_car_rental_app/res/utils/map_api_keys.dart';

class SearchLocationViewModel extends GetxController {
  final RxList<TextEditingController> _locationControllers =
      <TextEditingController>[].obs;
  final RxList<RxList<String>> _suggestionsList = <RxList<String>>[].obs;

  RxList<TextEditingController> get locationControllers => _locationControllers;
  List<RxList<String>> get suggestionsList => _suggestionsList;

  @override
  void onInit() {
    super.onInit();
    addLocationField(); // Initialize with one field
    addLocationField(); // Initialize with a second field
  }

  void addLocationField() {
    if (_locationControllers.length < 3) {
      _locationControllers.add(TextEditingController());
      _suggestionsList.add(<String>[].obs);
    }
  }

  void removeLocationField(int index) {
    if (_locationControllers.length > 1) {
      _locationControllers.removeAt(index);
      _suggestionsList.removeAt(index);
    }
  }

  Future<void> fetchSuggestions(String input, int index) async {
    if (input.isEmpty) {
      _suggestionsList[index].clear();
      return;
    }

    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=(cities)&key=$mapApiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        _suggestionsList[index].assignAll((data['predictions'] as List)
            .map<String>((p) => p['description'])
            .toList());
      } else {
        _suggestionsList[index].clear();
      }
    } else {
      _suggestionsList[index].clear();
      throw Exception('Failed to load suggestions');
    }
  }

  void clearSuggestions(int index) {
    _suggestionsList[index].clear();
  }


   Future<String> getAddressFromLatLng(LatLng latLng) async {
    try {
      var response = await Geocoder2.getDataFromCoordinates(
        latitude: latLng.latitude,
        longitude: latLng.longitude,
        googleMapApiKey: mapApiKey,
      );

      if (response != null && response.address != null) {
        return response.address!;
      } else {
        return 'Unknown address';
      }
    } catch (e) {
      print('Error fetching address: $e');
      return 'Error fetching address';
    }
  }
}
