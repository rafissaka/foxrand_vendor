import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import '../controllers/user_controller.dart';
import '../widgets/custom_drawer_nav.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
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
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 140.w,
                    height: 29.h,
                    child: Text(
                      'Order History',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.2000000477.h,
                        color: const Color(0xfffe724c),
                      ),
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Container(
                              width: 328.w,
                              height: 100.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffffffff),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x3f000000),
                                    offset: Offset(0, 4),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 91.w,
                                    height: 88.h,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(items[index]),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 26.w, 4),
                                    width: 128.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Order No. #SD326',
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w600,
                                            height: 1.6.h,
                                            color: const Color(0xfffe724c),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 128.w,
                                          height: 20.h,
                                          child: Text(
                                            'Ground Beef Tacos',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              height: 1.3333333333.h,
                                              color: const Color(0xff212529),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 80.w,
                                          height: 20.h,
                                          child: Text(
                                            '... MyChef’s Space',
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w300,
                                              height: 2.h,
                                              color: const Color(0xff797979),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 131.w,
                                          height: 21.h,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 1.h, 4.w, 0),
                                                child: Text(
                                                  'Unsuccessful Order',
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.6666666667.h,
                                                    color:
                                                        const Color(0xff212529),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 1.h),
                                                width: 11.w,
                                                height: 11.h,
                                                child: Image.asset(
                                                  'images/check.png',
                                                  width: 11,
                                                  height: 11,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 51.w,
                                              height: 16.h,
                                              child: Text(
                                                'GH₵299.83',
                                                style: GoogleFonts.inter(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.6.h,
                                                  color:
                                                      const Color(0xff212529),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Image.asset("images/sstar.png"),
                                                SizedBox(
                                                  width: 12.w,
                                                  height: 10.h,
                                                  child: Text(
                                                    '4.6',
                                                    style: TextStyle(
                                                      fontSize: 8.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.2125.h,
                                                      color: const Color(
                                                          0xff999999),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 0, 0.h),
                                        width: 85.w,
                                        height: 85.h,
                                        child: Image.asset(
                                          'images/person.png',
                                          width: 85.w,
                                          height: 85.h,
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0.h, 1.w, 0),
                                        child: Text(
                                          'Kofi Amoah',
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2125.h,
                                            color: const Color(0xff029094),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                        );
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
