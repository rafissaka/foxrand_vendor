import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:vendor/pages/phone_register_screen.dart';
import 'package:vendor/pages/reset_password_page.dart';
import 'package:vendor/widgets/custom_textfield.dart';

import '../controllers/login_controller.dart';
import 'signup_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final keyForm = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(20),
            vertical: ScreenUtil().setHeight(70)),
        child: Form(
          key: keyForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 50.w, 0),
                child: Text(
                  'Welcome back!',
                  style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xfffe724c),
                      height: 1.2575),
                ),
              ),
              Text('Enter your credentials to continue.',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.2125.h,
                    color: const Color(0xff999999),
                  )),
              SizedBox(
                height: 40.h,
              ),
              CustomTextField(
                controller: emailController,
                hintext: 'Email',
                icon: CupertinoIcons.mail_solid,
                isEmail: true,
                isName: false,
                isMobile: false,
                isPassword: false,
                type: TextInputType.name,
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomTextField(
                controller: passwordController,
                hintext: 'Password',
                icon: CupertinoIcons.lock,
                isEmail: false,
                isName: false,
                isMobile: false,
                isPassword: true,
                type: TextInputType.visiblePassword,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const ResetPasswordPage());
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 8.5.w, 0, 7.5.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.2125.h,
                      color: const Color(0xfffe724c),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (keyForm.currentState!.validate()) {
                    loginController.signIn(emailController.text.trim(),
                        passwordController.text.trim(), context);
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 58.h,
                  decoration: BoxDecoration(
                    color: const Color(0xfffe724c),
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                  child: Center(
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.2125.h,
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                width: double.infinity,
                height: 36.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                ),
                child: Center(
                  child: Text(
                    'Or connect via',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.2125.h,
                      color: const Color(0xff999999),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const PhoneRegisterPage());
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 238, 236, 233),
                          borderRadius: BorderRadius.circular(25)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.phone,
                            size: 20,
                            color: Color(0xfffe724c),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'PHONE',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 238, 236, 233),
                          borderRadius: BorderRadius.circular(25)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.google,
                            size: 20,
                            color: Color(0xfffe724c),
                          ),
                          SizedBox(height: 10.h),
                          const Text(
                            'GOOGLE',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(28.5.w, 10.h, 28.5.w, 10.h),
                width: 343.w,
                height: 80.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                ),
                child: Center(
                  child: SizedBox(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.625.h,
                          color: const Color(0xfffe724c),
                        ),
                        children: [
                          TextSpan(
                            text: 'By logging, you are agreeing with our \n',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              height: 1.625.h,
                              color: const Color(0xff999999),
                            ),
                          ),
                          TextSpan(
                            text: 'Terms of Use',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              height: 1.625.h,
                              decoration: TextDecoration.underline,
                              color: const Color(0xfffe724c),
                              decorationColor: const Color(0xfffe724c),
                            ),
                          ),
                          TextSpan(
                            text: ' and ',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              height: 1.625.h,
                              color: const Color(0xff999999),
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              height: 1.625.h,
                              decoration: TextDecoration.underline,
                              color: const Color(0xfffe724c),
                              decorationColor: const Color(0xfffe724c),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(5.h, 0, 9, 0),
                width: double.infinity,
                height: 59.h,
                decoration: const BoxDecoration(
                  color: Color(0x1efe724c),
                ),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.2125.h,
                        color: const Color(0xfffe724c),
                      ),
                      children: [
                        TextSpan(
                          text: 'Don’t have an account? ',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            height: 1.2125.h,
                            color: const Color(0xff999999),
                          ),
                        ),
                        const TextSpan(
                          text: ' ',
                        ),
                        TextSpan(
                          text: 'Register',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(() => const SignUpScreen());
                            },
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            height: 1.2125.h,
                            decoration: TextDecoration.underline,
                            color: const Color(0xfffe724c),
                            decorationColor: const Color(0xfffe724c),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
