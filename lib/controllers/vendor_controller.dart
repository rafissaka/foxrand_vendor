import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class VendorController extends GetxController {
  Map<String, dynamic>? vendorData = {"approved": false};
  getFormData({
    String? shopUrl,
    String? logoUrl,
    String? businessName,
    String? contact,
    String? secondContact,
    String? email,
    String? selectedShopType,
    String? secondContactName,
    String? secContact,
    String? secSecContact,
    String? secEmail,
    String? shopAddress,
    String? landmark,
    String? accountName,
    int? accountNumber,
    String? mobileMoneyName,
    String? mobileMoneyNumber,
    String? selectedcourierServices,
    String? specialRequirements,
    GeoPoint? geoLocation,
  }) {
    if (shopUrl != null) {
      vendorData!["shopUrl"] = shopUrl;
    }

    if (logoUrl != null) {
      vendorData!["logoUrl"] = logoUrl;
    }
    if (businessName != null) {
      vendorData!["businessName"] = businessName;
    }
    if (contact != null) {
      vendorData!["contact"] = contact;
    }
    if (secondContact != null) {
      vendorData!["secondContact"] = secondContact;
    }
    if (email != null) {
      vendorData!["email"] = email;
    }
    if (selectedShopType != null) {
      vendorData!["selectedShopType"] = selectedShopType;
    }
    if (secondContactName != null) {
      vendorData!["secondContactName"] = secondContactName;
    }
    if (secContact != null) {
      vendorData!["secContact"] = secContact;
    }
    if (secSecContact != null) {
      vendorData!["secSecContact"] = secSecContact;
    }
    if (secEmail != null) {
      vendorData!["secEmail"] = secEmail;
    }
    if (shopAddress != null) {
      vendorData!["shopAddress"] = shopAddress;
    }
    if (landmark != null) {
      vendorData!["landmark"] = landmark;
    }
     if (geoLocation != null) {
      vendorData!["geoLocation"] = geoLocation;
    }
    if (accountName != null) {
      vendorData!["accountName"] = accountName;
    }
    if (accountNumber != null) {
      vendorData!["accountNumber"] = accountNumber;
    }
    if (mobileMoneyName != null) {
      vendorData!["mobileMoneyName"] = mobileMoneyName;
    }
    if (mobileMoneyNumber != null) {
      vendorData!["mobileMoneyNumber"] = mobileMoneyNumber;
    }
    if (selectedcourierServices != null) {
      vendorData!["selectedcourierServices"] = selectedcourierServices;
    }
    if (specialRequirements != null) {
      vendorData!["specialRequirements"] = specialRequirements;
    }
    update();
  }
}
