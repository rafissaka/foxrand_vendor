import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/vendor_controller.dart';


class ShippingInfo extends StatefulWidget {
  const ShippingInfo({super.key});

  @override
  State<ShippingInfo> createState() => _ShippingInfoState();
}

class _ShippingInfoState extends State<ShippingInfo>
    with AutomaticKeepAliveClientMixin<ShippingInfo> {
  @override
  bool get wantKeepAlive => true;
  final VendorController vendorController = Get.put(VendorController());
  String? selectedcourierServices;
  List<String> courierServices = [
    "Same-day Services",
    "Express Service",
    "Parcel Services",
    "Standard Service"
  ];
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
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 90.h,
                  child: DropdownButtonFormField<String>(
                    value: selectedcourierServices,
                    items: courierServices.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedcourierServices = value;
                        vendorController.getFormData(
                            selectedcourierServices: value);
                      });
                    },
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      labelText: 'type of Courier Services',
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
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(2.w, 0, 1.h, 65.w),
                  padding: EdgeInsets.fromLTRB(20.h, 13.5.w, 20.h, 81.w),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffdddddd)),
                    color: const Color(0xfff7f7f7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 5.5.w),
                        child: Text(
                          'Special Shipping Requirements\n',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            height: 1.2125.h,
                            color: const Color(0xfffe724c),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 70.h,
                        child: TextFormField(
                          maxLines: 3,
                          onChanged: (val) {
                            vendorController.getFormData(
                                specialRequirements: val);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Place a new request';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.transparent,
                        ),
                      ),
                    ],
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
