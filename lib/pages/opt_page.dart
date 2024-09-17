import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:pinput/pinput.dart';
import 'package:vendor/contants/colors.dart';

class OptPage extends StatefulWidget {
  final String number;
  const OptPage({super.key, required this.number});

  @override
  State<OptPage> createState() => _OptPageState();
}

class _OptPageState extends State<OptPage> {
  final TextEditingController smsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(20),
              vertical: ScreenUtil().setHeight(100)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 90, 8),
                child: const Text(
                  'Verification Code',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff000000),
                      height: 1.2575),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0.01, 0, 0, 28),
                child: Text(
                  'Please type the verification code sent to ${widget.number}',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.3769999913.h,
                    color: const Color(0xff9796a1),
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(30)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width.w,
                  child: Pinput(
                    controller: smsController,
                    length: 6,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    defaultPinTheme: PinTheme(
                      height: 50.0.h,
                      width: 50.0.w,
                      textStyle: GoogleFonts.urbanist(
                        fontSize: 24.0.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 1.0.w,
                        ),
                      ),
                    ),
                    focusedPinTheme: PinTheme(
                      height: 50.0.h,
                      width: 50.0.w,
                      textStyle: GoogleFonts.urbanist(
                        fontSize: 24.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0.w,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(30)),
              Container(
                margin: const EdgeInsets.fromLTRB(27.4, 0, 0, 0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.2102272511.h,
                      color: const Color(0xff5b5b5e),
                    ),
                    children: [
                      TextSpan(
                        text: 'I didn’t receive a code! ',
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          height: 1.5.h,
                          color: const Color(0xff5b5b5e),
                        ),
                      ),
                      TextSpan(
                          text: 'Please resend',
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            height: 1.5.h,
                            color: const Color(0xfffe724c),
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {}),
                    ],
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),
              Row(
                children: [
                  Expanded(
                    child: ProgressButton.icon(iconedButtons: {
                      ButtonState.idle: const IconedButton(
                          text: "Continue",
                          icon: Icon(Icons.send, color: Colors.white),
                          color: AppColors.primaryColor),
                      ButtonState.loading: IconedButton(
                          text: "Loading", color: Colors.deepPurple.shade700),
                      ButtonState.fail: IconedButton(
                          text: "Failed",
                          icon: const Icon(Icons.cancel, color: Colors.white),
                          color: Colors.red.shade300),
                      ButtonState.success: IconedButton(
                          text: "Success",
                          icon: const Icon(
                            Icons.check_circle,
                            color: Colors.white,
                          ),
                          color: Colors.green.shade400)
                    }, onPressed: () {}, state: ButtonState.idle),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
