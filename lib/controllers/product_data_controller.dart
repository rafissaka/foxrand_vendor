import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_models.dart';

class ProductDataController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final Rx<Product?> product = Rx<Product?>(null);

  void getProduct(String docId) {
    _firestore
        .collection('products')
        .doc(auth.currentUser!.uid)
        .collection("vendor_products")
        .doc(docId)
        .get()
        .then((doc) {
      if (doc.exists) {
        var data = doc.data()!;
        product.value = Product(
          docId: docId,
          fragile: data['Fragible'],
          hazardous: data['Hazardousness'],
          colorAvailable: List<String>.from(data['colorAvailable']),
          currentHazardValue:
              double.parse(data['currentHazardValue'].toString()),
          currentSliderValue:
              double.parse(data['currentSliderValue'].toString()),
          productDesc: data['productDesc'],
          productName: data['productName'],
          productPrice: double.parse(data["productPrice"].toString()),
          productUrls: List<String>.from(data['productUrls']),
          selectedCategory: data['selectedCategory'],
          seller: data['seller'],
        );
      } else {
        product.value = null;
      }
    });
  }

  void listenToSubcollection(String docId) {
    _firestore
        .collection('products')
        .doc(auth.currentUser!.uid)
        .collection("vendor_products")
        .snapshots()
        .listen((snapshot) {
      for (var change in snapshot.docChanges) {
        var doc = change.doc;
        var docId = doc.id;
        var data = doc.data();
        if (change.type == DocumentChangeType.added) {
          // Handle added document
          if (kDebugMode) {
            print("Document added: $docId");
          }
        } else if (change.type == DocumentChangeType.modified) {
          // Handle modified document
          if (kDebugMode) {
            print("Document modified: $docId");
          }
          if (docId == product.value?.docId) {
            product.value = Product(
              docId: docId,
              fragile: data?['Fragible'] ?? false,
              hazardous: data?['Hazardousness'] ?? false,
              colorAvailable: List<String>.from(data?['colorAvailable'] ?? []),
              currentHazardValue:
                  double.parse(data!['currentHazardValue'].toString()),
              currentSliderValue:
                  double.parse(data['currentSliderValue'].toString()),
              productDesc: data['productDesc'] ?? '',
              productName: data['productName'] ?? '',
              productPrice: data['productPrice'],
              productUrls: List<String>.from(data['productUrls'] ?? []),
              selectedCategory: data['selectedCategory'] ?? '',
              seller: data['seller'] ?? '',
            );
          }
        } else if (change.type == DocumentChangeType.removed) {
          // Handle removed document
          if (kDebugMode) {
            print("Document removed: $docId");
          }
          if (docId == product.value?.docId) {
            product.value = null;
          }
        }
      }
    });
  }

  Future<void> updateColors(
      {required List<String> color, required String docId}) async {
    try {
      _firestore
          .collection('products')
          .doc(auth.currentUser!.uid)
          .collection("vendor_products")
          .doc(docId)
          .update({"colorAvailable": color});
    } catch (e) {
      if (kDebugMode) {
        print('Error Updating: $e');
      }
    }
  }

  Future<void> deleteColor(
      {required List<String> modifiedColorList, required String docId}) async {
    try {
      _firestore
          .collection('products')
          .doc(auth.currentUser!.uid)
          .collection("vendor_products")
          .doc(docId)
          .update({"colorAvailable": modifiedColorList});
    } catch (e) {
      if (kDebugMode) {
        print('Error Updating: $e');
      }
    }
  }
}
