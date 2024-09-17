// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

//Restaurant
class Foods {
  Foods(
      {this.approved,
      this.foodName,
      this.desc,
      this.foodCat,
      this.foodPrice,
      this.addOns,
      this.foodUrl});

  Foods.fromJson(Map<String, Object?> json)
      : this(
          approved: json["approved"] as bool,
          foodName:
              json["foodName"] == null ? null : json["foodName"] as String,
          desc: json["desc"] == null ? null : json["desc"] as String,
          foodCat: json["foodCat"] == null ? null : json["foodCat"] as String,
          foodPrice:
              json["foodPrice"] == null ? null : json["foodPrice"] as int,
          addOns: json["addOns"] == null ? null : json[""] as List,
          foodUrl: json["foodUrl"] == null ? null : json["foodUrls"] as String,
        );

  final bool? approved;
  final String? foodName;
  final String? desc;
  final String? foodCat;
  final int? foodPrice;
  final List? addOns;
  final String? foodUrl;

  Map<String, Object?> toJson() {
    return {
      "approved": approved,
      "foodName": foodName,
      "desc": desc,
      "foodCat": foodCat,
      "foodPrice": foodPrice,
      "addOns": addOns,
      "foodUrl": foodUrl
    };
  }
}

// final FirebaseAuth _auth = FirebaseAuth.instance;

// foodQuery(approved) {
//   return FirebaseFirestore.instance
//       .collection('foods')
//       .doc(_auth.currentUser!.uid)
//       .collection("vendor_foods")
//       .where("approved", isEqualTo: approved)
//       .orderBy('foodName')
//       .withConverter<Foods>(
//         fromFirestore: (snapshot, _) => Foods.fromJson(snapshot.data()!),
//         toFirestore: (user, _) => user.toJson(),
//       );
// }
