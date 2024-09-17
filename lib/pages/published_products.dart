import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:vendor/pages/product_details_screen.dart';

class PublishedProducts extends StatefulWidget {
  const PublishedProducts({super.key});

  @override
  State<PublishedProducts> createState() => _PublishedProductsState();
}

class _PublishedProductsState extends State<PublishedProducts> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: REdgeInsets.all(16.0),
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
                      .collection('products')
                      .doc(auth.currentUser!.uid)
                      .collection("vendor_products")
                      .where("approved", isEqualTo: true)
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection('products')
                      .doc(auth.currentUser!.uid)
                      .collection("vendor_products")
                      .where("approved", isEqualTo: true)
                      .where('productName',
                          isGreaterThanOrEqualTo: _searchQuery)
                      .where('productName', isLessThan: '${_searchQuery}z')
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

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final data =
                              documents[index].data() as Map<String, dynamic>;
                          QueryDocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];
                          String docId = documentSnapshot.reference.id;

                          return Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  flex: 1,
                                  onPressed: (context) {
                                    _showDialog(
                                        context: context,
                                        docId: docId,
                                        label: "Delete");
                                  },
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                                SlidableAction(
                                  flex: 1,
                                  onPressed: (context) {
                                    _showDialog(
                                        context: context,
                                        docId: docId,
                                        label: "Disapprove");
                                  },
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  icon: Icons.approval,
                                  label: 'Disapprove',
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () {
                                Get.to(() => ProductDetailsPage(
                                      docId: docId,
                                    ));
                              },
                              child: Card(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: 80.h,
                                        width: 80.w,
                                        child: CachedNetworkImage(
                                          imageUrl: data["productUrls"][0],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(data["productName"]),
                                          Text(
                                              "GHS${data["productPrice"].toString()}"),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDialog(
      {String? docId,
      required BuildContext context,
      required String label}) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$label Update'),
          content: Text('Do you want to $label this item?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (label == 'Disapprove') {
                  await FirebaseFirestore.instance
                      .collection('products')
                      .doc(auth.currentUser!.uid)
                      .collection("vendor_products")
                      .doc(docId!)
                      .update({'approved': false});
                } else if (label == 'Delete') {
                  await FirebaseFirestore.instance
                      .collection('products')
                      .doc(auth.currentUser!.uid)
                      .collection("vendor_products")
                      .doc(docId!)
                      .delete();
                }
                Get.back();
              },
              child: Text(label),
            ),
          ],
        );
      },
    );
  }
}
