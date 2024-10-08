import 'package:another_stepper/another_stepper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

import '../controllers/user_controller.dart';
import '../widgets/custom_drawer_nav.dart';

class LogisticPage extends StatefulWidget {
  const LogisticPage({super.key});

  @override
  State<LogisticPage> createState() => _LogisticPageState();
}

class _LogisticPageState extends State<LogisticPage> {
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

  List stepperNewData = [
    {
      "title": "MyChef’s Space confirmed the order",
    },
    {
      "title": "Preparing order",
    },
    {
      "title": "Looking for a courier",
    },
    {
      "title": "The courier is on their way to (Shop’s name)",
    },
    {
      "title": "Courier has arrived ",
    }
  ];
  int _currentStep = 0;

  void _incrementStep() {
    setState(() {
      if (_currentStep < stepperNewData.length - 1) {
        _currentStep++;
      }
    });
  }

  String title(int index) {
    if (index == 0 || index == 4) {
      return "      CALL A COURIER";
    }
    return "      PRODUCT DELIVERED";
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
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.85,
                          height: constraints.maxHeight * 1,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                              color: const Color(0xffFFFFFF),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    'ORDER No. #SD324',
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w700,
                                      height: 1.2125.h,
                                      color: const Color(0xffFE724C),
                                    ),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Pepperoni Pizza ',
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w700,
                                            height: 1.2125.h,
                                            color: const Color(0xff212529),
                                          ),
                                        ),
                                        Text(
                                          '... MyChef’s Space ',
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w700,
                                            height: 1.2125.h,
                                            color: const Color(0xff797979),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth * 0.37,
                                      child: Text(
                                        'from 257, Holy Trinity Medical Centre, ... ',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w200,
                                          height: 1.2125.h,
                                          color: const Color(0xff212529),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 50.w,
                                      height: 30.h,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Image.asset("images/vv.png"),
                                          Text(
                                            "4.6",
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w200,
                                              height: 1.2125.h,
                                              color: const Color(0xff999999),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  'GH₵ 299.83',
                                  style: GoogleFonts.inter(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    height: 1.2125.h,
                                    color: const Color(0xff212529),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Center(
                                  child: Text(
                                    'Order Progress',
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w900,
                                      height: 1.2125.h,
                                      color: const Color(0xff1F2B2E),
                                    ),
                                  ),
                                ),
                                Column(children: [
                                  AnotherStepper(
                                    stepperList: List<StepperData>.generate(
                                        stepperNewData.length,
                                        (i) => StepperData(
                                              title: StepperText(
                                                  stepperNewData[i]["title"],
                                                  textStyle: TextStyle(
                                                      color: i == _currentStep
                                                          ? Colors.black
                                                          : Colors.grey,
                                                      fontSize: 16.sp,
                                                      fontWeight: i ==
                                                              _currentStep
                                                          ? FontWeight.w900
                                                          : FontWeight.w300)),
                                              iconWidget: Container(
                                                width: 35,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  color: i == _currentStep ||
                                                          i < _currentStep
                                                      ? const Color(0xffFE724C)
                                                      : Colors.grey,
                                                ),
                                                child: i == _currentStep ||
                                                        i < _currentStep
                                                    ? Center(
                                                        child: Lottie.asset(
                                                        'images/aa.json', // Replace with your animation file path
                                                        width: 35,
                                                        height: 35,
                                                        fit: BoxFit.cover,
                                                      ))
                                                    : const Center(
                                                        child: Icon(
                                                            Icons.circle,
                                                            size: 16,
                                                            weight: 200,
                                                            color: Color(
                                                                0xffFE724C)),
                                                      ),
                                              ),
                                            )),
                                    stepperDirection: Axis.vertical,
                                  ),
                                ]),
                                Center(
                                  child: ConfirmationSlider(
                                    foregroundColor: Colors.white,
                                    sliderButtonContent:
                                        _currentStep == 0 || _currentStep == 4
                                            ? Image.asset("images/conf.png")
                                            : Image.asset("images/dark.png"),
                                    backgroundColor:
                                        _currentStep == 0 || _currentStep == 4
                                            ? const Color(0xfffe724c)
                                            : const Color(0xff999999),
                                    text: title(_currentStep),
                                    textStyle: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2575.sp,
                                      letterSpacing: 1.2,
                                      color: const Color(0xffffffff),
                                    ),
                                    onConfirmation: _incrementStep,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * 0.9,
                                  height: constraints.maxHeight * 0.05,
                                  child: Row(
                                    children: [
                                      Image.asset("images/ooo.png"),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "See Courier’s Location",
                                            style: TextStyle(
                                                color: const Color(0xff1F2B2E),
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            "1535 McKercher Drive, Saskatoon, SK S7H 5L3",
                                            style: TextStyle(
                                                color: const Color(0xff999999),
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w200),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}
