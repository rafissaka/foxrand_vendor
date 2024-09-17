import 'package:flutter/material.dart';
import 'package:flutter_animated_splash/flutter_animated_splash.dart '
    as animate;
import 'package:get/get.dart';
import 'package:vendor/pages/login_page.dart';
import 'package:vendor/pages/onboarding_page.dart';
import '../controllers/home_controller.dart';
import '../controllers/onboarding_controller.dart';
import 'landing_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final OnboardingController onboardingController =
      Get.put(OnboardingController());

  final HomeController _homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: animate.AnimatedSplash(
          type: animate.Transition.leftToRightWithFade,
          curve: Curves.easeInCubic,
          backgroundColor: Colors.orange,
          navigator: Obx(
            () {
              if (onboardingController.isOnboardingCompleted.value) {
                if (_homeController.user == null) {
                  return const LoginScreen();
                }

                return const LandingPage();
              } else {
                return const OnBoardingPage();
              }
            },
          ),
          durationInSeconds: 4,
          child: Center(
              child: Image.asset(
            "images/splash.png",
            height: 200.r,
            width: 200.r,
          ))),
    );
  }
}
