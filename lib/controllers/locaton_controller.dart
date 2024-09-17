import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';

import 'vendor_controller.dart';

class LocationController extends GetxController {
  final VendorController vendorController = Get.put(VendorController());
  loc.Location location = loc.Location();
  RxString currentLocation = ''.obs;
  RxString currentAddress = ''.obs;
  RxDouble currentLat = 0.0.obs;
  RxDouble currentLong = 0.0.obs;

  void updateLocation(String newAddress, double newLat, double newLong) {
    currentAddress.value = newAddress;
    currentLat.value = newLat;
    currentLong.value = newLong;
    vendorController.getFormData(shopAddress: newAddress);
    vendorController.getFormData(geoLocation: GeoPoint(newLat, newLong));
  }

  @override
  void onInit() {
    super.onInit();

    getLocation();
  }

  void getLocation() async {
    try {
      bool serviceEnabled;
      loc.PermissionStatus permissionGranted;
      loc.LocationData locationData;

      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      // Check if the app has permission to access location
      permissionGranted = await location.hasPermission();
      if (permissionGranted == loc.PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != loc.PermissionStatus.granted) {
          return;
        }
      }

      // Get the current location
      locationData = await location.getLocation();

      // Update the location in the UI
      currentLocation.value =
          'Latitude: ${locationData.latitude}, Longitude: ${locationData.longitude}';
      currentLat.value = locationData.latitude!;
      currentLong.value = locationData.longitude!;

      // Get the address from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
          locationData.latitude!, locationData.longitude!);

      // Update the address in the UI
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        currentAddress.value =
            '${placemark.street}, ${placemark.locality}, ${placemark.country}';
        vendorController.getFormData(shopAddress: currentAddress.value);
        vendorController.getFormData(
            geoLocation: GeoPoint(currentLat.value, currentLong.value));
      } else {
        currentAddress.value = 'Address not found';
      }
    } finally {}
  }
}
