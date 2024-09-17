import 'dart:io';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:get/get.dart';

import '../controllers/color_controller.dart';
import '../controllers/product_image_controller.dart';
import '../controllers/product_upload_controller.dart';
import '../controllers/user_controller.dart';
import '../widgets/custom_drawer_nav.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  UserController userController = Get.put(UserController());

  final ProductImagePickerController _productImagePickerController =
      Get.put(ProductImagePickerController());

  final ColorPickerController controller = Get.put(ColorPickerController());

  final ProductUploadController _productUploadController =
      Get.put(ProductUploadController());

  var name = TextEditingController();
  var price = TextEditingController();
  var about = TextEditingController();
  int indexFra = -1;
  int indexHa = -1;

  String? selectedCategory;
  List<bool> isSelected = [false, false];

  List<bool> isSelectedFra = [false, false];
  List<String> categories = [
    "None",
    'Art and Craft',
    'Electronics',
    'Health and Beauty',
    'Fashion',
    'Food and Groceries',
    'Others',
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

  double _currentSliderValue = 0.0;

  double _currenthazardValue = 0.0;

  final _formKey = GlobalKey<FormState>();

  List<String> colorStrings = [];

  clearAll() {
    name.clear();
    price.clear();
    about.clear();
    selectedCategory = 'None';
    _productImagePickerController.clearPickedImages();
    _currentSliderValue = 0;
    _currenthazardValue = 0;
    controller.selectedColors.clear();
    colorStrings.clear();
    setState(() {
      isSelected = [false, false];
      isSelectedFra = [false, false];
      indexHa = -1;
      indexFra = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Obx(() {
      return BlurryModalProgressHUD(
        inAsyncCall: _productUploadController.isloading.value,
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
                      margin: REdgeInsets.fromLTRB(0, 0, 5.w, 0),
                      width: 44.w,
                      height: 44.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r)),
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
                            image: NetworkImage(userController.user.value!
                                .downloadURL!), // Replace with your background image asset
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white
                            .withOpacity(0.7), // Adjust the opacity as needed
                      ),
                    ],
                  ),
                ),
                body: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Padding(
                      padding: REdgeInsets.symmetric(
                          horizontal: 22.w, vertical: 12.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: width,
                                  height: height * 0.23.h,
                                  child: Stack(
                                    children: [
                                      Obx(
                                        () => _productImagePickerController
                                                .pickedImages.isNotEmpty
                                            ? Positioned(
                                                left: width * 0.2,
                                                top: 0.h,
                                                child: Container(
                                                  margin: REdgeInsets.only(
                                                      top: 5.h),
                                                  height: height * 0.220.h,
                                                  width: width * 0.510.w,
                                                  child: PhotoView(
                                                    backgroundDecoration:
                                                        BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    imageProvider: FileImage(
                                                        File(_productImagePickerController
                                                            .pickedImages[
                                                                _productImagePickerController
                                                                    .currentIndex]
                                                            .path),
                                                        scale: 100),
                                                  ),
                                                ),
                                              )
                                            : Positioned(
                                                left: width * 0.2,
                                                top: 0.h,
                                                child: Container(
                                                  margin: REdgeInsets.only(
                                                      top: 5.h),
                                                  height: height * 0.220.h,
                                                  width: width * 0.510.w,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[300],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.r)),
                                                  child: const Center(
                                                    child: Text(
                                                        'No image selected'),
                                                  ),
                                                ),
                                              ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: height * 0.1,
                                        child: SizedBox(
                                          width: width * 0.9,
                                          height: height * 0.05,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 29.61.w,
                                                height: 28.34.h,
                                                child: InkWell(
                                                  onTap: () {
                                                    _productImagePickerController
                                                        .previousImage();
                                                  },
                                                  child: Image.asset(
                                                    'images/arrowl.png',
                                                    width: 29.61.w,
                                                    height: 28.34.h,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 29.61.w,
                                                height: 28.34.h,
                                                child: InkWell(
                                                  onTap: () {
                                                    _productImagePickerController
                                                        .nextImage();
                                                  },
                                                  child: Image.asset(
                                                    'images/arrowR.png',
                                                    width: 29.61.w,
                                                    height: 28.34.h,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: REdgeInsets.all(8),
                            width: double.infinity,
                            height: height * 0.08,
                            child: Row(
                              children: [
                                Obx(
                                  () => ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: _productImagePickerController
                                        .pickedImages.length,
                                    itemBuilder: (context, index) {
                                      final pickedImage =
                                          _productImagePickerController
                                              .pickedImages[index];
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            _productImagePickerController
                                                .currentIndex = index;
                                          });
                                        },
                                        child: Container(
                                          padding: REdgeInsets.fromLTRB(
                                              5.34, 5.57, 5.34, 5.57),
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffffffff),
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color(0x3f000000),
                                                offset: Offset(0, 2),
                                                blurRadius: 2,
                                              ),
                                            ],
                                          ),
                                          child: SizedBox(
                                            width: 50.w,
                                            height: 50.h,
                                            child: Image.file(
                                              File(pickedImage.path),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                InkWell(
                                    onTap: () {
                                      _showImageSourceDialog(context);
                                    },
                                    child: Image.asset(
                                      "images/add.png",
                                      height: double.infinity.h,
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            margin: REdgeInsets.fromLTRB(0, 0, 0, 18.h),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter food name';
                                }

                                return null;
                              },
                              controller: name,
                              decoration: const InputDecoration(
                                  label: Text("Product Name")),
                            ),
                          ),
                          Container(
                            margin: REdgeInsets.fromLTRB(0, 0, 0, 18.h),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter product price';
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
                            margin: REdgeInsets.fromLTRB(0, 6.h, 200.w, 0),
                            child: Text(
                              'Available Colors',
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                height: 1.2575.h,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            margin: REdgeInsets.fromLTRB(0, 0, 1.w, 0),
                            width: double.infinity,
                            height: height * 0.04891,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(children: [
                                Obx(
                                  () => ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: controller.selectedColors.length,
                                    itemBuilder: (context, index) {
                                      final Color? color =
                                          controller.selectedColors.isNotEmpty
                                              ? controller.selectedColors[index]
                                              : null;
                                      if (color != null) {
                                        return Container(
                                          margin: REdgeInsets.symmetric(
                                              horizontal: 3.w, vertical: 1.h),
                                          width: width * 0.07.w,
                                          height: height * 0.02697.h,
                                          decoration: BoxDecoration(
                                            color: color,
                                            shape: BoxShape.circle,
                                          ),
                                        );
                                      } else {
                                        return const SizedBox.shrink();
                                      }
                                    },
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Pick a color!'),
                                            content: SingleChildScrollView(
                                              child: BlockPicker(
                                                pickerColor: Colors
                                                    .white, // Default color
                                                onColorChanged: (Color color) {
                                                  // Safe call to addColor
                                                  if (!controller.selectedColors
                                                      .contains(color)) {
                                                    controller.addColor(color);
                                                  }
                                                  colorStrings = controller
                                                      .selectedColors
                                                      .map((color) =>
                                                          colorToString(color))
                                                      .toList();
                                                  Get.back(); // Close the dialog safely
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Image.asset(
                                      "images/add9.png",
                                      height: double.infinity.h,
                                    )),
                              ]),
                            ),
                          ),
                          Container(
                            margin: REdgeInsets.fromLTRB(0, 15.h, 200.w, 10.h),
                            child: Text(
                              ' Product Category',
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                height: 1.2575.h,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                              height: height * 0.059.h,
                              width: width * 0.643.w,
                              decoration: BoxDecoration(
                                  color: const Color(0xffF8F8F8),
                                  border: Border.all(
                                      color: const Color(0xffDDDDDD)),
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Padding(
                                padding: REdgeInsets.only(left: 20.w),
                                child: DropdownButton<String>(
                                  hint: const Text('Product Category '),
                                  value: selectedCategory,
                                  icon: const Icon(
                                    Ionicons.chevron_down,
                                    color: Color(0xffFE724C),
                                  ),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedCategory = newValue;
                                    });
                                  },
                                  items: categories.map((category) {
                                    return DropdownMenuItem(
                                      value: category,
                                      child: Text(category),
                                    );
                                  }).toList(),
                                  underline: Container(),
                                ),
                              )),
                          SizedBox(
                            height: height * 0.030.h,
                          ),
                          Container(
                            width: width,
                            height: 94.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: TextFormField(
                                controller: about,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter product description';
                                  }

                                  return null;
                                },
                                maxLines: 3,
                                decoration: InputDecoration(
                                    labelText: 'Product Description',
                                    filled: true,
                                    fillColor: const Color(0xffFFF2EE),
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                          ),
                          Padding(
                            padding: REdgeInsets.fromLTRB(5.w, 0, 10.w, 10.h),
                            child: const Divider(
                              thickness: 1,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Is the Package Fragible? ',
                                style: GoogleFonts.poppins(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2575.h,
                                  color: const Color(0xff323643),
                                ),
                              ),
                              SizedBox(
                                  width: width * 0.350.w,
                                  height: height * 0.035.h,
                                  child: ToggleButtons(
                                    isSelected: isSelectedFra,
                                    onPressed: (int index) {
                                      setState(() {
                                        for (int i = 0;
                                            i < isSelectedFra.length;
                                            i++) {
                                          isSelectedFra[i] = i == index;
                                        }
                                        indexFra = index;
                                      });
                                    },
                                    selectedColor: isSelectedFra
                                            .any((isSelected) => isSelected)
                                        ? Colors.white
                                        : null,
                                    fillColor: const Color(0xfffe724c),
                                    borderColor: const Color(0xfffe724c),
                                    borderRadius: BorderRadius.circular(8.0),
                                    children: const [
                                      Text('Yes'),
                                      Text('No'),
                                    ],
                                  )),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Visibility(
                            visible: indexFra == 0 ? true : false,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Level of Fragility?',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2575.h,
                                    color: const Color(0xff7c7c7c),
                                  ),
                                ),
                                Slider(
                                  activeColor: Theme.of(context).primaryColor,
                                  thumbColor: Theme.of(context).primaryColor,
                                  value: _currentSliderValue,
                                  min: 0,
                                  max: 100,
                                  divisions: 10,
                                  label: _currentSliderValue.round().toString(),
                                  onChanged: (double value) {
                                    setState(() {
                                      _currentSliderValue = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Divider(
                            thickness: 1.w,
                            color: Colors.grey,
                          ),
                          Row(
                            children: [
                              Text(
                                'Is the Package Hazardous? ',
                                style: GoogleFonts.poppins(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2575.h,
                                  color: const Color(0xff323643),
                                ),
                              ),
                              SizedBox(
                                  width: width * 0.300.w,
                                  height: height * 0.035.h,
                                  child: ToggleButtons(
                                    isSelected: isSelected,
                                    onPressed: (int index) {
                                      setState(() {
                                        // Update the selection when a button is pressed
                                        for (int i = 0;
                                            i < isSelected.length;
                                            i++) {
                                          isSelected[i] = i == index;
                                        }
                                        indexHa = index;
                                      });
                                    },
                                    selectedColor: isSelected
                                            .any((isSelected) => isSelected)
                                        ? Colors.white
                                        : null,
                                    fillColor: const Color(0xfffe724c),
                                    borderColor: const Color(0xfffe724c),
                                    borderRadius: BorderRadius.circular(8.0),
                                    children: const <Widget>[
                                      Text('Yes'),
                                      Text('No'),
                                    ],
                                  )),
                            ],
                          ),
                          Visibility(
                            visible: indexHa == 0 ? true : false,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Level of Hazardousness',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2575.h,
                                    color: const Color(0xff7c7c7c),
                                  ),
                                ),
                                Slider(
                                  activeColor: Theme.of(context).primaryColor,
                                  thumbColor: Theme.of(context).primaryColor,
                                  value: _currenthazardValue,
                                  min: 0,
                                  max: 100,
                                  divisions: 10,
                                  label: _currenthazardValue.round().toString(),
                                  onChanged: (double value) {
                                    setState(() {
                                      _currenthazardValue = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Divider(
                            thickness: 1.w,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 15.h),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_productImagePickerController
                                        .pickedImages.isNotEmpty) {
                                      if (selectedCategory != null &&
                                          selectedCategory != "None") {
                                        if (indexFra != -1) {
                                          if (indexHa != -1) {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _productUploadController
                                                  .uploadData(
                                                      selectedCategory:
                                                          selectedCategory,
                                                      businessName:
                                                          userController
                                                              .user
                                                              .value!
                                                              .businessName!,
                                                      productName:
                                                          name.text.trim(),
                                                      productPrice: double.parse(
                                                          price.text.trim()),
                                                      colorAvailable:
                                                          colorStrings,
                                                      productDesc:
                                                          about.text.trim(),
                                                      isSelectedFr:
                                                          indexFra == 0
                                                              ? true
                                                              : false,
                                                      isSelected: indexHa == 0
                                                          ? true
                                                          : false,
                                                      currentSliderValue:
                                                          _currentSliderValue,
                                                      currentHazardValue:
                                                          _currenthazardValue,
                                                      images:
                                                          _productImagePickerController
                                                              .pickedImages,
                                                      context: context)
                                                  .then((value) {
                                                clearAll();
                                              });
                                            }
                                          } else {
                                            Fluttertoast.showToast(
                                              msg:
                                                  "Please state if product is hazardous",
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
                                                "Please state if product is fragible",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0,
                                          );
                                        }
                                      } else {
                                        Fluttertoast.showToast(
                                          msg: "Please select product category",
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
                                            "Please select product image or images",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: const Color(0xffFE724C),
                                    elevation: 5,
                                    minimumSize: const Size(200, 50),
                                  ),
                                  child: const Text(
                                    'Upload Details',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: REdgeInsets.fromLTRB(10.w, 10.h, 12.w, 0),
                            width: double.infinity.spMax,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: REdgeInsets.fromLTRB(0, 3, 13, 0),
                                  width: width * 0.05,
                                  height: height * 0.07,
                                  child: Image.asset(
                                    'images/mark.png',
                                    width: width * 0.05,
                                    height: height * 0.07,
                                  ),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth: 305.r,
                                  ),
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
                                            decoration:
                                                TextDecoration.underline,
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
                                            decoration:
                                                TextDecoration.underline,
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
    });
  }

  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick Image From:'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _productImagePickerController.pickImage(ImageSource.camera);
                Navigator.of(context).pop();
              },
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: () {
                _productImagePickerController.pickImage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
              child: const Text('Gallery'),
            ),
          ],
        );
      },
    );
  }

  String colorToString(Color color) {
    // Using the hex value of the color and converting it to a string
    return color.value.toRadixString(16).toUpperCase();
  }
}
