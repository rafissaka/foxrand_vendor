import 'package:cloud_firestore/cloud_firestore.dart';

class Vendor {
  bool? approved;
  bool? active;
  String? downloadURL;
  String? logoDownloadURL;
  String? businessName;
  String? contact;
  String? secondContact;
  String? email;
  String? selectedShopType;
  String? secondContactName;
  String? secContact;
  String? secSecContact;
  String? secEmail;
  String? shopAddress;
  String? landmark;
  String? accountName;
  int? accountNumber;
  String? mobileMoneyName;
  String? mobileMoneyNumber;
  String? selectedcourierServices;
  String? specialRequirements;
  GeoPoint? geoLocation;
  String? token;
  String? uid;

  Vendor(
      {this.downloadURL,
      this.logoDownloadURL,
      this.businessName,
      this.contact,
      this.secondContact,
      this.email,
      this.selectedShopType,
      this.secondContactName,
      this.secContact,
      this.secSecContact,
      this.secEmail,
      this.shopAddress,
      this.landmark,
      this.accountName,
      this.accountNumber,
      this.mobileMoneyName,
      this.mobileMoneyNumber,
      this.selectedcourierServices,
      this.specialRequirements,
      this.geoLocation,
      this.token,
      this.uid,
      this.active,
      this.approved});

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
        downloadURL: json['shopUrl'] as String?,
        logoDownloadURL: json['logoUrl'] as String?,
        businessName: json['businessName'] as String?,
        contact: json['personalContact'] as String?,
        secondContact: json['secondContact'] as String?,
        email: json['email'] as String?,
        selectedShopType: json['selectedShopType'] as String?,
        secondContactName: json['secondContactName'] as String?,
        secContact: json['secondContactNumber'] as String?,
        secSecContact: json['secondContactTwo'] as String?,
        secEmail: json['secondEmail'] as String?,
        shopAddress: json['shopAddress'] as String?,
        landmark: json['landmark'] as String?,
        accountName: json['accountName'] as String?,
        accountNumber: json['accountNumber'] as int?,
        mobileMoneyName: json['mobileMoneyName'] as String?,
        mobileMoneyNumber: json['mobileMoneyNumber'] as String?,
        selectedcourierServices: json['selectedcourierServices'] as String?,
        specialRequirements: json['specialRequirements'] as String?,
        geoLocation: json['geoLocation'] != null
            ? GeoPoint(
                (json['geoLocation'] as GeoPoint).latitude,
                (json['geoLocation'] as GeoPoint).longitude,
              )
            : null,
        token: json['token'] as String?,
        uid: json['uid'] as String?,
        approved: json['approved'] as bool?,
        active: json['active'] as bool?
        );
  }
}
