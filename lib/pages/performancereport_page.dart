import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';


import '../controllers/user_controller.dart';
import '../widgets/custom_drawer_nav.dart';

class PerformanceReportSCreen extends StatefulWidget {
  const PerformanceReportSCreen({super.key});

  @override
  State<PerformanceReportSCreen> createState() =>
      _PerformanceReportSCreenState();
}

class _PerformanceReportSCreenState extends State<PerformanceReportSCreen> {
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

  // Create a NumberFormat instance for Ghanaian Cedis (GHS) currency
  final cedisFormat = NumberFormat.currency(
    symbol: '₵',
    decimalDigits: 2,
    locale: 'en_GH', // Use the appropriate locale for Ghana
  );

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
              padding: EdgeInsets.fromLTRB(18.w, 25.h, 17.w, 89.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 41.h),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Daily Performance Report',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                            height: 1.2575.h,
                            color: const Color(0xff000000),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(12.w, 0, 0, 11.h),
                          width: double.infinity,
                          height: 132.h,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.fromLTRB(0, 18.w, 31.h, 13.w),
                                width: 165.w,
                                height: double.infinity,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 53,
                                      child: SizedBox(
                                        width: 119.w,
                                        height: 48.h,
                                        child: const SizedBox(
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: SizedBox(
                                        width: 165.w,
                                        height: 101.h,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 12.h, 5.w),
                                              width: double.infinity,
                                              height: 48.h,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 9.w, 15.h, 0),
                                                    width: 30.w,
                                                    height: 4.h,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      color: const Color(
                                                          0xfffe724c),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: double.infinity,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 0, 0, 4.w),
                                                          child: Text(
                                                            'Total Sales & Cost',
                                                            style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height:
                                                                  1.8333333333
                                                                      .h,
                                                              color: const Color(
                                                                  0xffd0d1d2),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(' GH₵ 5000',
                                                            style: GoogleFonts
                                                                .inter(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              height:
                                                                  1.8333333333
                                                                      .h,
                                                              color: const Color(
                                                                  0xff11263c),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 4.h),
                                              width: double.infinity,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 0, 15.w, 0),
                                                    width: 30.w,
                                                    height: 4.h,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      color: const Color(
                                                          0xfffdae98),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Discounted Amount',
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.8333333333.h,
                                                      color: const Color(
                                                          0xffd0d1d2),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 14.w, 0),
                                              child: Text(' GH₵ 70.0',
                                                  style: GoogleFonts.inter(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.8333333333.h,
                                                    color:
                                                        const Color(0xff11263c),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  width: 132,
                                  height: double.infinity,
                                  child: PieChart(
                                    PieChartData(
                                      sections: _generateChartData(),
                                      borderData: FlBorderData(
                                          show: false), // Hide the border
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(27.w, 0, 19.w, 0),
                          width: double.infinity,
                          height: 100.h,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 54.w, 0),
                                padding:
                                    EdgeInsets.fromLTRB(15.w, 16.h, 14.w, 35.h),
                                width: 120.w,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xfffdae98),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.fromLTRB(0, 0, 0, 17.h),
                                      child: Text(
                                        'Daily No. of Orders',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w300,
                                          height: 1.6.h,
                                          color: const Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(1.w, 0, 0, 0),
                                      child: Text(
                                        '42',
                                        style: TextStyle(
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w500,
                                          height: 0.5.h,
                                          color: const Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    EdgeInsets.fromLTRB(19.w, 16.h, 14.w, 35.h),
                                width: 120.w,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xfffdae98),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.fromLTRB(0, 0, 0, 17.h),
                                      child: Text(
                                        'Daily Avg. Ratings',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w300,
                                          height: 1.6.h,
                                          color: const Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(1.w, 0, 0, 0),
                                      child: Text(
                                        '3.8',
                                        style: TextStyle(
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w500,
                                          height: 0.5.h,
                                          color: const Color(0xfffe724c),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Overall Performance Report',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                            height: 1.2575.h,
                            color: const Color(0xff000000),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(12.w, 0, 0, 11.h),
                          width: double.infinity,
                          height: 132.h,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.fromLTRB(0, 18.w, 31.h, 13.w),
                                width: 165.w,
                                height: double.infinity,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 53,
                                      child: SizedBox(
                                        width: 119.w,
                                        height: 48.h,
                                        child: const SizedBox(
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: SizedBox(
                                        width: 165.w,
                                        height: 101.h,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 12.h, 5.w),
                                              width: double.infinity,
                                              height: 48.h,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 9.w, 15.h, 0),
                                                    width: 30.w,
                                                    height: 4.h,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      color: const Color(
                                                          0xfffe724c),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: double.infinity,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 0, 0, 4.w),
                                                          child: Text(
                                                            'Total Sales & Cost',
                                                            style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height:
                                                                  1.8333333333
                                                                      .h,
                                                              color: const Color(
                                                                  0xffd0d1d2),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(' GH₵ 9000',
                                                            style: GoogleFonts
                                                                .inter(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              height:
                                                                  1.8333333333
                                                                      .h,
                                                              color: const Color(
                                                                  0xff11263c),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 4.h),
                                              width: double.infinity,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 0, 15.w, 0),
                                                    width: 30.w,
                                                    height: 4.h,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      color: const Color(
                                                          0xfffdae98),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Discounted Amount',
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.8333333333.h,
                                                      color: const Color(
                                                          0xffd0d1d2),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 14.w, 0),
                                              child: Text(' GH₵ 70',
                                                  style: GoogleFonts.inter(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.8333333333.h,
                                                    color:
                                                        const Color(0xff11263c),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  width: 132,
                                  height: double.infinity,
                                  child: PieChart(
                                    PieChartData(
                                      sections: _generateChartData(),
                                      borderData: FlBorderData(
                                          show: false), // Hide the border
                                    ),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(27.w, 0, 19.w, 0),
                    width: double.infinity,
                    height: 100.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 54.w, 0),
                          padding: EdgeInsets.fromLTRB(15.w, 16.h, 14.w, 35.h),
                          width: 120.w,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xfffdae98),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 17.h),
                                child: Text(
                                  'Daily No. of Orders',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w300,
                                    height: 1.6.h,
                                    color: const Color(0xffffffff),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(1.w, 0, 0, 0),
                                child: Text(
                                  '42',
                                  style: TextStyle(
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.w500,
                                    height: 0.5.h,
                                    color: const Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(19.w, 16.h, 14.w, 35.h),
                          width: 120.w,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xfffdae98),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 17.h),
                                child: Text(
                                  'Daily Avg. Ratings',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w300,
                                    height: 1.6.h,
                                    color: const Color(0xffffffff),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(1.w, 0, 0, 0),
                                child: Text(
                                  '3.8',
                                  style: TextStyle(
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.w500,
                                    height: 0.5.h,
                                    color: const Color(0xfffe724c),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> _generateChartData() {
    return [
      PieChartSectionData(
        radius: 10,
        value: 20,
        title: "GH₵ 70.00",
        titleStyle: GoogleFonts.inter(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          height: 1.8333333333.h,
          color: const Color(0xff11263c),
        ),
        color: const Color(0xffd0d1d2),
      ),
      PieChartSectionData(
        value: 80,
        color: const Color(0xfffe724c),
        radius: 10,
        title: "GH₵ 9000.00",
        titleStyle: GoogleFonts.inter(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          height: 1.8333333333.h,
          color: const Color(0xff11263c),
        ),
      ),
    ];
  }
}
