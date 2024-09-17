import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vendor/pages/landing_page_product.dart';

import '../controllers/user_controller.dart';
import '../pages/chat_bot_screen.dart';
import '../pages/dasbboard_page.dart';
import '../pages/discount_screen.dart';
import '../pages/help_page.dart';
import '../pages/orders_screen.dart';
import '../pages/profile_screen.dart';

class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  UserController userController = Get.put(UserController());

  @override
  void initState() {
    userController.subscribeToUserChanges();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: firestore
          .collection('vendors')
          .doc(auth.currentUser!.uid) // Replace with your user UID
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text('No data available'));
        }

        // Retrieve data from Firestore
        final data = snapshot.data!.data() as Map<String, dynamic>;

        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: SizedBox(
                          width: 150.w,
                          height: 150.h,
                          child: CachedNetworkImage(
                            placeholder: (context, url) => const AspectRatio(
                              aspectRatio: 1.6,
                              child: BlurHash(
                                  hash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                            ),
                            imageUrl: data["logoUrl"],
                            fit: BoxFit.fill,
                          )),
                    ),
                    SizedBox(height: 2.h),
                    SizedBox(
                      width: 200.w,
                      height: 50.h,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 180.w,
                            height: 26.h,
                            child: Text(
                              data["businessName"],
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                height: 1.2575.h,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 170.w,
                            height: 18.h,
                            child: Text(
                              '',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                height: 1.2575.h,
                                color: const Color(0xff9ea1b1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.0.h),
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  Get.offAll(() => const DashBoardScreen());
                },
                leading:
                    const Icon(Icons.home, size: 20.0, color: Colors.black),
                title: Text(
                  "Dashboard",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.2575.h,
                    color: const Color(0xff000000),
                  ),
                ),
                textColor: Colors.black,
                dense: true,
              ),
              ListTile(
                onTap: () {
                  Get.offAll(() => const OrdersPage());
                },
                leading:
                    const Icon(Icons.list, size: 20.0, color: Colors.black),
                title: Text(
                  "My Orders",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.2575.h,
                    color: const Color(0xff000000),
                  ),
                ),
                textColor: Colors.black,
                dense: true,
              ),
              ListTile(
                onTap: () {
                  Get.offAll(() => ProductFoodLandingPage(
                        shopType: data["shopType"],
                      ));
                },
                leading: const Icon(Icons.payments_rounded,
                    size: 20.0, color: Colors.black),
                title: Text(
                  "All Products",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.2575.h,
                    color: const Color(0xff000000),
                  ),
                ),
                textColor: Colors.black,
                dense: true,
              ),
              ListTile(
                onTap: () {
                  Get.offAll(() => const ProfileScreen());
                },
                leading:
                    const Icon(Icons.person, size: 20.0, color: Colors.black),
                title: Text(
                  "My Profile",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.2575.h,
                    color: const Color(0xff000000),
                  ),
                ),
                textColor: Colors.black,
                dense: true,
              ),
              ListTile(
                onTap: () {
                  Get.offAll(() => const DiscountPage());
                },
                leading: const Icon(Icons.format_indent_increase,
                    size: 20.0, color: Colors.black),
                title: Text(
                  "Discounts and promotion",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.2575.h,
                    color: const Color(0xff000000),
                  ),
                ),
                textColor: Colors.black,
                dense: true,
              ),
              ListTile(
                onTap: () {
                  Get.offAll(() => const ChatBotPage());
                },
                leading:
                    const Icon(Icons.chat, size: 20.0, color: Colors.black),
                title: Text(
                  "Foxrand Chatbox",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.2575.h,
                    color: const Color(0xff000000),
                  ),
                ),
                textColor: Colors.black,
                dense: true,
              ),
              ListTile(
                onTap: () {
                  Get.offAll(() => const HelpPage());
                },
                leading:
                    const Icon(Icons.help, size: 20.0, color: Colors.black),
                title: Text(
                  "Helps & FAQs",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.2575.h,
                    color: const Color(0xff000000),
                  ),
                ),
                textColor: Colors.black,
                dense: true,
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.exit_to_app,
                    size: 20.0, color: Colors.black),
                title: Text(
                  "Sign Out",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.2575.h,
                    color: const Color(0xff000000),
                  ),
                ),
                textColor: Colors.black,
                dense: true,
              ),
            ],
          ),
        );
      },
    );
  }
}
