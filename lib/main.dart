import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:vendor/controllers/token_controller.dart';
import 'package:vendor/mybindings.dart';
import 'package:vendor/pages/splash_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vendor/services/notification_services.dart';

Future main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await NotificationServices().requestNotificationPermissions();

  await NotificationServices().firebaseInit();
  // await NotificationServices().isTokenRefresh();
  await NotificationServices().getDeviceToken().then((value) => {
        // ignore: avoid_print
        print("Device Token: $value")
      });
  // Initialize the TokenController and keep it alive throughout the app
  Get.put(FCMController());

  runApp(const MyApp());
}

@pragma("vm:entry-point")
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      overlayColor: Colors.grey.withOpacity(0.8),
      useDefaultLoading: false,
      overlayWidgetBuilder: (_) {
        return Center(
          child: SpinKitFadingCircle(
            color: Theme.of(context).primaryColor,
            size: 50.0,
          ),
        );
      },
      child: ScreenUtilInit(
        designSize: const Size(414, 896),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialBinding: MyBinding(),
            theme: ThemeData(
              visualDensity: VisualDensity.adaptivePlatformDensity,
              primarySwatch: Colors.blue,
              textTheme: GoogleFonts.poppinsTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            home: child,
          );
        },
        child: const SplashScreen(),
      ),
    );
  }
}
