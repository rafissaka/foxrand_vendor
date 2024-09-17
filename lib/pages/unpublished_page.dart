import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vendor/pages/food_details_screen.dart';

class UnPublishedPage extends StatefulWidget {
  const UnPublishedPage({super.key});

  @override
  State<UnPublishedPage> createState() => _UnPublishedPageState();
}

class _UnPublishedPageState extends State<UnPublishedPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: (_searchQuery.isEmpty)
                  ? FirebaseFirestore.instance
                      .collection('foods')
                      .doc(auth.currentUser!.uid)
                      .collection("vendor_foods")
                      .where("approved", isEqualTo: false)
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection('foods')
                      .doc(auth.currentUser!.uid)
                      .collection("vendor_foods")
                      .where("approved", isEqualTo: false)
                      .where('foodName', isGreaterThanOrEqualTo: _searchQuery)
                      .where('foodName', isLessThan: '${_searchQuery}z')
                      .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No data available'));
                } else {
                  final documents = snapshot.data!.docs;
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .65,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final data =
                          documents[index].data() as Map<String, dynamic>;
                      QueryDocumentSnapshot documentSnapshot =
                          snapshot.data!.docs[index];
                      String docId = documentSnapshot.reference.id;

                      return Padding(
                        padding: const EdgeInsets.all(6),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xfff9fafb),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x28000000),
                                offset: Offset(0, 4),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(() => FoodDetailsScreen(
                                        docId: docId,
                                      ));
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: screenHeight * 0.1895.h,
                                  decoration: const BoxDecoration(
                                    color: Color(0xfff4faff),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x14000000),
                                        offset: Offset(0, 4),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        child: Image.network(
                                          data["foodUrl"],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10.w, 3.h, 0.w, 0),
                                width: 113.w,
                                height: 20.h,
                                child: Text(
                                  data["foodName"],
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    height: 1.3333333333.h,
                                    color: const Color(0xff212529),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0.w, 3.h, 0.w, 0),
                                width: double.infinity,
                                height: screenHeight * 0.07.h,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          10.w, 3.h, 0.w, 0),
                                      child: Text(
                                        ".....${data["seller"]}",
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            color: Colors.grey),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          10.w, 3.h, 0.w, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset("images/cart.png"),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              const Text(
                                                "534",
                                                style: TextStyle(
                                                    color: Color(0xffFE724C)),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Image.asset("images/sss.png"),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              const Text(
                                                "4.5",
                                                style: TextStyle(
                                                    color: Color(0xffFE724C)),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Image.asset("images/vector.png"),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              const Text(
                                                "4422",
                                                style: TextStyle(
                                                    color: Color(0xffFE724C)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10.w, 3.h, 0.w, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Comments... (15)",
                                          style: TextStyle(
                                              color: Color(0xffFE724C)),
                                        ),
                                        InkWell(
                                            onTap: () {
                                              _showDialog(docId: docId);
                                            },
                                            child: const Icon(Icons.publish,
                                                color: Color(0xffFE724C)))
                                      ],
                                    ),
                                    Text(
                                      "GH₵${data["foodPrice"]}",
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDialog({String? docId}) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Publish Update'),
          content:
              const Text('Do you want to publish this item for users to see?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Update the approved field in the Firebase sub-collection
                await FirebaseFirestore.instance
                    .collection('foods')
                    .doc(auth.currentUser!.uid)
                    .collection('vendor_foods')
                    .doc(docId) // Replace with the actual document ID
                    .update({'approved': true});

                // Update the state using GetX

                Get.back(); // Close the dialog
              },
              child: const Text('Publish'),
            ),
          ],
        );
      },
    );
  }
}
