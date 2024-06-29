import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class CarServiceViewModel extends GetxController {
  Rx<LatLng?> pickLocation = Rx<LatLng?>(null);
  late GoogleMapController mapController;
  RxList<Marker> markers = <Marker>[].obs;

  void initMapController(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      LatLng latLngPosition = LatLng(position.latitude, position.longitude);
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLngPosition,
          zoom: 14,
        ),
      ));
      updateMarkers([Marker(
        markerId: MarkerId("currentLocation"),
        position: latLngPosition,
      )]);
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  void updateMarkers(List<Marker> newMarkers) {
    markers.assignAll(newMarkers);
  }
}
