import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class PickMapLocationScreen extends StatefulWidget {
  final int index;
  final TextEditingController pickupController;

  const PickMapLocationScreen({
    Key? key,
    required this.index,
    required this.pickupController,
  }) : super(key: key);

  @override
  State<PickMapLocationScreen> createState() => _PickMapLocationScreenState();
}

class _PickMapLocationScreenState extends State<PickMapLocationScreen> {
  LatLng? selectedLocation;
  GoogleMapController? mapController;
  bool isLocationEnabled = false;
  Location location = Location();

  @override
  void initState() {
    super.initState();
    enableMyLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Location'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              mapController = controller;
            },
            initialCameraPosition: const CameraPosition(
              target: LatLng(37.7749, -122.4194), // Default to San Francisco
              zoom: 10,
            ),
            myLocationButtonEnabled: true,
            myLocationEnabled: isLocationEnabled,
            onTap: (location) {
              setState(() {
                selectedLocation = location;
              });
            },
            markers: Set.from(selectedLocation != null
                ? [
                    Marker(
                      markerId: MarkerId('selectedLocation'),
                      position: selectedLocation!,
                    ),
                  ]
                : []),
          ),
          if (selectedLocation != null)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: ElevatedButton(
                onPressed: () {
                  // For pickup location
                  widget.pickupController.text =
                      '${selectedLocation!.latitude},${selectedLocation!.longitude}';

                  Get.back();
                },
                child: const Text('Confirm Location'),
              ),
            ),
        ],
      ),
    );
  }

  void enableMyLocation() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return; // User did not enable location service
      }
    }

    PermissionStatus permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        return; // User did not grant permission
      }
    }

    LocationData? currentLocation = await location.getLocation();
    if (currentLocation != null && mapController != null) {
      setState(() {
        isLocationEnabled = true;
        selectedLocation =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
      });

      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: selectedLocation!,
            zoom: 15,
          ),
        ),
      );
    }
  }
}
