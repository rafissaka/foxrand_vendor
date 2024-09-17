import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/locaton_controller.dart';

class MapScreen extends StatefulWidget {
  final Rx<LatLng> selectedLocation;
  final String address;
  const MapScreen({
    Key? key,
    required this.selectedLocation,
    required this.address,
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  String location = "Search Location";
  double? lat;
  double? long;
  String newAddress = "";

  final Set<Marker> markers = {};

  googleMapPage({required double initialLat, required double initialLng}) {
    widget.selectedLocation.value = LatLng(initialLat, initialLng);
    markers.add(Marker(
      markerId: const MarkerId("selectedLocation"),
      position: widget.selectedLocation.value,
    ));
  }

  final LocationController locationController = Get.put(LocationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                target: widget.selectedLocation.value,
                zoom: 15.0,
              ),
              markers: markers,
              onMapCreated: (GoogleMapController controller) {
                googleMapPage(
                    initialLat: widget.selectedLocation.value.latitude,
                    initialLng: widget.selectedLocation.value.longitude);
              },
              onTap: (LatLng position) async {
                markers.clear();
                markers.add(
                  Marker(
                    markerId: const MarkerId("selectedLocation"),
                    position: position,
                  ),
                );
                widget.selectedLocation.value = position;
                List<Placemark> placemarks = await placemarkFromCoordinates(
                    position.latitude, position.longitude);

                Placemark placemark = placemarks[0];
                setState(() {
                  lat = position.latitude;
                  long = position.longitude;
                  newAddress =
                      "${placemark.street}, ${placemark.locality}, ${placemark.country}";
                });
              },
            ),
            Positioned(
              bottom: 20.0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      newAddress.isEmpty ? widget.address : newAddress,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18.0.sp),
                    ),
                    const SizedBox(height: 10.0),
                    ElevatedButton(
                      onPressed: updateLocationAndReturn,
                      child: const Text("Confirm Location"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateLocationAndReturn() {
    // Update the location using the controller
    locationController.updateLocation(newAddress, lat!, long!);

    // Navigate back to the registration screen
    Get.back();
  }
}
