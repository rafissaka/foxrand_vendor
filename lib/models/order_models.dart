// import 'package:vendor/models/addon_models.dart';
// import 'package:cloud_firestore/cloud_firestore.dart'; // Import for GeoPoint

// class FoodOrder {
//   String docId;
//   String userId;
//   String status;
//   String paymentstatus;
//   String paymentMethod;
//   String deliveryAddress;
//   String orderId;
//   String type;
//   double deliveryFee;
//   double total;
//   List<FoodCartItem> items;
//   String processTime;
//   String dateOfOrder;
//   String estimateArrival;
//   List<GeoPoint> locations; // New field for locations

//   FoodOrder({
//     required this.docId,
//     required this.userId,
//     required this.status,
//     required this.paymentstatus,
//     required this.paymentMethod,
//     required this.deliveryAddress,
//     required this.orderId,
//     required this.type,
//     required this.deliveryFee,
//     required this.total,
//     required this.items,
//     required this.processTime,
//     required this.dateOfOrder,
//     required this.estimateArrival,
//     required this.locations, // New field initialization
//   });

//   factory FoodOrder.fromFirestore(Map<String, dynamic> data, String docId) {
//     return FoodOrder(
//       docId: docId,
//       userId: data['userId'] ?? '',
//       status: data['status'] ?? '',
//       paymentstatus: data['paymentstatus'] ?? '',
//       paymentMethod: data['paymentMethod'] ?? '',
//       deliveryAddress: data['deliveryAddress'] ?? '',
//       orderId: data['orderId'] ?? '',
//       type: data['type'] ?? '',
//       deliveryFee: (data['deliveryFee'] ?? 0).toDouble(),
//       total: (data['total'] ?? 0).toDouble(),
//       items: (data['items'] as List<dynamic>?)
//               ?.map((item) => FoodCartItem.fromJson(item))
//               .toList() ??
//           [],
//       processTime: data['processTime'] ?? '',
//       dateOfOrder: data['dateOfOrder'] ?? '',
//       estimateArrival: data['estimateArrival'] ?? '',
//       locations: (data['locations'] as List<dynamic>?)
//               ?.map((location) => GeoPoint(location['latitude'], location['longitude']))
//               .toList() ??
//           [], // Handling locations field
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'docId': docId,
//       'userId': userId,
//       'status': status,
//       'paymentstatus': paymentstatus,
//       'paymentMethod': paymentMethod,
//       'deliveryAddress': deliveryAddress,
//       'orderId': orderId,
//       'type': type,
//       'deliveryFee': deliveryFee,
//       'total': total,
//       'items': items.map((item) => item!.toMap()).toList(),
//       'processTime': processTime,
//       'dateOfOrder': dateOfOrder,
//       'estimateArrival': estimateArrival,
//       'locations': locations.map((location) => {
//         'latitude': location.latitude,
//         'longitude': location.longitude
//       }).toList(), // Handling locations field
//     };
//   }

//   @override
//   String toString() {
//     return 'FoodOrder{docId: $docId, userId: $userId, status: $status, paymentstatus: $paymentstatus, type: $type, paymentMethod: $paymentMethod, deliveryAddress: $deliveryAddress, orderId: $orderId, deliveryFee: $deliveryFee, total: $total, items: ${items.map((item) => item.toString()).toList()}, processTime: $processTime, dateOfOrder: $dateOfOrder, estimateArrival: $estimateArrival, locations: ${locations.map((location) => '(${location.latitude}, ${location.longitude})').toList()}}';
//   }
// }
