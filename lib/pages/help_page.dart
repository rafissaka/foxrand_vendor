import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:vendor/pages/payment_pricing_screen.dart';


import '../controllers/user_controller.dart';
import '../widgets/custom_drawer_nav.dart';
import 'about_foxrand_screen.dart';
import 'account_data_screen.dart';
import 'app_features_screen.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
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

  @override
  void initState() {
    userController.subscribeToUserChanges();
    super.initState();
  }

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
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Column(children: [
            SizedBox(
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
            ),
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
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 5.w, 0),
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: CachedNetworkImage(
                placeholder: (context, url) => const AspectRatio(
                  aspectRatio: 1.6,
                  child: BlurHash(hash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                ),
                imageUrl: userController.user.value!.logoDownloadURL!,
                fit: BoxFit.fill,
              ),
            ),
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
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'How can we help you?',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.2125.h,
                  color: const Color(0xffFE724C),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Support cases',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.2125.h,
                  color: const Color(0xff636363),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              ListTile(
                  leading: Image.asset('images/chatt.png'),
                  title: Text(
                    "Chat with foxrand",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.2125.h,
                      color: const Color(0xff636363),
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios)),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 52.h,
                width: 305.h,
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.625.h,
                        color: const Color(0xfffe724c),
                      ),
                      children: [
                        TextSpan(
                          text: 'Terms and conditions',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            height: 1.625.h,
                            color: const Color(0xfffe724c),
                          ),
                        ),
                        TextSpan(
                          text: ' and ',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            height: 1.625.h,
                            color: const Color(0xff999999),
                          ),
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            height: 1.625.h,
                            color: const Color(0xfffe724c),
                          ),
                        ),
                        TextSpan(
                          text: ' For Vendors',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            height: 1.625.h,
                            color: const Color(0xff999999),
                          ),
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'Get help with a recent ride',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.2125.h,
                  color: const Color(0xff636363),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              ListTile(
                  onTap: () {
                    Get.to(() => const AboutFoxarand());
                  },
                  title: Text(
                    "About Foxrand",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.2125.h,
                      color: const Color(0xff777777),
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      color: Color(0xff989898))),
              Padding(
                padding: EdgeInsets.fromLTRB(15.w, 0, 10.w, 0),
                child: const Divider(
                  thickness: 1,
                  color: Color(0xffD6D6D6),
                ),
              ),
              ListTile(
                  onTap: () {
                    Get.to(() => const AppAndFeaturesScreen());
                  },
                  title: Text(
                    "App and features",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.2125.h,
                      color: const Color(0xff777777),
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      color: Color(0xff989898))),
              Padding(
                padding: EdgeInsets.fromLTRB(15.w, 0, 10.w, 0),
                child: const Divider(
                  thickness: 1,
                  color: Color(0xffD6D6D6),
                ),
              ),
              ListTile(
                  onTap: () {
                    Get.to(() => const AccountDataScreen());
                  },
                  title: Text(
                    "Account and data",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.2125.h,
                      color: const Color(0xff777777),
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      color: Color(0xff989898))),
              Padding(
                padding: EdgeInsets.fromLTRB(15.w, 0, 10.w, 0),
                child: const Divider(
                  thickness: 1,
                  color: Color(0xffD6D6D6),
                ),
              ),
              ListTile(
                  onTap: () {
                    Get.to(() => const PaymentAndPricingScreen());
                  },
                  title: Text(
                    "Payments and pricing",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.2125.h,
                      color: const Color(0xff777777),
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      color: Color(0xff989898))),
              Padding(
                padding: EdgeInsets.fromLTRB(15.w, 0, 10.w, 0),
                child: const Divider(
                  thickness: 1,
                  color: Color(0xffD6D6D6),
                ),
              ),
              ListTile(
                  title: Text(
                    "Using Foxrand",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.2125.h,
                      color: const Color(0xff777777),
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      color: Color(0xff989898))),
            ]),
          ),
        ),
      ),
    );
  }
}
