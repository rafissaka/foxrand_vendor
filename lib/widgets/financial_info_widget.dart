import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../contants/colors.dart';
import '../controllers/vendor_controller.dart';



class FinancialInfo extends StatefulWidget {
  const FinancialInfo({super.key});

  @override
  State<FinancialInfo> createState() => _FinancialInfoState();
}

class _FinancialInfoState extends State<FinancialInfo>
    with AutomaticKeepAliveClientMixin<FinancialInfo> {
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
        height: 162.h,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 7.h),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter Bank account details',
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
                  height: 70.h,
                  child: TextFormField(
                    onChanged: (val) {
                      vendorController.getFormData(accountName: val);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Account Name';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.transparent,
                    decoration: InputDecoration(
                        label: const Text("Account Name"),
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
                    onChanged: (val) {
                      vendorController.getFormData(
                          accountNumber: int.parse(val));
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Account Number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.transparent,
                    decoration: InputDecoration(
                        label: const Text("Account Number"),
                        prefixIcon: const Icon(
                          Icons.currency_exchange,
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
                Text(
                  'Enter Mobile money details',
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
                  height: 70.h,
                  child: TextFormField(
                    onChanged: (val) {
                      vendorController.getFormData(mobileMoneyName: val);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Mobile Money Name';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.transparent,
                    decoration: InputDecoration(
                        label: const Text("Mobile Money Name"),
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
                        return 'Please enter Mobile Money Number';
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
                      vendorController.getFormData(mobileMoneyNumber: val);
                    },
                    keyboardType: TextInputType.phone,
                    cursorColor: Colors.transparent,
                    decoration: InputDecoration(
                        label: const Text("Mobile Money Number"),
                        prefixIcon: const Icon(
                          Icons.currency_franc,
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
