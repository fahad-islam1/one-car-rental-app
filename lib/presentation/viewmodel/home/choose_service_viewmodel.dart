import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:one_car_rental_app/data/model/point_latmodel.dart';
import 'package:one_car_rental_app/res/utils/map_api_keys.dart';

class ChooseServiceViewmodel extends GetxController {
  Completer<GoogleMapController> _controller = Completer();
  LatLng? _pickupLocation;
  LatLng? _dropoffLocation;
  RxSet<Marker> _markers = <Marker>{}.obs;
  RxSet<Polyline> _polylines = <Polyline>{}.obs;
  RxDouble _distance = 0.0.obs;
  RxBool isSelectedPerMinute = false.obs;
  RxBool isSelected = true.obs;

  final List<String> categoryList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];
  var selectedCategoryName = ''.obs;

  void selectCategory(String category) {
    if (selectedCategoryName.value == category) {
      selectedCategoryName.value = '';
    } else {
      selectedCategoryName.value = category;
    }
  }

  Completer<GoogleMapController> get controller => _controller;
  LatLng? get pickupLocation => _pickupLocation;
  LatLng? get dropoffLocation => _dropoffLocation;
  Set<Marker> get markers => _markers.toSet();
  Set<Polyline> get polylines => _polylines.toSet();
  double get distance => _distance.value;

  @override
  void onInit() {
    super.onInit();
    // Additional initialization if needed
  }

  Future<void> setInitialLocations(
      String? pickupAddress, String? dropoffAddress) async {
    if (pickupAddress != null && dropoffAddress != null) {
      _pickupLocation = await getLatLngFromAddress(pickupAddress);
      _dropoffLocation = await getLatLngFromAddress(dropoffAddress);

      if (_pickupLocation != null && _dropoffLocation != null) {
        _markers.addAll([
          Marker(
            markerId: MarkerId('pickup'),
            position: _pickupLocation!,
            infoWindow: InfoWindow(title: 'Pickup Location'),
          ),
          Marker(
            markerId: MarkerId('dropoff'),
            position: _dropoffLocation!,
            infoWindow: InfoWindow(title: 'Dropoff Location'),
          ),
        ]);

        fetchRoute();
      }
    }
  }

  Future<LatLng?> getLatLngFromAddress(String address,
      {int retries = 3}) async {
    for (int i = 0; i < retries; i++) {
      try {
        List<Location> locations =
            await locationFromAddress(address).timeout(Duration(seconds: 10));
        return LatLng(locations.first.latitude, locations.first.longitude);
      } catch (e) {
        if (i == retries - 1) {
          return null;
        }
      }
    }
    return null;
  }

  Future<void> fetchRoute() async {
    if (_pickupLocation == null || _dropoffLocation == null) return;

    final String apiKey = mapApiKey;
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${_pickupLocation!.latitude},${_pickupLocation!.longitude}&destination=${_dropoffLocation!.latitude},${_dropoffLocation!.longitude}&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data['routes'].isNotEmpty) {
        final route = data['routes'][0];
        final polylinePoints = route['overview_polyline']['points'];
        final List<PointLatLng> points = decodePolyline(polylinePoints);
        final List<LatLng> polylineCoordinates = points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();

        _polylines.clear();
        _polylines.add(Polyline(
          polylineId: PolylineId('route'),
          color: Colors.blue,
          width: 5,
          points: polylineCoordinates,
        ));

        _distance.value =
            route['legs'][0]['distance']['value'] / 1000.0; // distance in km

        fitBounds(polylineCoordinates);
      }
    }
  }

  List<PointLatLng> decodePolyline(String poly) {
    List<PointLatLng> points = [];
    int index = 0, len = poly.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = poly.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = poly.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(PointLatLng(lat / 1E5, lng / 1E5));
    }

    return points;
  }

  void fitBounds(List<LatLng> polylineCoordinates) {
    if (polylineCoordinates.isNotEmpty) {
      LatLngBounds bounds;
      if (polylineCoordinates.length == 1) {
        bounds = LatLngBounds(
          southwest: polylineCoordinates[0],
          northeast: polylineCoordinates[0],
        );
      } else {
        bounds = LatLngBounds(
          southwest: LatLng(
            polylineCoordinates.map((e) => e.latitude).reduce(min),
            polylineCoordinates.map((e) => e.longitude).reduce(min),
          ),
          northeast: LatLng(
            polylineCoordinates.map((e) => e.latitude).reduce(max),
            polylineCoordinates.map((e) => e.longitude).reduce(max),
          ),
        );
      }

      CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 100);
      if (_controller.isCompleted) {
        _controller.future.then((controller) {
          controller.animateCamera(cameraUpdate);
        });
      }
    }
  }
}
