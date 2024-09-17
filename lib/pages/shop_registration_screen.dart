import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:vendor/controllers/logo_imagepick.dart';

import '../controllers/home_controller.dart';
import '../controllers/image_controller.dart';
import '../controllers/token_controller.dart';
import '../controllers/upload_registration_details.dart';
import '../controllers/vendor_controller.dart';
import '../widgets/business_info_widget.dart';
import '../widgets/financial_info_widget.dart';
import '../widgets/location_info_widget.dart';
import '../widgets/second_contact_widget.dart';
import '../widgets/shipping_info_widget.dart';
import '../widgets/show_error_snackbar.dart';
import 'login_page.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final VendorController vendorController = Get.put(VendorController());
  final HomeController _homeController = Get.put(HomeController());
  final ImagePickerController controller = Get.put(ImagePickerController());
  final UploadDetailsController uploadDetailsController =
      Get.put(UploadDetailsController());
  final logoPickerController = Get.put(LogoPickerController());
  final FCMController _fcmController = Get.put(FCMController());
  final _formKey = GlobalKey<FormState>();
  String? businessName;
  List<String> networkImages = [];
  XFile? pickedFile;
  String? selectedImage;

  @override
  void initState() {
    super.initState();
    _fcmController.retrieveToken();
    fetchDataFromFirestore();
  }

  Future<void> fetchDataFromFirestore() async {
    final firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firestore.collection('banners').get();

    if (snapshot.docs.isNotEmpty) {
      networkImages.clear();

      for (QueryDocumentSnapshot document in snapshot.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        String value = data['images'];
        networkImages.add(value);
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: DefaultTabController(
            length: 5,
            child: Builder(builder: (BuildContext context) {
              return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      title: const Text("Registration"),
                      expandedHeight: 300.0,
                      floating: false,
                      pinned: true,
                      actions: [
                        IconButton(
                            onPressed: () {
                              _homeController.signOut().then((value) {
                                Get.offAll(() => const LoginScreen());
                              });
                            },
                            icon: const Icon(Icons.exit_to_app)),
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                          background: SizedBox(
                        child: Stack(
                          children: [
                            Obx(() {
                              if (controller.selectedImagePath.value.isEmpty &&
                                  controller.imagePath.value.isEmpty) {
                                return Container(
                                    color: const Color(0xfffe724c),
                                    child: Center(
                                        child: TextButton(
                                            onPressed: () {
                                              showImageSelectDialog(context);
                                            },
                                            child: Text(
                                              "Tap to add shop image",
                                              style: TextStyle(
                                                  color: Colors.grey.shade800),
                                            ))));
                              } // Check if imagePath is empty and selectedImage is not
                              if (controller.imagePath.value.isEmpty &&
                                  controller
                                      .selectedImagePath.value.isNotEmpty) {
                                // Load image with NetworkProvider
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: double.infinity,
                                  child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          controller.selectedImagePath.value,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error)),
                                );
                              }

                              return SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: double.infinity,
                                child: Image.file(
                                  File(controller.imagePath.value),
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.fill,
                                ),
                              );
                            }),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: EdgeInsets.all(10.0.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Obx(
                                      () => logoPickerController
                                              .imagePath.value.isEmpty
                                          ? InkWell(
                                              onTap: () async {
                                                logoPickerController
                                                    .pickImage()
                                                    .whenComplete(() {
                                                  logoPickerController
                                                      .uploadImageToFirebase();
                                                });
                                              },
                                              child: Card(
                                                child: SizedBox(
                                                  height: 60.h,
                                                  width: 60.h,
                                                  child: const Center(
                                                      child: Text("+")),
                                                ),
                                              ),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Card(
                                                child: SizedBox(
                                                  height: 60.h,
                                                  width: 60.h,
                                                  child: Image.file(
                                                    File(logoPickerController
                                                        .imagePath.value),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      vendorController
                                              .vendorData!["businessName"] ??
                                          "Shop Name",
                                      style: const TextStyle(
                                          color: Colors.transparent),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        const TabBar(
                          isScrollable: true,
                          unselectedLabelColor: Colors.grey,
                          unselectedLabelStyle: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color.fromRGBO(142, 142, 142, 1)),
                          labelColor: Color(0xfffe724c),
                          labelStyle: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          indicatorColor: Colors.blue,
                          indicator: UnderlineTabIndicator(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                          ),
                          tabs: [
                            Tab(text: 'Business Info*'),
                            Tab(text: 'Second contact*'),
                            Tab(text: 'Location info*'),
                            Tab(text: 'Financial info*'),
                            Tab(text: 'Shipping and Fullfilment info'),
                          ],
                        ),
                      ]),
                    ),
                  ];
                },
                body: const TabBarView(
                  children: [
                    BusinessInfo(),
                    SecondContactInfo(),
                    LocationInfo(),
                    FinancialInfo(),
                    ShippingInfo(),
                  ],
                ),
              );
            })),
      ),
      persistentFooterButtons: [
        SizedBox(
          width: ScreenUtil().setWidth(400),
          height: ScreenUtil().setHeight(125),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(28.5.w, 10.h, 28.5.w, 2.h),
                width: ScreenUtil().setWidth(343),
                height: ScreenUtil().setHeight(63),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                ),
                child: Center(
                  child: SizedBox(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.625.h,
                          color: const Color(0xfffe724c),
                        ),
                        children: [
                          TextSpan(
                            text: 'By signing, you are agreeing with our \n',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              height: 1.625.h,
                              color: const Color(0xff999999),
                            ),
                          ),
                          TextSpan(
                            text: 'Terms of Use',
                            style: TextStyle(
                              fontSize: 15.sp,
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
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              height: 1.625.h,
                              color: const Color(0xff999999),
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              fontSize: 15.sp,
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
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(45)),
                      child: RawMaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        onPressed: () async {
                          if (vendorController.vendorData!["shopUrl"] == null) {
                            showErrorSnackbar(
                                context, "Please select Shop Banner");
                          } else if (vendorController.vendorData!["logoUrl"] ==
                              null) {
                            showErrorSnackbar(
                                context, "Please select logo image");
                          } else if (_formKey.currentState!.validate()) {
                            if (vendorController
                                    .vendorData!["secondContactName"] ==
                                null) {
                              showErrorSnackbar(context,
                                  "Please complete form by providing information under every second contact");
                            } else if (vendorController
                                    .vendorData!["landmark"] ==
                                null) {
                              showErrorSnackbar(context,
                                  "Please complete form by providing information under location info");
                            } else if (vendorController
                                    .vendorData!["accountName"] ==
                                null) {
                              showErrorSnackbar(context,
                                  "Please complete form by providing information under financial info");
                            } else if (vendorController
                                    .vendorData!["selectedcourierServices"] ==
                                null) {
                              showErrorSnackbar(context,
                                  "Please complete form by providing information under shipping and fullfilment info");
                            } else {
                              uploadDetailsController.saveDetails(
                                context: context,
                                downloadURL:
                                    controller.downloadURL.value.isEmpty
                                        ? controller.selectedImagePath.value
                                        : controller.downloadURL.value,
                                logoDownloadURL:
                                    logoPickerController.logoDownloadURL.value,
                                businessName: vendorController
                                    .vendorData!["businessName"],
                                contact:
                                    vendorController.vendorData!["contact"],
                                secContact:
                                    vendorController.vendorData!["secContact"],
                                email: vendorController.vendorData!["email"],
                                selectedShopType: vendorController
                                    .vendorData!["selectedShopType"],
                                secondContactName: vendorController
                                    .vendorData!["secondContactName"],
                                secondContact: vendorController
                                    .vendorData!["secondContact"],
                                secSecContact: vendorController
                                    .vendorData!["secSecContact"],
                                secEmail:
                                    vendorController.vendorData!["secEmail"],
                                shopAddress:
                                    vendorController.vendorData!["shopAddress"],
                                landmark:
                                    vendorController.vendorData!["landmark"],
                                geoLocation:
                                    vendorController.vendorData!["geoLocation"],
                                accountName:
                                    vendorController.vendorData!["accountName"],
                                accountNumber: vendorController
                                    .vendorData!["accountNumber"],
                                mobileMoneyName: vendorController
                                    .vendorData!["mobileMoneyName"],
                                mobileMoneyNumber: vendorController
                                    .vendorData!["mobileMoneyNumber"],
                                selectedcourierServices: vendorController
                                    .vendorData!["selectedcourierServices"],
                                specialRequirements: vendorController
                                    .vendorData!["specialRequirements"],
                                token: _fcmController.fcmToken!,
                              );
                            }
                          }
                        },
                        fillColor: const Color(0xfffe724c),
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> showImageSelectDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.cloud),
                  title: const Text('Select from Foxrand Images'),
                  onTap: () {
                    Get.back();
                    showNetworkImageSelectDialog(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.image),
                  title: const Text('Select from Gallery'),
                  onTap: () async {
                    Get.back();
                    pickedFile = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );
                    if (pickedFile != null) {
                      setState(() {
                        controller.imagePath.value = pickedFile!.path;
                      });
                      controller.uploadImageToFirebase();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> showNetworkImageSelectDialog(BuildContext context) async {
    selectedImage = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select a Network Image'),
          children: networkImages
              .map((imagePath) => SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, imagePath);
                    },
                    child: CachedNetworkImage(
                      imageUrl: imagePath,
                      placeholder: (context, url) => Lottie.asset(
                          'images/load.json',
                          width: ScreenUtil().setWidth(100),
                          height: ScreenUtil().setHeight(100)),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ))
              .toList(),
        );
      },
    );

    setState(() {
      if (selectedImage != null) {
        controller.selectedImagePath.value = selectedImage!;
      }
    });
    vendorController.getFormData(shopUrl: selectedImage);
  }
}
