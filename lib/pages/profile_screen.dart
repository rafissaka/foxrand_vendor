import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import '../controllers/user_controller.dart';
import '../widgets/custom_circular_button.dart';
import '../widgets/custom_drawer_nav.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    double screenHeight = MediaQuery.of(context).size.height;
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
          child: GetBuilder<UserController>(builder: (_) {
            if (_.user.value == null) {
              return const CustomCircularProgress(
                radius: 50.0,
                color: Colors.red,
                duration: Duration(seconds: 3),
              );
            } else if (_.user.value == null) {
              return const Text('User data not found.');
            } else {
              final user = _.user.value!;
              return Scaffold(
                body: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      title: const Text("My Profile"),
                      elevation: 0.0,
                      leading: InkWell(
                        onTap: () {
                          toggleMenu();
                        },
                        child: SizedBox(
                          width: 39.92.w,
                          height: 43.75.h,
                          child: Image.asset(
                            'images/menu.png',
                            width: 39.92.w,
                            height: 43.75.h,
                          ),
                        ),
                      ),
                      expandedHeight: screenHeight / 2.4,
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                          background: _buildAppBar(user.downloadURL!,
                              user.shopAddress!, user.logoDownloadURL!)),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                              child: Text(
                                'Business info',
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2.h,
                                  color: const Color(0xfffe724c),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15.w, 0, 10.w, 0),
                              child: const Divider(
                                thickness: 1,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: SizedBox(
                                width: double.infinity,
                                height: 30.h,
                                child: Stack(children: [
                                  Positioned(
                                    child: Text(
                                      'Business Name',
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xfffe724c),
                                          height: 1.2.h),
                                    ),
                                  ),
                                  Positioned(
                                    left: 170,
                                    top: 3,
                                    child: Text(
                                      user.businessName!,
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w300,
                                        height: 1.2575.h,
                                        color: const Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15.w, 0, 10.w, 0),
                              child: const Divider(
                                thickness: 1,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: SizedBox(
                                width: double.infinity,
                                height: 40.h,
                                child: Stack(children: [
                                  Positioned(
                                    child: Text(
                                      'Business Bio',
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xfffe724c),
                                          height: 1.2.h),
                                    ),
                                  ),
                                  Positioned(
                                    left: 170,
                                    top: 3,
                                    child: Text(
                                      'Home Cook . Fast Food .\nLocal . Wines',
                                      softWrap: true,
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w300,
                                        height: 1.2575.h,
                                        color: const Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15.w, 0, 10.w, 0),
                              child: const Divider(
                                thickness: 1,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: SizedBox(
                                width: double.infinity,
                                height: 90.h,
                                child: Stack(children: [
                                  Positioned(
                                    child: Text(
                                      'Contacts',
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xfffe724c),
                                          height: 1.2.h),
                                    ),
                                  ),
                                  Positioned(
                                    left: 170,
                                    top: 3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 36.h,
                                          width: 180.w,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 195, 195, 195),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 5.h, left: 10.w),
                                            child: Text(
                                              user.contact!,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        Container(
                                          height: 36.h,
                                          width: 180.w,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 195, 195, 195),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 5.h, left: 10.w),
                                            child: Text(
                                              user.secondContact!,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15.w, 0, 10.w, 0),
                              child: const Divider(
                                thickness: 1,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: SizedBox(
                                width: double.infinity,
                                height: 30.h,
                                child: Stack(children: [
                                  Positioned(
                                    child: Text(
                                      'E-mail',
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xfffe724c),
                                          height: 1.2.h),
                                    ),
                                  ),
                                  Positioned(
                                    left: 170,
                                    top: 3,
                                    child: Text(
                                      user.email!,
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w300,
                                        height: 1.2575.h,
                                        color: const Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15.w, 0, 10.w, 0),
                              child: const Divider(
                                thickness: 1,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: SizedBox(
                                width: double.infinity,
                                height: 45.h,
                                child: Stack(children: [
                                  Positioned(
                                    child: Text(
                                      'Type of Shop',
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xfffe724c),
                                          height: 1.2.h),
                                    ),
                                  ),
                                  Positioned(
                                    left: 170,
                                    top: 3,
                                    child: Container(
                                      height: 36.h,
                                      width: 180.w,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 195, 195, 195),
                                          border: Border.all(
                                              width: 1, color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          user.selectedShopType!,
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w300,
                                            height: 1.2575.h,
                                            color: const Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15.w, 0, 10.w, 0),
                              child: const Divider(
                                thickness: 1,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(20.w, 15.h, 0, 0),
                              child: Text(
                                'Financial Info',
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2.h,
                                  color: const Color(0xfffe724c),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.h),
                              child: Text(
                                'Bank Account Details',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                    height: 1.2.h),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15.w, 0, 10.w, 0),
                              child: const Divider(
                                thickness: 1,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: SizedBox(
                                width: double.infinity,
                                height: 30.h,
                                child: Stack(children: [
                                  Positioned(
                                    child: Text(
                                      'Acc. Name',
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xfffe724c),
                                          height: 1.2.h),
                                    ),
                                  ),
                                  Positioned(
                                    left: 170,
                                    top: 3,
                                    child: Text(
                                      user.accountName!,
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w300,
                                        height: 1.2575.h,
                                        color: const Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15.w, 0, 10.w, 0),
                              child: const Divider(
                                thickness: 1,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: SizedBox(
                                width: double.infinity,
                                height: 30.h,
                                child: Stack(children: [
                                  Positioned(
                                    child: Text(
                                      'Acc. Number',
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xfffe724c),
                                          height: 1.2.h),
                                    ),
                                  ),
                                  Positioned(
                                    left: 170,
                                    top: 3,
                                    child: Text(
                                      user.accountNumber!.toStringAsFixed(0),
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w300,
                                        height: 1.2575.h,
                                        color: const Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15.w, 0, 10.w, 0),
                              child: const Divider(
                                thickness: 1,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.h, vertical: 10.h),
                              child: Text(
                                'Money Money Details',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                    height: 1.2.h),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: SizedBox(
                                width: double.infinity,
                                height: 30.h,
                                child: Stack(children: [
                                  Positioned(
                                    child: Text(
                                      'Network ',
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xfffe724c),
                                          height: 1.2.h),
                                    ),
                                  ),
                                  Positioned(
                                    left: 170,
                                    top: 3,
                                    child: Text(
                                      'MTN Mobile Money',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w300,
                                        height: 1.2575.h,
                                        color: const Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15.w, 0, 10.w, 0),
                              child: const Divider(
                                thickness: 1,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: SizedBox(
                                width: double.infinity,
                                height: 30.h,
                                child: Stack(children: [
                                  Positioned(
                                    child: Text(
                                      'Number',
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xfffe724c),
                                          height: 1.2.h),
                                    ),
                                  ),
                                  Positioned(
                                    left: 170,
                                    top: 3,
                                    child: Text(
                                      user.mobileMoneyNumber!,
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w300,
                                        height: 1.2575.h,
                                        color: const Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15.w, 0, 10.w, 0),
                              child: const Divider(
                                thickness: 1,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(20.w, 15.h, 0, 0),
                              child: Text(
                                'Shipping and Fullfilment info',
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2.h,
                                  color: const Color(0xfffe724c),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15.w, 0, 10.w, 0),
                              child: const Divider(
                                thickness: 1,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: SizedBox(
                                width: double.infinity,
                                height: 45.h,
                                child: Stack(children: [
                                  Positioned(
                                    child: Text(
                                      'Type of Courier',
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xfffe724c),
                                          height: 1.2.h),
                                    ),
                                  ),
                                  Positioned(
                                    left: 170,
                                    top: 3,
                                    child: Container(
                                      height: 36.h,
                                      width: 180.w,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 195, 195, 195),
                                          border: Border.all(
                                              width: 1, color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          user.selectedcourierServices!,
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w300,
                                            height: 1.2575.h,
                                            color: const Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15.w, 0, 10.w, 0),
                              child: const Divider(
                                thickness: 1,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 10.h,
                                  left: 20.h,
                                  bottom: 10.h,
                                  right: 20.w),
                              child: Container(
                                height: 137.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 224, 223, 223),
                                    border: Border.all(
                                        width: 1,
                                        color: const Color.fromARGB(
                                            255, 166, 166, 166)),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: EdgeInsets.all(10.0.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Special Shipping Requirements",
                                        style: TextStyle(
                                            color: const Color(0xffFE724C),
                                            fontSize: 18.sp),
                                      ),
                                      Text(
                                        user.specialRequirements!,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.sp),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ]),
                    )
                  ],
                ),
              );
            }
          })),
    );
  }

  Widget _buildAppBar(String image, String address, String logo) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight / 1.2,
                child: CachedNetworkImage(
                  placeholder: (context, url) => const AspectRatio(
                    aspectRatio: 1.6,
                    child: BlurHash(hash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                  ),
                  imageUrl: image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: constraints.maxWidth * 0.360,
              top: constraints.maxHeight * 0.7,
              child: Align(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: SizedBox(
                    width: 100.w,
                    height: 100.h,
                    child: CachedNetworkImage(
                      placeholder: (context, url) => const AspectRatio(
                        aspectRatio: 1.6,
                        child: BlurHash(hash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                      ),
                      imageUrl: logo,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Align(
                child: SizedBox(
                  width: 417.w,
                  height: 190.h,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0, -1),
                        end: Alignment(0, 1),
                        colors: <Color>[Color(0xfffdfbfb), Color(0x00ffffff)],
                        stops: <double>[0, 1],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                left: 95.5,
                top: 65.3573913574,
                child: SizedBox(
                  width: 250.w,
                  height: 35.4.h,
                  child: Stack(children: [
                    Positioned(
                      left: 0,
                      top: 16.397857666.w,
                      child: Align(
                        child: SizedBox(
                          width: 250.w,
                          height: 19.h,
                          child: Text(
                            address,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              height: 1.2230000814.h,
                              color: const Color(0xfffe724c),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        left: 55.w,
                        top: 0,
                        child: SizedBox(
                          width: 110.14.w,
                          height: 18.h,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text(
                                  'Shop Location',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    height: 1.2230001177.h,
                                    color: const Color(0xff8b9099),
                                  ),
                                ),
                              ),
                              Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 6.04),
                                  width: 6.64,
                                  height: 2.59,
                                  child: const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 13,
                                  )),
                            ],
                          ),
                        ))
                  ]),
                ))
          ],
        );
      },
    );
  }
}
