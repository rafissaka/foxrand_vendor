import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vendor/contants/colors.dart';

import '../controllers/onboarding_controller.dart';
import 'login_page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final OnboardingController onboardingController = Get.find();
  int currentPage = 0;
  late LiquidController _liquidController;
  final pages = [
    {
      'image': 'images/onboarding.png',
      'title': 'Sell Your inventory without the cost of running a shop',
      'description':
          'We provide a digital platform for vendor’s to sell their inventory without the need of  running a shop. just a warehouse storage place for your inventory is needed.',
    },
    {
      'image': 'images/onboarding2.png',
      'title': 'Track your progress in the quality of your services',
      'description':
          'This app gives you reliable needed data and ratings of your services by tracking and reporting your performance to you which will aid in the provision of quality services.',
    },
    {
      'image': 'images/onboarding3.png',
      'title': 'Provides your business with logistics solutions',
      'description':
          'We take the burden off your shoulders by  provide your business with actual logistics solution with the use of free-lance registered courier drivers.',
    },
  ];
  @override
  void initState() {
    _liquidController = LiquidController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            pages: pages
                .map(
                  (page) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(page['image']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                          child: Text(
                            page['title']!,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(28),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(20)),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(20)),
                          child: Text(
                            page['description']!,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(18),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
            waveType: WaveType.liquidReveal,
            slideIconWidget: const Icon(Icons.arrow_back_ios),
            liquidController: _liquidController,
            enableSideReveal: true,
            fullTransitionValue: 880,
            preferDragFromRevealedArea: true,
            enableLoop: false,
            positionSlideIcon: 0.5,
            ignoreUserGestureWhileAnimating: true,
            onPageChangeCallback: onPageChangeCallback,
            currentUpdateTypeCallback: (updateType) {},
          ),
          currentPage == 2
              ? Positioned(
                  bottom: 120.r,
                  child: OutlinedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: AppColors.accentColor),
                        shape: const CircleBorder(),
                        padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                      ),
                      onPressed: () {
                        onboardingController.setOnboardingCompleted();
                        Get.offAll(() => const LoginScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                        decoration: const BoxDecoration(
                            color: AppColors.lightColor,
                            shape: BoxShape.circle),
                        child: const Text(
                          "Start",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )))
              : Positioned(
                  bottom: 120.r,
                  child: OutlinedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: AppColors.accentColor),
                        shape: const CircleBorder(),
                        padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                      ),
                      onPressed: () {
                        int nextPage = _liquidController.currentPage + 1;
                        _liquidController.jumpToPage(page: nextPage);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                            color: AppColors.lightColor,
                            shape: BoxShape.circle),
                        child: const Icon(Icons.arrow_forward_ios),
                      ))),
          Positioned(
              top: 50.r,
              right: 20.r,
              child: TextButton(
                  onPressed: () {
                    onboardingController.setOnboardingCompleted();
                    Get.offAll(() => const LoginScreen());
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ))),
          Positioned(
            bottom: 70.r,
            child: AnimatedSmoothIndicator(
              activeIndex: _liquidController.currentPage,
              count: pages.length,
              effect: const WormEffect(
                  activeDotColor: AppColors.accentColor,
                  dotColor: AppColors.whiteColor,
                  dotHeight: 5),
            ),
          ),
        ],
      ),
    );
  }

  onPageChangeCallback(int activePageIndex) {
    setState(() {
      currentPage = activePageIndex;
    });
  }
}
