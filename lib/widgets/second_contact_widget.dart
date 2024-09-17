import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../contants/colors.dart';
import '../controllers/vendor_controller.dart';



class SecondContactInfo extends StatefulWidget {
  const SecondContactInfo({super.key});

  @override
  State<SecondContactInfo> createState() => _SecondContactInfoState();
}

class _SecondContactInfoState extends State<SecondContactInfo>
    with AutomaticKeepAliveClientMixin<SecondContactInfo> {
  @override
  bool get wantKeepAlive => true;
  final VendorController vendorController = Get.put(VendorController());

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 5, 10.h),
        width: 343.w,
        height: 196.h,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 7.w),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter details for second contact',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.2125.h,
                    color: const Color(0xff999999),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 70.h,
                  child: TextFormField(
                    onChanged: (val) {
                      vendorController.getFormData(secondContactName: val);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Name of Second Contact';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.transparent,
                    decoration: InputDecoration(
                        label: const Text("Name of Second Contact"),
                        prefixIcon: const Icon(
                          Icons.person_2_rounded,
                          color: Colors.grey,
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        filled: true,
                        fillColor: const Color(0xffF8F8F8),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: AppColors.primaryColor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xffDDDDDD))),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xffDDDDDD)))),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 70.h,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      // Define a regular expression for valid phone numbers.
                      // You can customize this to match the phone number format you want.
                      final phoneRegExp = RegExp(
                          r'(^(?:[+0]9)?[0-9]{10,12}$)'); // Example: 10 digits

                      if (!phoneRegExp.hasMatch(value)) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      vendorController.getFormData(secContact: val);
                    },
                    keyboardType: TextInputType.phone,
                    cursorColor: Colors.transparent,
                    decoration: InputDecoration(
                        label: const Text("Contact Info"),
                        prefixIcon: const Icon(
                          CupertinoIcons.phone,
                          color: Colors.grey,
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        filled: true,
                        fillColor: const Color(0xffF8F8F8),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: AppColors.primaryColor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xffDDDDDD))),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xffDDDDDD)))),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 70.h,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      // Define a regular expression for valid phone numbers.
                      // You can customize this to match the phone number format you want.
                      final phoneRegExp = RegExp(
                          r'(^(?:[+0]9)?[0-9]{10,12}$)'); // Example: 10 digits

                      if (!phoneRegExp.hasMatch(value)) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      vendorController.getFormData(secSecContact: val);
                    },
                    keyboardType: TextInputType.phone,
                    cursorColor: Colors.transparent,
                    decoration: InputDecoration(
                        label: const Text("2nd Contact Info"),
                        prefixIcon: const Icon(
                          CupertinoIcons.phone,
                          color: Colors.grey,
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        filled: true,
                        fillColor: const Color(0xffF8F8F8),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: AppColors.primaryColor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xffDDDDDD))),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xffDDDDDD)))),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 70.h,
                  child: TextFormField(
                    onChanged: (value) {
                      vendorController.getFormData(secEmail: value);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an email address';
                      }
                      if (!RegExp(
                              r'^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.transparent,
                    decoration: InputDecoration(
                        label: const Text("Email"),
                        prefixIcon: const Icon(
                          CupertinoIcons.mail,
                          color: Colors.grey,
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        filled: true,
                        fillColor: const Color(0xffF8F8F8),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: AppColors.primaryColor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xffDDDDDD))),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xffDDDDDD)))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
