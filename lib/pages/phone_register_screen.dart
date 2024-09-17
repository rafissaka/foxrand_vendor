import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:vendor/contants/colors.dart';

import 'opt_page.dart';

class PhoneRegisterPage extends StatefulWidget {
  const PhoneRegisterPage({super.key});

  @override
  State<PhoneRegisterPage> createState() => _PhoneRegisterPageState();
}

class _PhoneRegisterPageState extends State<PhoneRegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(20),
              vertical: ScreenUtil().setHeight(100)),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 90, 8),
                  child: const Text(
                    'Registration with phone number',
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
                    'Enter your phone number to verify your account',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.3769999913.h,
                      color: const Color(0xff9796a1),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a phone number';
                          }
                          if (!value.startsWith('+233')) {
                            return 'Phone number must start with +233';
                          }
                          if (value.length != 13) {
                            return 'Invalid phone number without zero';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          prefixIcon: const Icon(Icons.phone),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtil().setHeight(30)),
                Row(
                  children: [
                    Expanded(
                      child: ProgressButton.icon(
                          iconedButtons: {
                            ButtonState.idle: const IconedButton(
                                text: "Submit",
                                icon: Icon(Icons.send, color: Colors.white),
                                color: AppColors.primaryColor),
                            ButtonState.loading: IconedButton(
                                text: "Loading",
                                color: Colors.deepPurple.shade700),
                            ButtonState.fail: IconedButton(
                                text: "Failed",
                                icon: const Icon(Icons.cancel,
                                    color: Colors.white),
                                color: Colors.red.shade300),
                            ButtonState.success: IconedButton(
                                text: "Success",
                                icon: const Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                ),
                                color: Colors.green.shade400)
                          },
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              String phoneNumber = _phoneNumberController.text;
                              Get.to(() => OptPage(
                                    number: phoneNumber,
                                  ));
                            }
                          },
                          state: ButtonState.idle),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
