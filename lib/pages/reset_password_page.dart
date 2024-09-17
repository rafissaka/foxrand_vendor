import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:vendor/widgets/custom_textformfield.dart';

import '../contants/colors.dart';
import '../widgets/custom_snack.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  bool _validateEmail(String email) {
    String emailPattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  final FocusNode _focusNode = FocusNode();
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                  'Rest Password',
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
                  'Please enter your email address to request a password reset',
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
                    child: CustomAnimatedTextFormField(
                      controller: _emailController,
                      labelText: 'Email',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        } else if (!_validateEmail(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      focusNode: _focusNode,
                      iconData: CupertinoIcons.mail,
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
                              icon:
                                  const Icon(Icons.cancel, color: Colors.white),
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
                            context.loaderOverlay.show();

                            Future.delayed(const Duration(seconds: 5), () {
                              context.loaderOverlay.hide();
                              Get.snackbar(
                                'Email', 
                                'Done',
                                snackPosition: SnackPosition
                                    .BOTTOM, 
                                backgroundColor: Colors
                                    .transparent, 
                                margin: EdgeInsets.zero,
                                borderRadius: 8.0, 
                                messageText: CustomSnackBar(
                                    message:
                                        'A reset link has been sent to ${_emailController.text.trim()}.Please check to reset password'), // Custom SnackBar widget
                              );
                            });
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
    );
  }
}
