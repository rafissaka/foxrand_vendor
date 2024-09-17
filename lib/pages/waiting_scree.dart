import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WaitToCompleteVerificationScreen extends StatefulWidget {
  const WaitToCompleteVerificationScreen({super.key});

  @override
  State<WaitToCompleteVerificationScreen> createState() => _BusinessInfoState();
}

class _BusinessInfoState extends State<WaitToCompleteVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Container(
          padding: EdgeInsets.fromLTRB(64.5.w, 86.h, 58.5.w, 246.h),
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xffffffff),
            borderRadius: BorderRadius.circular(40.w),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 5.h, 47.w),
              width: 96.w,
              height: 79.h,
              child: Image.asset(
                'images/lolo2.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 22.w),
              child: Text(
                'Your application  is being processed.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.2575.h,
                  color: const Color(0xfffe724c),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 5.h, 34.w),
              width: 148.w,
              height: 156.h,
              child: Image.asset(
                'images/wait.png',
                width: 148.w,
                height: 156.h,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 5.w, 0),
              child: Text(
                'Admin will contact you soon...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.2575.h,
                  color: const Color(0xff726966),
                ),
              ),
            ),
          ])),
    ));
  }
}
