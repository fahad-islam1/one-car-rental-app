// import 'dart:async';
// import 'dart:convert';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:http/http.dart' as http;
// import 'package:one_car_rental_app/data/model/point_latmodel.dart';
// import 'package:one_car_rental_app/res/utils/map_api_keys.dart';

// class ChooseServiceTypeScreen extends StatefulWidget {
//   final String? pickupAddress;
//   final String? dropoffAddress;

//   const ChooseServiceTypeScreen({
//     Key? key,
//     this.pickupAddress,
//     this.dropoffAddress,
//   }) : super(key: key);

//   @override
//   _ChooseServiceTypeScreenState createState() =>
//       _ChooseServiceTypeScreenState();
// }

// class _ChooseServiceTypeScreenState extends State<ChooseServiceTypeScreen> {
//   Completer<GoogleMapController> _controller = Completer();
//   LatLng? _pickupLocation;
//   LatLng? _dropoffLocation;
//   Set<Marker> _markers = {};
//   Set<Polyline> _polylines = {};
//   double? _distance;

//   @override
//   void initState() {
//     super.initState();
//     setInitialLocations();
//   }

//   Future<LatLng?> getLatLngFromAddress(String address,
//       {int retries = 3}) async {
//     print('Getting LatLng for address: $address');
//     for (int i = 0; i < retries; i++) {
//       try {
//         List<Location> locations =
//             await locationFromAddress(address).timeout(Duration(seconds: 10));
//         print('Locations found: $locations');
//         return LatLng(locations.first.latitude, locations.first.longitude);
//       } catch (e) {
//         print('Error fetching location: $e');
//         if (i == retries - 1) {
//           return null;
//         }
//       }
//     }
//     return null;
//   }

//   void setInitialLocations() async {
//     print('Setting initial locations');
//     if (widget.pickupAddress != null && widget.dropoffAddress != null) {
//       _pickupLocation = await getLatLngFromAddress(widget.pickupAddress!);
//       _dropoffLocation = await getLatLngFromAddress(widget.dropoffAddress!);

//       print('Pickup Location: $_pickupLocation');
//       print('Dropoff Location: $_dropoffLocation');

//       if (_pickupLocation != null && _dropoffLocation != null) {
//         setState(() {
//           _markers.add(Marker(
//             markerId: MarkerId('pickup'),
//             position: _pickupLocation!,
//             infoWindow: InfoWindow(title: 'Pickup Location'),
//           ));
//           _markers.add(Marker(
//             markerId: MarkerId('dropoff'),
//             position: _dropoffLocation!,
//             infoWindow: InfoWindow(title: 'Dropoff Location'),
//           ));
//         });

//         fetchRoute();
//       }
//     }
//   }

//   Future<void> fetchRoute() async {
//     if (_pickupLocation == null || _dropoffLocation == null) return;

//     final String apiKey = mapApiKey;
//     final String url =
//         'https://maps.googleapis.com/maps/api/directions/json?origin=${_pickupLocation!.latitude},${_pickupLocation!.longitude}&destination=${_dropoffLocation!.latitude},${_dropoffLocation!.longitude}&key=$apiKey';

//     print('Fetching route from URL: $url');
//     final response = await http.get(Uri.parse(url));
//     print('Response status: ${response.statusCode}');
//     if (response.statusCode == 200) {
//       Map<String, dynamic> data = jsonDecode(response.body);
//       print('Directions API response: $data');
//       if (data['routes'].isNotEmpty) {
//         final route = data['routes'][0];
//         final polylinePoints = route['overview_polyline']['points'];
//         final List<PointLatLng> points = decodePolyline(polylinePoints);
//         final List<LatLng> polylineCoordinates = points
//             .map((point) => LatLng(point.latitude, point.longitude))
//             .toList();

//         setState(() {
//           _polylines.add(Polyline(
//             polylineId: PolylineId('route'),
//             color: Colors.blue,
//             width: 5,
//             points: polylineCoordinates,
//           ));

//           _distance =
//               route['legs'][0]['distance']['value'] / 1000.0; // distance in km
//         });

//         fitBounds(polylineCoordinates);
//       } else {
//         print('No routes found');
//       }
//     } else {
//       print('Error fetching directions: ${response.statusCode}');
//     }
//   }

//   List<PointLatLng> decodePolyline(String poly) {
//     print('Decoding polyline');
//     List<PointLatLng> points = [];
//     int index = 0, len = poly.length;
//     int lat = 0, lng = 0;

