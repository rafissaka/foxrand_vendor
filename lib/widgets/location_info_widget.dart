import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../contants/colors.dart';
import '../controllers/locaton_controller.dart';
import '../controllers/vendor_controller.dart';
import '../pages/map_screen.dart';




class LocationInfo extends StatefulWidget {
  const LocationInfo({super.key});

  @override
  State<LocationInfo> createState() => _LocationInfoState();
}

class _LocationInfoState extends State<LocationInfo>
    with AutomaticKeepAliveClientMixin<LocationInfo> {
  @override
  bool get wantKeepAlive => true;
  final VendorController vendorController = Get.put(VendorController());

  final LocationController locationController = Get.put(LocationController());

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
                  'Enter location details',
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
                      vendorController.getFormData(
                          shopAddress: locationController.currentAddress.value);
                    },
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.transparent,
                    decoration: InputDecoration(
                        enabled: false,
                        label: Obx(() {
                          if (locationController
                              .currentAddress.value.isNotEmpty) {
                            return Text(
                                locationController.currentAddress.value);
                          } else {
                            return const Text("Business Address");
                          }
                        }),
                        prefixIcon: const Icon(
                          Icons.location_on,
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
                      vendorController.getFormData(landmark: val);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Add Landmark';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.transparent,
                    decoration: InputDecoration(
                        label: const Text("Add Landmark"),
                        prefixIcon: const Icon(
                          Icons.location_city,
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
                Obx(() {
                  if (locationController.currentAddress.value.isNotEmpty) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => MapScreen(
                              selectedLocation: LatLng(
                                      locationController.currentLat.value,
                                      locationController.currentLong.value)
                                  .obs,
                              address: locationController.currentAddress.value,
                            ));
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 15.w, 99.h),
                        width: double.infinity,
                        height: 70.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 5.w, 0),
                              width: 60.h,
                              height: 60.h,
                              child: Image.asset(
                                'images/loc.png',
                                width: 60.h,
                                height: 60.h,
                              ),
                            ),
                            SizedBox(
                              width: 250.w,
                              height: 60.h,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      'Set Business Location',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        height: 1.7142857143.h,
                                        color: const Color(0xff1f2b2e),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      locationController.currentAddress.value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        height: 1.3333333333.h,
                                        color: const Color(0xff999999),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
