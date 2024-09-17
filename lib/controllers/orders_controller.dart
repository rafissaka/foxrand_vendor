// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:vendor/models/client_models.dart';
// import 'package:vendor/models/order_models.dart';

// class OrderController extends GetxController {
//   var isLoading = false.obs; // RxBool for loading state

//   Future<List<FoodOrder>> fetchOrdersBySeller(String seller) async {
//     isLoading.value = true;
//     try {
//       QuerySnapshot<Map<String, dynamic>> snapshot =
//           await FirebaseFirestore.instance.collectionGroup('user_orders').get();

//       List<FoodOrder> orders = [];

//       for (var doc in snapshot.docs) {
//         final data = doc.data();
//         final items = data['items'] as List<dynamic>;
//         if (kDebugMode) {
//           print('Document data: $data');
//         }
//         if (items.any((item) => item['seller'] == seller)) {
//           FoodOrder order = FoodOrder.fromFirestore(data, doc.id);
//           orders.add(order);
//         }
//       }

//       if (kDebugMode) {
//         print('Fetched ${orders.length} orders for seller: $seller');
//       }

//       return orders;
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error fetching orders for seller: $e');
//       }
//       return [];
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<Client?> fetchClientByUserId(String userId) async {
//     try {
//       DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
//           .instance
//           .collection('clients')
//           .doc(userId)
//           .get();

//       if (snapshot.exists) {
//         return Client.fromFirestore(snapshot.data()!);
//       } else {
//         if (kDebugMode) {
//           print('Client not found for userId: $userId');
//         }
//         return null;
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error fetching client for userId: $e');
//       }
//       return null;
//     } finally {}
//   }

//   Future<void> updateOrderStatus(
//       {String? userId, String? docId, String? status}) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('food_orders')
//           .doc(userId)
//           .collection("user_orders")
//           .doc(docId)
//           .update({'status': status});
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error updating order status: $e');
//       }
//     } finally {}
//   }

//   Future<void> makePhoneCall(String phoneNumber) async {
//     final Uri launchUri = Uri(
//       scheme: 'tel',
//       path: phoneNumber,
//     );
//     await launchUrl(launchUri);
//   }
// }