//     while (index < len) {
//       int b, shift = 0, result = 0;
//       do {
//         b = poly.codeUnitAt(index++) - 63;
//         result |= (b & 0x1F) << shift;
//         shift += 5;
//       } while (b >= 0x20);
//       int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//       lat += dlat;

//       shift = 0;
//       result = 0;
//       do {
//         b = poly.codeUnitAt(index++) - 63;
//         result |= (b & 0x1F) << shift;
//         shift += 5;
//       } while (b >= 0x20);
//       int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//       lng += dlng;

//       points.add(PointLatLng(lat / 1E5, lng / 1E5));
//     }

//     print('Decoded points: $points');
//     return points;
//   }

//   void fitBounds(List<LatLng> polylineCoordinates) {
//     print('Fitting bounds');
//     if (polylineCoordinates.isNotEmpty) {
//       LatLngBounds bounds;
//       if (polylineCoordinates.length == 1) {
//         bounds = LatLngBounds(
//           southwest: polylineCoordinates[0],
//           northeast: polylineCoordinates[0],
//         );
//       } else {
//         bounds = LatLngBounds(
//           southwest: LatLng(
//             polylineCoordinates.map((e) => e.latitude).reduce(min),
//             polylineCoordinates.map((e) => e.longitude).reduce(min),
//           ),
//           northeast: LatLng(
//             polylineCoordinates.map((e) => e.latitude).reduce(max),
//             polylineCoordinates.map((e) => e.longitude).reduce(max),
//           ),
//         );
//       }

//       CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 100);
//       if (_controller.isCompleted) {
//         _controller.future.then((controller) {
//           controller.animateCamera(cameraUpdate);
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Choose Service Type'),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             mapType: MapType.normal,
//             initialCameraPosition: CameraPosition(
//               target: LatLng(
//                   31.5497, 74.3436), // Default to Lahore if location not found
//               zoom: 12,
//             ),
//             markers: _markers,
//             polylines: _polylines,
//             onMapCreated: (GoogleMapController controller) {
//               _controller.complete(controller);
//             },
//           ),
//           Positioned(
//             top: 20,
//             right: 20,
//             child: Container(
//               padding: EdgeInsets.all(8.0),
//               color: Colors.white,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   if (_pickupLocation != null)
//                     Text(
//                       'Pickup: ${widget.pickupAddress}',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   if (_dropoffLocation != null)
//                     Text(
//                       'Dropoff: ${widget.dropoffAddress}',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   if (_distance != null)
//                     Text(
//                       'Distance: ${_distance!.toStringAsFixed(2)} km',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:one_car_rental_app/presentation/components/home/choose_service_container.dart';
import 'package:one_car_rental_app/presentation/viewmodel/home/choose_service_viewmodel.dart';

class ChooseServiceTypeScreen extends StatelessWidget {
  final String? pickupAddress;
  final String? dropoffAddress;

  ChooseServiceTypeScreen({this.pickupAddress, this.dropoffAddress});

  final ChooseServiceViewmodel chooseServiceController =
      Get.put(ChooseServiceViewmodel());

  @override
  Widget build(BuildContext context) {
    chooseServiceController.setInitialLocations(pickupAddress, dropoffAddress);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Service Type'),
      ),
      body: Stack(
        children: [
        Obx(() {
                  return GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(31.5497, 74.3436),
                      tilt: 5,
                      zoom: 7,
                    ),
                    markers: chooseServiceController.markers,
                    polylines: chooseServiceController.polylines,
                    onMapCreated: (GoogleMapController controller) {
                      chooseServiceController.controller.complete(controller);
                    },
                  );
                }),
                Positioned(
                  top: 20,
                  right: 20,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (pickupAddress != null)
                          Text(
                            'Pickup: $pickupAddress',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        if (dropoffAddress != null)
                          Text(
                            'Dropoff: $dropoffAddress',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        Obx(() {
                          if (chooseServiceController.distance > 0) {
                            return Text(
                              'Distance: ${chooseServiceController.distance.toStringAsFixed(2)} km',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            );
                          } else {
                            return Container();
                          }
                        }),
                      ],
                    ),
                  ),
                ),
          Positioned(
            bottom: 0,
            child: ChooseSeriviceContainer(size: size, chooseServiceController: chooseServiceController, pickupAddress: pickupAddress,dropoffAddress: dropoffAddress,),
          ),
        ],
      ),
    );
  }
}
