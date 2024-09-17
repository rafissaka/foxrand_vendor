import 'dart:io';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:vendor/controllers/food_upload_controller.dart';
import 'package:vendor/controllers/user_controller.dart';

import '../controllers/addon_controller.dart';
import '../models/addon_models.dart';
import '../widgets/custom_drawer_nav.dart';

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({super.key});

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen>
    with AutomaticKeepAliveClientMixin<AddFoodScreen> {
  bool _isChecked = false;
  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory;
  final FoodImagePickerController controller =
      Get.put(FoodImagePickerController());

  final List<String> _foodCategories = [
    'None',
    'Italian',
    'Mexican',
    'Japanese',
    'Chinese',
    'Indian',
    'American',
    'Thai',
  ];
  bool isOpened = false;

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();

  toggleMenu([bool end = false]) {
    if (end) {
      final state = _endSideMenuKey.currentState!;
      if (state.isOpened) {
        state.closeSideMenu();
      } else {
        state.openSideMenu();
      }
    } else {
      final state = _sideMenuKey.currentState!;
      if (state.isOpened) {
        state.closeSideMenu();
      } else {
        state.openSideMenu();
      }
    }
  }

  var name = TextEditingController();
  var price = TextEditingController();
  var about = TextEditingController();
  var preparationTime = TextEditingController();
  String foodId = "";
  String _selectedUnit = 'seconds';
  final AddonController addonController = Get.put(AddonController());

  UserController userController = Get.put(UserController());

  @override
  void initState() {
    userController.subscribeToUserChanges();
    super.initState();
  }

  clearAll() {
    name.clear();
    price.clear();
    about.clear();
    preparationTime.clear();
    _selectedUnit = 'seconds';
    _selectedCategory = 'None';
    addonController.addons.clear();
    controller.imagePath.value = "";
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlurryModalProgressHUD(
      inAsyncCall: isLoading,
      color: Colors.black54,
      opacity: 0.5,
      child: SideMenu(
        background: const Color(0xffffffff),
        key: _sideMenuKey,
        menu: const Nav(),
        type: SideMenuType.slideNRotate,
        onChange: (isOpened) {
          setState(() => isOpened = isOpened);
        },
        child: IgnorePointer(
            ignoring: isOpened,
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Column(children: [
                  SizedBox(
                    width: 140.w,
                    height: 26.h,
                    child: Text(
                      userController.user.value!.businessName!,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.2575.h,
                        color: const Color(0xff000000),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 189.w,
                    height: 16.h,
                    child: Text(
                      'Home Cook • Fast food • Local • Wines',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.6.h,
                        color: const Color(0xff797878),
                      ),
                    ),
                  ),
                ]),
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(
                    Icons.menu,
                  ),
                  onPressed: () {
                    toggleMenu();
                  },
                ),
                actions: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 15.w, 0),
                    width: 44.w,
                    height: 44.h,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: CachedNetworkImage(
                      placeholder: (context, url) => const AspectRatio(
                        aspectRatio: 1.6,
                        child: BlurHash(hash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                      ),
                      imageUrl: userController.user.value!.logoDownloadURL!,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
                flexibleSpace: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              userController.user.value!.downloadURL!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ],
                ),
              ),
              body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 22.w, vertical: 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() {
                          if (controller.imagePath.value.isEmpty) {
                            return Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 18.h),
                                width: screenWidth * 0.9.w,
                                height: screenHeight * 0.25.h,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: screenWidth * 0.75.w,
                                      bottom: screenHeight * 0.01.h,
                                      child: InkWell(
                                          onTap: () {
                                            _showPicker(context);
                                          },
                                          child: Image.asset("images/add.png")),
                                    ),
                                  ],
                                ));
                          }
                          return Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 18.h),
                              width: screenWidth * 0.9.w,
                              height: screenHeight * 0.27.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                      left: 0,
                                      right: 0,
                                      child: Card(
                                        elevation: 4,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: Image.file(
                                            File(controller.imagePath.value),
                                            width: screenWidth * 0.9.w,
                                            height: screenHeight * 0.26.h,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )),
                                  Positioned(
                                    left: screenWidth * 0.75.w,
                                    bottom: screenHeight * 0.01.h,
                                    child: InkWell(
                                        onTap: () {
                                          _showPicker(context);
                                        },
                                        child: Image.asset("images/add.png")),
                                  ),
                                ],
                              ));
                        }),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 18.h),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter food name';
                              }

                              return null;
                            },
                            controller: name,
                            decoration:
                                const InputDecoration(label: Text("Food Name")),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 18.h),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter food price';
                              }

                              return null;
                            },
                            keyboardType: TextInputType.number,
                            controller: price,
                            decoration:
                                const InputDecoration(label: Text("Price")),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 18.h),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter food description';
                              }

                              return null;
                            },
                            maxLines: 3,
                            controller: about,
                            decoration: const InputDecoration(
                                label: Text("Description")),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 18.h),
                          child: DropdownButton<String>(
                            hint: const Text('Select a category'),
                            value: _selectedCategory,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedCategory = newValue;
                                controller
                                    .getCount(_selectedCategory!)
                                    .then((value) {
                                  int number = controller.count.value + 1;
                                  String seller = getFirstThreeUpperCase(
                                      userController.user.value!.businessName!);
                                  String result = getFirstThreeUpperCase(
                                      _selectedCategory!);
                                  foodId =
                                      "$seller-$result-00${number.toStringAsFixed(0)}";
                                });
                              });
                            },
                            items: _foodCategories
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                controller: preparationTime,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Preparation Time',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter preparation time';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: _selectedUnit,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedUnit = newValue!;
                                  });
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select a unit';
                                  }
                                  return null;
                                },
                                items: <String>[
                                  'seconds',
                                  'minutes',
                                  'hours',
                                  'days',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 140.w,
                              height: 23.h,
                              child: Text(
                                'Choice of Add On',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2575.h,
                                  color: const Color(0xff323643),
                                ),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 2.w, 0),
                                child: TextButton(
                                  onPressed: () async {
                                    final Addon? newAddon = await Get.dialog(
                                      Dialog(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                TextField(
                                                  decoration:
                                                      const InputDecoration(
                                                          labelText:
                                                              'Addon Name'),
                                                  onChanged: (value) =>
                                                      addonController.addonName
                                                          .value = value,
                                                ),
                                                const SizedBox(height: 10),
                                                TextField(
                                                  decoration:
                                                      const InputDecoration(
                                                          labelText: 'Price'),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onChanged: (value) =>
                                                      addonController
                                                              .price.value =
                                                          double.tryParse(
                                                                  value) ??
                                                              0.0,
                                                ),
                                                SizedBox(height: 20.h),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    addonController.saveAddon();
                                                  },
                                                  child: const Text('Save'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                    if (newAddon != null) {
                                      addonController.addAddon(
                                        newAddon.name,
                                        newAddon.price,
                                      );
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(6.w)),
                                    child: Text(
                                      'Add...',
                                      style: GoogleFonts.inter(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        height: 1.2125.h,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        Obx(() {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: addonController.addons.length,
                            itemBuilder: (context, index) {
                              final addon = addonController.addons[index];
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 39.17.h,
                                    child: Text(
                                      addon.name,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        height: 1.5.h,
                                        color: const Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        0, 5.83, 7, 0),
                                    child: Text(
                                      '+GHS${addon.price.toStringAsFixed(2)}',
                                      textAlign: TextAlign.right,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        height: 1.5.h,
                                        color: const Color(0xfffe724c),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8.h),
                          width: double.infinity,
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_isChecked) {
                                if (controller.imagePath.value.isNotEmpty) {
                                  if (_selectedCategory != null &&
                                      _selectedCategory != "None") {
                                    if (_formKey.currentState!.validate()) {
                                      if (kDebugMode) {
                                        print(
                                            'Preparation Time: ${preparationTime.text} $_selectedUnit');
                                      }
                                      setState(() {
                                        isLoading = !isLoading;
                                      });
                                      controller
                                          .uploadFoodImageToFirebase(
                                              businessName: userController
                                                  .user.value!.businessName!,
                                              foodName: name.text.trim())
                                          .then((value) {
                                        controller
                                            .uploadFoodDetails(
                                                vendorId: userController
                                                    .user.value!.uid!,
                                                data: {
                                                  "approved": false,
                                                  "foodId": foodId,
                                                  "seller": userController.user
                                                      .value!.businessName!,
                                                  "foodName": name.text.trim(),
                                                  "foodPrice":
                                                      price.text.trim(),
                                                  "processTime":
                                                      preparationTime.text,
                                                  "processTimeUnit":
                                                      _selectedUnit,
                                                  "foodUrl": controller
                                                      .foodDownloadURL.value,
                                                  "desc": about.text.trim(),
                                                  "foodCat": _selectedCategory,
                                                  "addOns": addonController
                                                      .addons
                                                      .map((addon) {
                                                    return {
                                                      'name': addon.name,
                                                      'price': addon.price,
                                                    };
                                                  }).toList(),
                                                },
                                                context: context)
                                            .then((value) {
                                          clearAll();
                                          setState(() {
                                            isLoading = !isLoading;
                                          });
                                        });
                                      });
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: "Please select food category",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "Please select food image",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                }
                              } else {
                                Fluttertoast.showToast(
                                  msg:
                                      "Please agree to the terms and conditions",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return const Color(0xfffe724c);
                                  }
                                  return const Color(0xfffe724c);
                                },
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: const BorderSide(
                                      color: Color(0xfffe724c)),
                                ),
                              ),
                              elevation: MaterialStateProperty.all<double>(8.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: isLoading
                                  ? const Center(
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      "Save",
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(10.w, 10.h, 12.w, 0),
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: _isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    _isChecked = value!;
                                  });
                                },
                              ),
                              Flexible(
                                child: RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.inter(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      height: 1.625.h,
                                      color: const Color(0xfffe724c),
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            'By Publishing, you are agreeing with our ',
                                        style: GoogleFonts.inter(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          height: 1.625.h,
                                          color: const Color(0xff999999),
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Terms and conditions ',
                                        style: GoogleFonts.inter(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          height: 1.625.h,
                                          decoration: TextDecoration.underline,
                                          color: const Color(0xfffe724c),
                                          decorationColor:
                                              const Color(0xfffe724c),
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'and ',
                                        style: GoogleFonts.inter(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          height: 1.625.h,
                                          color: const Color(0xff999999),
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Privacy Policy',
                                        style: GoogleFonts.inter(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          height: 1.625.h,
                                          decoration: TextDecoration.underline,
                                          color: const Color(0xfffe724c),
                                          decorationColor:
                                              const Color(0xfffe724c),
                                        ),
                                      ),
                                    ],
                                  ),
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
            )),
      ),
    );
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  controller.pickImage(ImageSource.gallery);
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  controller.pickImage(ImageSource.camera);
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String getFirstThreeUpperCase(String? input) {
    if (input!.length < 3) {
      return input.toUpperCase();
    } else {
      return input.substring(0, 3).toUpperCase();
    }
  }

  @override
  bool get wantKeepAlive => true;
}
