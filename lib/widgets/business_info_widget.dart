import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../contants/colors.dart';
import '../controllers/vendor_controller.dart';



class BusinessInfo extends StatefulWidget {
  const BusinessInfo({
    super.key,
  });

  @override
  State<BusinessInfo> createState() => _BusinessInfoState();
}

class _BusinessInfoState extends State<BusinessInfo>
    with AutomaticKeepAliveClientMixin<BusinessInfo> {
  final VendorController vendorController = Get.put(VendorController());

  String? selectedShopType;
  List<String> shopTypes = ["Restaurant", "Shop"];

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
          padding: EdgeInsets.symmetric(vertical: 7.w),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter business details',
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
                      setState(() {
                        vendorController.getFormData(businessName: val);
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Name of Business';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.transparent,
                    decoration: InputDecoration(
                        label: const Text("Name of Business"),
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
                      vendorController.getFormData(contact: val);
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
                    onChanged: (val) {
                      vendorController.getFormData(secondContact: val);
                    },
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
                    keyboardType: TextInputType.number,
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
                      vendorController.getFormData(email: value);
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
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 90.h,
                  child: DropdownButtonFormField<String>(
                    value: selectedShopType,
                    items: shopTypes.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedShopType = value;
                        vendorController.getFormData(selectedShopType: value);
                      });
                    },
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      labelText: 'type of shop',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Color(0xffDDDDDD))),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select an option';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
