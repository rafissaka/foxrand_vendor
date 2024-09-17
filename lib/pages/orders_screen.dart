import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
// import 'package:vendor/controllers/orders_controller.dart';
// import 'package:vendor/models/client_models.dart';
// import 'package:vendor/models/order_models.dart';
import '../controllers/user_controller.dart';
import '../widgets/custom_drawer_nav.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool isOpened = false;

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();

  toggleMenu([bool end = false]) {
    if (end) {
      final state = _endSideMenuKey.currentState!;
      if (state.isOpened) {
        state.closeSideMenu();
      } else {
        state.openSideMenu();
      }
    } else {
      final state = _sideMenuKey.currentState!;
      if (state.isOpened) {
        state.closeSideMenu();
      } else {
        state.openSideMenu();
      }
    }
  }

  UserController userController = Get.put(UserController());

  // @override
  // void initState() {
  //   userController.subscribeToUserChanges();
  //   fetchOrders();
  //   super.initState();
  // }

  // final OrderController orderController = Get.put(OrderController());
  // String selectedStatus = 'All';
  // List<FoodOrder> allOrders = [];
  // List<FoodOrder> filteredOrders = [];

  // void fetchOrders() async {
  //   final businessName = userController.user.value!.businessName;
  //   if (businessName != null) {
  //     allOrders = await orderController.fetchOrdersBySeller(businessName);
  //     if (kDebugMode) {
  //       print('Fetched ${allOrders.length} orders');
  //     }
  //     filterOrders();
  //   } else {
  //     if (kDebugMode) {
  //       print('Business name is null');
  //     }
  //   }
  // }

  // void filterOrders() {
  //   if (selectedStatus == 'All') {
  //     filteredOrders = allOrders;
  //   } else {
  //     filteredOrders =
  //         allOrders.where((order) => order.status == selectedStatus).toList();
  //   }
  //   setState(() {
  //     if (kDebugMode) {
  //       print(
  //           'Filtered ${filteredOrders.length} orders with status: $selectedStatus');
  //     }
  //   });
  // }

  // void onStatusSelected(String status) {
  //   setState(() {
  //     selectedStatus = status;
  //     filterOrders();
  //   });
  // }

  // String dateTimeToWords(String dateTimeString) {
  //   // Parse the dateTimeString to a DateTime object
  //   DateTime dateTime = DateTime.parse(dateTimeString);

  //   // Format the date and time to words
  //   String formattedDate = DateFormat('EEEE, MMMM d, yyyy').format(dateTime);
  //   String formattedTime = DateFormat('h:mm a').format(dateTime);

  //   return '$formattedDate at $formattedTime';
  // }

  // Map<String, Color> statusColors = {
  //   'Pending': Colors.orange,
  //   'Accepted': Colors.green,
  //   'Rejected': Colors.red,
  //   'On the Way': Colors.blue,
  //   'Delivered': Colors.purple,
  // };

  // Map<String, IconData> statusIcons = {
  //   'Pending': Icons.pending,
  //   'Accepted': Icons.check_circle,
  //   'Rejected': Icons.cancel,
  //   'On the Way': Icons.directions_bike,
  //   'Delivered': Icons.local_shipping,
  // };

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      background: const Color(0xffffffff),
      key: _sideMenuKey,
      menu: const Nav(),
      type: SideMenuType.slideNRotate,
      onChange: (isOpened) {
        setState(() => isOpened = isOpened);
      },
      child: IgnorePointer(
        ignoring: isOpened,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Column(children: [
              Obx(() {
                return SizedBox(
                  width: 140.w,
                  height: 26.h,
                  child: Text(
                    userController.user.value!.businessName!,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.2575.h,
                      color: const Color(0xff000000),
                    ),
                  ),
                );
              }),
              SizedBox(
                width: 189.w,
                height: 16.h,
                child: Text(
                  'Home Cook • Fast food • Local • Wines',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.6.h,
                    color: const Color(0xff797878),
                  ),
                ),
              ),
            ]),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.menu,
              ),
              onPressed: () {
                toggleMenu();
              },
            ),
            actions: [
              Obx(() {
                return Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 5.w, 0),
                  width: 44.w,
                  height: 44.h,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  child: CachedNetworkImage(
                    placeholder: (context, url) => const AspectRatio(
                      aspectRatio: 1.6,
                      child: BlurHash(hash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                    ),
                    imageUrl: userController.user.value!.logoDownloadURL!,
                    fit: BoxFit.fill,
                  ),
                );
              }),
            ],
            flexibleSpace: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(userController.user.value!
                          .downloadURL!), // Replace with your background image asset
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  color: Colors.white
                      .withOpacity(0.7), // Adjust the opacity as needed
                ),
              ],
            ),
          ),
          // body: Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: SingleChildScrollView(
          //           scrollDirection: Axis.horizontal,
          //           child: Row(
          //             children: [
          //               ChoiceChip(
          //                 label: const Text('All'),
          //                 selected: selectedStatus == 'All',
          //                 onSelected: (_) => onStatusSelected('All'),
          //               ),
          //               const SizedBox(width: 8),
          //               ChoiceChip(
          //                 label: const Text('Pending'),
          //                 selected: selectedStatus == 'Pending',
          //                 onSelected: (_) => onStatusSelected('Pending'),
          //               ),
          //               const SizedBox(width: 8),
          //               ChoiceChip(
          //                 label: const Text('Accepted'),
          //                 selected: selectedStatus == 'Accepted',
          //                 onSelected: (_) => onStatusSelected('Accepted'),
          //               ),
          //               const SizedBox(width: 8),
          //               ChoiceChip(
          //                 label: const Text('Rejected'),
          //                 selected: selectedStatus == 'Rejected',
          //                 onSelected: (_) => onStatusSelected('Rejected'),
          //               ),
          //               const SizedBox(width: 8),
          //               ChoiceChip(
          //                 label: const Text('On the Way'),
          //                 selected: selectedStatus == 'On the Way',
          //                 onSelected: (_) => onStatusSelected('On the Way'),
          //               ),
          //               const SizedBox(width: 8),
          //               ChoiceChip(
          //                 label: const Text('Delivered'),
          //                 selected: selectedStatus == 'Delivered',
          //                 onSelected: (_) => onStatusSelected('Delivered'),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //       Expanded(
          //         child: filteredOrders.isEmpty
          //             ? Center(
          //                 child: Text(
          //                   'No items yet in $selectedStatus status',
          //                   style: TextStyle(
          //                     fontSize: 18.sp,
          //                     fontWeight: FontWeight.w500,
          //                     color: Colors.grey,
          //                   ),
          //                 ),
          //               )
          //             : ListView.builder(
          //                 shrinkWrap: true,
          //                 itemCount: filteredOrders.length,
          //                 itemBuilder: (context, index) {
          //                   final order = filteredOrders[index];
          //                   final orderDate =
          //                       dateTimeToWords(order.dateOfOrder);

          //                   Color color =
          //                       statusColors[order.status] ?? Colors.grey;
          //                   IconData icon =
          //                       statusIcons[order.status] ?? Icons.help_outline;

          //                   return Container(
          //                     margin: const EdgeInsets.only(top: 5, bottom: 5),
          //                     decoration: BoxDecoration(
          //                         border: Border.all(color: color),
          //                         borderRadius: BorderRadius.circular(5)),
          //                     child: Column(children: [
          //                       ListTile(
          //                         leading: Icon(
          //                           icon,
          //                           color: color,
          //                         ),
          //                         title: Text(
          //                           order.status,
          //                           style: TextStyle(
          //                               color: color,
          //                               fontWeight: FontWeight.bold),
          //                         ),
          //                         subtitle: Text('On $orderDate'),
          //                         trailing: Column(
          //                           crossAxisAlignment:
          //                               CrossAxisAlignment.start,
          //                           children: [
          //                             Text(order.paymentMethod),
          //                             Text(
          //                                 'GH₵${order.total.toStringAsFixed(0)}',
          //                                 style: GoogleFonts.inter()),
          //                           ],
          //                         ),
          //                       ),
          //                       ExpansionTile(
          //                         shape: const Border(),
          //                         title: const Text("View Orders"),
          //                         children: order.items.map((item) {
          //                           return Column(
          //                             children: [
          //                               ListTile(
          //                                 title: Text(
          //                                   item.foodName,
          //                                   style: const TextStyle(
          //                                       fontSize: 18,
          //                                       fontWeight: FontWeight.bold),
          //                                 ),
          //                                 subtitle: Column(
          //                                   crossAxisAlignment:
          //                                       CrossAxisAlignment.start,
          //                                   children: [
          //                                     const SizedBox(height: 8),
          //                                     CachedNetworkImage(
          //                                       imageUrl: item.foodUrl,
          //                                       placeholder: (context, url) =>
          //                                           const Center(
          //                                               child:
          //                                                   CircularProgressIndicator()),
          //                                       errorWidget:
          //                                           (context, url, error) =>
          //                                               const Icon(Icons.error),
          //                                       height: 100,
          //                                       fit: BoxFit.cover,
          //                                     ),
          //                                     const SizedBox(height: 8),
          //                                     Text(
          //                                       'Price: GH₵${item.price} x ${item.quantity} = GH₵${item.price * item.quantity} ',
          //                                       style: GoogleFonts.inter(),
          //                                     ),
          //                                     const SizedBox(height: 8),
          //                                     const Text(
          //                                       'Addons:',
          //                                       style: TextStyle(
          //                                           fontWeight:
          //                                               FontWeight.bold),
          //                                     ),
          //                                     Column(
          //                                       crossAxisAlignment:
          //                                           CrossAxisAlignment.start,
          //                                       children:
          //                                           item.addons.map((addon) {
          //                                         return Padding(
          //                                           padding: const EdgeInsets
          //                                               .symmetric(
          //                                               vertical: 4.0),
          //                                           child: Text(
          //                                             '${addon.name}: GH₵${addon.price.toStringAsFixed(0)} x ${item.quantityOfAddons} = GH₵ ${addon.price.toStringAsFixed(0) * item.quantityOfAddons}',
          //                                             style:
          //                                                 GoogleFonts.inter(),
          //                                           ),
          //                                         );
          //                                       }).toList(),
          //                                     ),
          //                                   ],
          //                                 ),
          //                               ),
          //                               FutureBuilder<Client?>(
          //                                 future: orderController
          //                                     .fetchClientByUserId(
          //                                         order.userId),
          //                                 builder: (context, snapshot) {
          //                                   if (snapshot.connectionState ==
          //                                       ConnectionState.waiting) {
          //                                     return const Center(
          //                                         child:
          //                                             CircularProgressIndicator());
          //                                   } else if (snapshot.hasError) {
          //                                     return Text(
          //                                         'Error: ${snapshot.error}');
          //                                   } else if (!snapshot.hasData) {
          //                                     return const Text(
          //                                         'Client not found');
          //                                   } else {
          //                                     final client = snapshot.data!;
          //                                     return Padding(
          //                                       padding:
          //                                           const EdgeInsets.all(8.0),
          //                                       child: Row(
          //                                         crossAxisAlignment:
          //                                             CrossAxisAlignment.start,
          //                                         mainAxisAlignment:
          //                                             MainAxisAlignment.start,
          //                                         children: [
          //                                           const SizedBox(
          //                                             width: 10,
          //                                           ),
          //                                           CircleAvatar(
          //                                               radius: 35,
          //                                               child: ClipRRect(
          //                                                 borderRadius:
          //                                                     BorderRadius
          //                                                         .circular(50),
          //                                                 child:
          //                                                     CachedNetworkImage(
          //                                                   imageUrl: client
          //                                                       .profilePic,
          //                                                   width: 68,
          //                                                   height: 68,
          //                                                   fit: BoxFit.fill,
          //                                                 ),
          //                                               )),
          //                                           const SizedBox(
          //                                             width: 10,
          //                                           ),
          //                                           Column(
          //                                             crossAxisAlignment:
          //                                                 CrossAxisAlignment
          //                                                     .start,
          //                                             children: [
          //                                               Text(client.name),
          //                                               Row(
          //                                                 children: [
          //                                                   ElevatedButton.icon(
          //                                                       onPressed: () {
          //                                                         orderController
          //                                                             .makePhoneCall(
          //                                                                 client
          //                                                                     .contactNumber);
          //                                                       },
          //                                                       icon: const Icon(
          //                                                           Icons.call),
          //                                                       label:
          //                                                           const Text(
          //                                                               "Call")),
          //                                                   const SizedBox(
          //                                                     width: 5,
          //                                                   ),
          //                                                 ],
          //                                               ),
          //                                             ],
          //                                           )
          //                                         ],
          //                                       ),
          //                                     );
          //                                   }
          //                                 },
          //                               ),
          //                             ],
          //                           );
          //                         }).toList(),
          //                       ),
          //                       order.status == "Pending"
          //                           ? Container(
          //                               margin: const EdgeInsets.all(5),
          //                               decoration: const BoxDecoration(
          //                                   color: Color.fromARGB(
          //                                       255, 208, 207, 207)),
          //                               child: Row(
          //                                 mainAxisAlignment:
          //                                     MainAxisAlignment.spaceEvenly,
          //                                 children: [
          //                                   const SizedBox(
          //                                     width: 5,
          //                                   ),
          //                                   Expanded(
          //                                     child: ElevatedButton(
          //                                       onPressed: () {
          //                                         _showConfirmationDialog(
          //                                             context: context,
          //                                             title: 'Confirm Accept',
          //                                             content:
          //                                                 'Are you sure you want to accept this order?',
          //                                             onConfirm: () async {
          //                                               orderController
          //                                                   .updateOrderStatus(
          //                                                       userId: order
          //                                                           .userId,
          //                                                       docId:
          //                                                           order.docId,
          //                                                       status:
          //                                                           "Accepted");
          //                                               fetchOrders(); // Refresh the orders list
          //                                               Get.back();
          //                                               ScaffoldMessenger.of(
          //                                                       context)
          //                                                   .showSnackBar(
          //                                                 const SnackBar(
          //                                                     content: Text(
          //                                                         'Order accepted successfully!')),
          //                                               );
          //                                             });
          //                                       },
          //                                       style: ElevatedButton.styleFrom(
          //                                         shape: RoundedRectangleBorder(
          //                                           borderRadius:
          //                                               BorderRadius.circular(
          //                                                   4.0), // Adjust the radius as needed
          //                                         ),
          //                                         foregroundColor: Colors.black,
          //                                         backgroundColor: Colors
          //                                             .blueGrey, // Background color
          //                                       ),
          //                                       child: const Text('Accept'),
          //                                     ),
          //                                   ),
          //                                   const SizedBox(
          //                                     width: 5,
          //                                   ),
          //                                   Expanded(
          //                                     child: ElevatedButton(
          //                                       onPressed: () {
          //                                         _showConfirmationDialog(
          //                                             context: context,
          //                                             title: 'Confirm Reject',
          //                                             content:
          //                                                 'Are you sure you want to reject this order?',
          //                                             onConfirm: () async {
          //                                               orderController
          //                                                   .updateOrderStatus(
          //                                                       userId: order
          //                                                           .userId,
          //                                                       docId:
          //                                                           order.docId,
          //                                                       status:
          //                                                           "Rejected");
          //                                               fetchOrders();
          //                                               Get.back();
          //                                               ScaffoldMessenger.of(
          //                                                       context)
          //                                                   .showSnackBar(
          //                                                 const SnackBar(
          //                                                     content: Text(
          //                                                         'Order rejected successfully!')),
          //                                               );
          //                                             });
          //                                       },
          //                                       style: ElevatedButton.styleFrom(
          //                                         shape: RoundedRectangleBorder(
          //                                           borderRadius:
          //                                               BorderRadius.circular(
          //                                                   4.0), // Adjust the radius as needed
          //                                         ),
          //                                         foregroundColor: Colors.black,
          //                                         backgroundColor: Colors
          //                                             .red, // Background color
          //                                       ),
          //                                       child: const Text('Reject'),
          //                                     ),
          //                                   ),
          //                                   const SizedBox(
          //                                     width: 5,
          //                                   ),
          //                                 ],
          //                               ),
          //                             )
          //                           : const SizedBox.shrink()
          //                     ]),
          //                   );
          //                 },
          //               ),
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }

  Future<void> _showConfirmationDialog(
      {required BuildContext context,
      required String title,
      required String content,
      required VoidCallback onConfirm}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(content),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              onPressed: onConfirm,
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}
