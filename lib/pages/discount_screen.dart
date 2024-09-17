import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';


import '../controllers/user_controller.dart';
import '../widgets/custom_drawer_nav.dart';

class DiscountPage extends StatefulWidget {
  const DiscountPage({super.key});

  @override
  State<DiscountPage> createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
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

  final List<String> items = [
    "images/pizza1.png",
    "images/pizza2.png",
    "images/pizza3.png"
  ];

  final List<String> itemNames = [
    "Pepperoni Pizza",
    "Meat Pizza",
    "Ground Beef Tacos"
  ];
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: ListView(children: [
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discounts and \nPromotion',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.2000000477.h,
                      color: const Color(0xfffe724c),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      'For all Product..',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.2000000477.h,
                        color: const Color.fromARGB(255, 255, 186, 168),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .6,
              ),
              itemBuilder: (BuildContext context, int index) {
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
                        Container(
                          width: double.infinity,
                          height: 159.5.h,
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
                              width: 165.w,
                              height: 159.h,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                child: Image.asset(items[index]),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(10.w, 3.h, 0.w, 0),
                          width: 113.w,
                          height: 20.h,
                          child: Text(
                            itemNames[index],
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              height: 1.3333333333.h,
                              color: const Color(0xff212529),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ]),
        ),
      ),
    );
  }
}
