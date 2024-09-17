import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:vendor/controllers/user_controller.dart';

import '../widgets/custom_drawer_nav.dart';

class AppAndFeaturesScreen extends StatefulWidget {
  const AppAndFeaturesScreen({super.key});

  @override
  State<AppAndFeaturesScreen> createState() => _AppAndFeaturesScreenState();
}

class _AppAndFeaturesScreenState extends State<AppAndFeaturesScreen> {
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
                'App and features',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.2125.h,
                  color: const Color(0xffFE724C),
                ),
              ),
              SizedBox(
                height: 35.h,
              ),
              ListTile(
                  title: Text(
                    "How to add a discounts and promotions",
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
                    "How to change the destination",
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
                    "How to get a price estimate",
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
                    "How to cancel a ride",
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
                    "How to tip my driver",
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
                    "How to order a ride",
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
                    "Managing app notifications",
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
                    "Account balance",
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
                    "How to change app language",
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
                    "Downloading the Foxrand app",
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
