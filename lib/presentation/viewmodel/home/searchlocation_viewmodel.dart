import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:one_car_rental_app/res/utils/map_api_keys.dart';
import 'package:one_car_rental_app/res/utils/snackbarmsg.dart';

class SearchLocationViewModel extends GetxController {
  final RxList<TextEditingController> _locationControllers =
      <TextEditingController>[].obs;
  final RxList<RxList<String>> _suggestionsList = <RxList<String>>[].obs;

  RxList<TextEditingController> get locationControllers => _locationControllers;
  List<RxList<String>> get suggestionsList => _suggestionsList;

  @override
  void onInit() {
    super.onInit();
    addLocationField(); 
    addLocationField(); 
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
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      Message.showError('Network Error', 'No internet connection');
      return 'No internet connection';
    }

    var response = await Geocoder2.getDataFromCoordinates(
      latitude: latLng.latitude,
      longitude: latLng.longitude,
      googleMapApiKey: mapApiKey,
    );

    if (response != null && response.address != null) {
      Message.showSuccess('Success', 'Address fetched successfully');
      return response.address!;
    } else {
      Message.showError('Error', 'Unknown address');
      return 'Unknown address';
    }
  } catch (e) {
    if (e is SocketException) {
      Message.showError('Network Error', 'Please check your internet connection and try again.');
      return 'Network error';
    } else {
      Message.showError('Error', 'Error fetching address: $e');
      return 'Error fetching address';
    }
  }
}
}