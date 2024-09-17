import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import '../contants/colors.dart';

import '../controllers/firebase_controller.dart';

import '../widgets/custom_drawer_nav.dart';
import 'performancereport_page.dart';
import 'switch_product.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _BusinessInfoState();
}

class _BusinessInfoState extends State<DashBoardScreen> {
  String _selectedOption = 'Daily';
  String? selectedShop;
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

  final List<Color> gradiantColors = [Colors.redAccent, Colors.orangeAccent];
  double max = 0;
  final List<FlSpot> data = [
    const FlSpot(0, 3),
    const FlSpot(1, 1),
    const FlSpot(2, 4),
    const FlSpot(3, 2),
    const FlSpot(4, 5),
    const FlSpot(5, 2),
    const FlSpot(6, 4),
  ];

  final DateFormat _timeFormat = DateFormat('HH:mm');
  List<String> getXLabels(List<FlSpot> spots) {
    return spots.map((spot) {
      DateTime currentTime =
          DateTime.now().add(Duration(minutes: spot.x.toInt() * 15));
      return _timeFormat.format(currentTime);
    }).toList();
  }

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

  FirebaseController firebaseController = Get.put(FirebaseController());

  @override
  void initState() {
    super.initState();
  }

  bool status8 = false;
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
          child: Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: const Text("DashBoard"),
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
                  expandedHeight: screenHeight / 2.55.h,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(background: _buildAppBar()),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Padding(
                    padding: REdgeInsets.fromLTRB(12.w, 21.h, 16.w, 27.h),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: REdgeInsets.fromLTRB(0, 0, 0, 23.h),
                            width: double.infinity,
                            height: 94.h,
                            decoration: BoxDecoration(
                              color: const Color(0xffffc3b3),
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 176,
                                  top: 0,
                                  child: Align(
                                    child: SizedBox(
                                      width: 190.w,
                                      height: 190.h,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(95),
                                          color: const Color.fromARGB(
                                              11, 56, 55, 54),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 17,
                                  top: 21,
                                  child: Align(
                                    child: SizedBox(
                                      width: 60.w,
                                      height: 20.h,
                                      child: Text(
                                        'Balance',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          height: 1.365.h,
                                          color: const Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 15,
                                  top: 43,
                                  child: Align(
                                    child: SizedBox(
                                      width: 179.w,
                                      height: 33.h,
                                      child: Text(
                                        'GH₵ 10,009.00',
                                        style: GoogleFonts.inter(
                                          fontSize: 23.sp,
                                          fontWeight: FontWeight.w800,
                                          height: 1.365.h,
                                          color: const Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 261,
                                  top: 43,
                                  child: Align(
                                    child: SizedBox(
                                      width: 37.w,
                                      height: 33.h,
                                      child: Text(
                                        '4.6',
                                        style: TextStyle(
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.w800,
                                          height: 1.365,
                                          color: const Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 236,
                                  top: 21,
                                  child: Align(
                                    child: SizedBox(
                                      width: 100.w,
                                      height: 20.h,
                                      child: Text(
                                        'Avg. Ratings',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          height: 1.365.h,
                                          color: const Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 218,
                                  top: 20,
                                  child: Align(
                                    child: SizedBox(
                                      width: 12,
                                      height: 16,
                                      child: Image.asset(
                                        'images/bar.png',
                                        width: 12,
                                        height: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 327,
                                  top: 21,
                                  child: Align(
                                    child: SizedBox(
                                      width: 14,
                                      height: 14,
                                      child: Image.asset(
                                        'images/Star.png',
                                        width: 14,
                                        height: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: REdgeInsets.fromLTRB(0, 0, 140.w, 5.h),
                            child: Text(
                              'Performance chart',
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w600,
                                height: 1.2575.h,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            margin: REdgeInsets.fromLTRB(15.w, 0, 0.w, 25.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'No. of Orders/Avg Ratings',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2575.h,
                                    color: Colors.grey,
                                  ),
                                ),
                                DropdownButton<String>(
                                  value: _selectedOption,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedOption = newValue!;
                                    });
                                  },
                                  items: <String>['Daily', 'Weekly', 'Monthly']
                                      .map<DropdownMenuItem<String>>(
                                    (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ],
                            ),
                          ),
                          AspectRatio(
                            aspectRatio: 1,
                            child: LineChart(LineChartData(
                                minX: 0,
                                maxX: data.length.toDouble(),
                                minY: 0,
                                maxY: 6,
                                lineBarsData: [
                                  LineChartBarData(
                                      spots: data,
                                      isCurved: true,
                                      dotData: const FlDotData(show: false),
                                      color: AppColors.primaryColor,
                                      barWidth: 3,
                                      belowBarData: BarAreaData(
                                          show: true,
                                          color: AppColors.lightColor)),
                                ],
                                gridData: FlGridData(
                                    drawVerticalLine: false,
                                    getDrawingHorizontalLine: (value) {
                                      return const FlLine(strokeWidth: 0.5);
                                    }),
                                titlesData: FlTitlesData(
                                    show: true,
                                    leftTitles: const AxisTitles(
                                        sideTitles: SideTitles(
                                      showTitles: true,
                                      interval: 1,
                                      reservedSize: 22,
                                    )),
                                    rightTitles: const AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false)),
                                    topTitles: const AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false)),
                                    bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                            showTitles: true,
                                            interval: 1,
                                            reservedSize: 22,
                                            getTitlesWidget: (value, meta) {
                                              if (value % 1 == 0 &&
                                                  value >= 0 &&
                                                  value < data.length) {
                                                return Text(getXLabels(
                                                    data)[value.toInt()]);
                                              }
                                              return const Text("");
                                            }))))),
                          ),
                          Container(
                              margin: REdgeInsets.fromLTRB(0, 0, 160.w, 0),
                              child: TextButton(
                                onPressed: () {
                                  Get.to(() => const PerformanceReportSCreen());
                                },
                                child: Text(
                                  'Performance Report...',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2575.h,
                                    color: const Color(0xfffe724c),
                                  ),
                                ),
                              )),
                          Container(
                            margin: REdgeInsets.fromLTRB(15.w, 0, 0.w, 25.h),
                            width: 705.w,
                            height: 40.h,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Popular Items',
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2575.h,
                                      color: const Color(0xff323643),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => SwitchPage(
                                            shopType: selectedShop!,
                                          ));
                                    },
                                    child: SizedBox(
                                      width: 80.w,
                                      height: 35.h,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0xfffe724c),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Add Product',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                              height: 1.2230000496.h,
                                              color: const Color(0xffffffff),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          SizedBox(
                            width: 705.w,
                            height: 290.h,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: itemNames.length,
                                itemBuilder: (BuildContext context, index) {
                                  return Container(
                                    width: 165.w,
                                    height: double.infinity,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                ),
                                                child:
                                                    Image.asset(items[index]),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: REdgeInsets.fromLTRB(
                                              10.w, 3.h, 0.w, 0),
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
                                        Container(
                                          margin: REdgeInsets.fromLTRB(
                                              10.w, 0.h, 0.w, 0),
                                          width: 96.w,
                                          height: 20.h,
                                          child: Text(
                                            '... MyChef’s Space',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w300,
                                              height: 1.6666666667.h,
                                              color: const Color(0xff797979),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 35.h,
                                          margin: REdgeInsets.fromLTRB(
                                              10.w, 0.h, 0.w, 0),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Comments .stars
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              REdgeInsets.fromLTRB(1, 0, 15, 6),
                                          width: double.infinity,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                margin: REdgeInsets.fromLTRB(
                                                    0, 0, 32, 0),
                                                child: RichText(
                                                  text: TextSpan(
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.6.h,
                                                      color: const Color(
                                                          0xfffe724c),
                                                    ),
                                                    children: [
                                                      const TextSpan(
                                                        text: 'Comments',
                                                      ),
                                                      TextSpan(
                                                        text: '... ',
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height:
                                                              1.3333333333.h,
                                                          color: const Color(
                                                              0xfffe724c),
                                                        ),
                                                      ),
                                                      const TextSpan(
                                                        text: '(15)',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: REdgeInsets.fromLTRB(
                                              1.w, 0, 0, 0),
                                          child: Text(
                                            'GH₵ 299.83',
                                            style: GoogleFonts.inter(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                              height: 1.3333333333.h,
                                              color: const Color(0xff212529),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          )
                        ]),
                  ),
                ]))
              ],
            ),
          )),
    );
  }

  Widget _buildAppBar() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;

    return StreamBuilder<DocumentSnapshot>(
      stream: firestore
          .collection('vendors')
          .doc(auth.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        final data = snapshot.data!.data() as Map<String, dynamic>;

        selectedShop = data["shopType"];

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
                      imageUrl: data["shopUrl"],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: constraints.maxWidth * 0.045,
                  top: constraints.maxHeight * 0.7,
                  child: Align(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        width: constraints.maxWidth * 0.25,
                        height: constraints.maxHeight * 0.238,
                        child: CachedNetworkImage(
                          placeholder: (context, url) => const AspectRatio(
                            aspectRatio: 1.6,
                            child:
                                BlurHash(hash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                          ),
                          imageUrl: data["logoUrl"],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: constraints.maxWidth * 0.32,
                  top: constraints.maxHeight * 0.84,
                  child: Align(
                    child: SizedBox(
                      width: 200.w,
                      height: 26.h,
                      child: Text(
                        data["businessName"],
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w900,
                          height: 1.2575.h,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: constraints.maxWidth * 0.32,
                  top: constraints.maxHeight * 0.9,
                  child: Align(
                    child: SizedBox(
                      width: 300.w,
                      height: 26.h,
                      child: Text(
                        'Home Cook • Fast food • Local • Wines',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.2575.h,
                          color: const Color(0xff000000),
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
                            colors: <Color>[
                              Color(0xfffdfbfb),
                              Color(0x00ffffff)
                            ],
                            stops: <double>[0, 1],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: constraints.maxWidth * 0.678,
                  top: constraints.maxHeight * 0.699,
                  child: Container(
                    height: 40.h,
                    padding: REdgeInsets.fromLTRB(0, 0, 12.28.w, 0),
                    child: LiteRollingSwitch(
                      width: 110.w,
                      value: data["active"],
                      textOn: 'Opened',
                      textOff: 'Closed',
                      colorOn: Colors.green,
                      colorOff: Colors.red,
                      iconOn: Icons.done,
                      iconOff: Icons.remove_circle_outline,
                      animationDuration: const Duration(milliseconds: 300),
                      textSize: 14.0.sp,
                      onChanged: (bool state) {
                        firebaseController.updateVendorField("active", state);
                      },
                      onTap: () async {},
                      onDoubleTap: () async {},
                      onSwipe: () async {},
                    ),
                  ),
                ),
                Positioned(
                  left: constraints.maxWidth * 0.20,
                  top: constraints.maxHeight * 0.18,
                  child: SizedBox(
                    width: 250.w,
                    height: 35.4.h,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 16.397857666,
                          child: Align(
                            child: SizedBox(
                              width: 250.w,
                              height: 19.h,
                              child: Text(
                                data["shopAddress"],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w800,
                                  height: 1.2230000814.h,
                                  color: const Color(0xfffe724c),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            left: ScreenUtil().screenWidth * 0.20,
                            top: 0,
                            child: SizedBox(
                              width: 110.14.w,
                              height: 18.h,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: REdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Text(
                                      'Shop Location',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w800,
                                        height: 1.2230001177.h,
                                        color: const Color(0xff8b9099),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      margin:
                                          REdgeInsets.fromLTRB(0, 0, 0, 6.04.h),
                                      width: 6.64.w,
                                      height: 2.59.h,
                                      child: Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 13.sp,
                                      )),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}
