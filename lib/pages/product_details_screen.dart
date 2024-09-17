import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:vendor/widgets/custom_drawer_nav.dart';

import '../controllers/product_data_controller.dart';
import '../controllers/user_controller.dart';

class ProductDetailsPage extends StatefulWidget {
  final String docId;
  const ProductDetailsPage({super.key, required this.docId});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();
  String color = "";
  bool isOpened = false;

  bool isEditing = false;
  RxString selectedProductCategory = RxString(''); // Initial value
  List<String> productCategories = [
    'Art and Craft',
    'Electronics',
    'Health and Beauty',
    'Fashion',
    'Food and Groceries',
    'Others',
  ];
  bool _isUpdating = false;

  String? isSelectedCat;

  var productName = TextEditingController();
  var productPrice = TextEditingController();
  var desc = TextEditingController();

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

  int currentIndex = 1;
  int totalLength = 0;

  UserController userController = Get.put(UserController());

  final ProductDataController productDataController =
      Get.put(ProductDataController());

  @override
  void initState() {
    productDataController.getProduct(widget.docId);
    productDataController.listenToSubcollection(widget.docId);

    super.initState();
  }

  Future<void> updateDataToFirebase() async {
    setState(() {
      _isUpdating = true;
    });

    try {
      // Prepare data to update
      Map<String, dynamic> updatedData = {
        "productName": productName.text,
        "productPrice": double.parse(productPrice.text),
        "productDesc": desc.text,
        "selectedCategory":
            isSelectedCat!.isEmpty ? selectedProductCategory : isSelectedCat,
      };

      // Update data in Firebase
      await FirebaseFirestore.instance
          .collection('products')
          .doc(auth.currentUser!.uid)
          .collection("vendor_products")
          .doc(widget.docId)
          .update(updatedData);

      // Show success message
      Fluttertoast.showToast(
        msg: "Data updated successfully",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      // Show error message
      Fluttertoast.showToast(
        msg: "Failed to update data: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      setState(() {
        _isUpdating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = ScreenUtil().screenWidth;
    double height = ScreenUtil().screenHeight;
    return BlurryModalProgressHUD(
      inAsyncCall: _isUpdating,
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
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Column(children: [
              SizedBox(
                width: ScreenUtil().setWidth(140),
                height: ScreenUtil().setHeight(26),
                child: Text(
                  userController.user.value!.businessName!,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(20),
                    fontWeight: FontWeight.w600,
                    height: ScreenUtil().setHeight(1.2575),
                    color: const Color(0xff000000),
                  ),
                ),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(189),
                height: ScreenUtil().setHeight(16),
                child: Text(
                  'Home Cook • Fast food • Local • Wines',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(10),
                    fontWeight: FontWeight.w400,
                    height: ScreenUtil().setHeight(1.6),
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
              Padding(
                padding: EdgeInsets.only(right: ScreenUtil().setWidth(8)),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isEditing = !isEditing;
                    });
                    if (!isEditing) {
                      updateDataToFirebase();
                    }
                  },
                  child: Text(isEditing ? "Save" : "Edit"),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, ScreenUtil().setWidth(5), 0),
                width: ScreenUtil().setWidth(44),
                height: ScreenUtil().setHeight(44),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
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
          body: Obx(() {
            if (productDataController.product.value == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              productName.text =
                  productDataController.product.value!.productName;
              productPrice.text = productDataController
                  .product.value!.productPrice
                  .toStringAsFixed(0);
              desc.text = productDataController.product.value!.productDesc;
              selectedProductCategory.value =
                  productDataController.product.value!.selectedCategory;

              totalLength =
                  productDataController.product.value!.productUrls.length;

              if (!productCategories.contains(selectedProductCategory.value)) {
                // Add the fetched food category if it's not in the list
                productCategories
                    .add(productDataController.product.value!.selectedCategory);
              }

              List<DropdownMenuItem<String>> buildDropdownMenuItems(
                  List<String> categories) {
                List<DropdownMenuItem<String>> items = [];
                for (String category in categories) {
                  items.add(
                    DropdownMenuItem(
                      value: category, // Ensure each value is unique
                      child: Text(category),
                    ),
                  );
                }
                return items;
              }

              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(22),
                  vertical: ScreenUtil().setHeight(12),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 270.h,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: CarouselSlider.builder(
                                itemCount: productDataController
                                    .product.value!.productUrls.length,
                                itemBuilder: (BuildContext context,
                                    int itemIndex, int pageViewIndex) {
                                  return Padding(
                                    padding: REdgeInsets.all(15),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: CachedNetworkImage(
                                        width: 150.w,
                                        imageUrl: productDataController.product
                                            .value!.productUrls[itemIndex],
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  );
                                },
                                options: CarouselOptions(
                                  onPageChanged: (index, reason) {
                                    // Calculate current index out of total length
                                    setState(() {
                                      currentIndex = index + 1;
                                    });
                                    // debugPrint(
                                    //     'Page changed to index: $currentIndex');
                                    // debugPrint(
                                    //     'Current index out of total: $currentIndex/$totalLength');
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  '$currentIndex/$totalLength', // Initialize with the first index
                                  style: const TextStyle(fontSize: 14.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      const Text('Available Colors:'),
                      AbsorbPointer(
                        absorbing: !isEditing,
                        child: SizedBox(
                          height: 50.h,
                          child: Row(
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: productDataController
                                      .product.value!.colorAvailable.length,
                                  itemBuilder: (context, index) {
                                    final color = productDataController
                                        .product.value!.colorAvailable[index];
                                    return Container(
                                      margin: REdgeInsets.symmetric(
                                          horizontal: 3.w, vertical: 1.h),
                                      width: width * 0.07.w,
                                      height: height * 0.02697.h,
                                      decoration: BoxDecoration(
                                        color: colorFromString(color),
                                        shape: BoxShape.circle,
                                      ),
                                    );
                                  }),
                              InkWell(
                                  onTap: () {
                                    _showColorPickerDialog(context);
                                  },
                                  child: Image.asset(
                                    "images/add9.png",
                                    height: double.infinity.h,
                                  )),
                              InkWell(
                                onTap: () {
                                  if (productDataController.product.value!
                                      .colorAvailable.isNotEmpty) {
                                    // Remove the last color from the list
                                    productDataController
                                        .product.value!.colorAvailable
                                        .removeLast();
                                    // Update Firebase with the modified list
                                    productDataController.deleteColor(
                                        modifiedColorList: productDataController
                                            .product.value!.colorAvailable,
                                        docId: widget.docId);
                                  }
                                },
                                child: Container(
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                      color: productDataController.product
                                              .value!.colorAvailable.isNotEmpty
                                          ? colorFromString(
                                              productDataController.product
                                                  .value!.colorAvailable.last)
                                          : Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.red)),
                                  child: const Center(
                                      child: Icon(
                                    Icons.remove,
                                    color: Colors.orange,
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      TextField(
                        controller: productName,
                        enabled: isEditing,
                        decoration:
                            const InputDecoration(labelText: 'Product Name'),
                      ),
                      TextField(
                        controller: productPrice,
                        enabled: isEditing,
                        decoration:
                            const InputDecoration(labelText: 'Product Price'),
                      ),
                      TextField(
                        controller: desc,
                        enabled: isEditing,
                        decoration:
                            const InputDecoration(labelText: 'Description'),
                      ),
                      DropdownButtonFormField(
                        value: selectedProductCategory.isNotEmpty
                            ? selectedProductCategory.value
                            : null,
                        items: buildDropdownMenuItems(productCategories),
                        onChanged: isEditing
                            ? (value) {
                                setState(() {
                                  isSelectedCat = value.toString();
                                });
                              }
                            : null,
                        decoration: const InputDecoration(
                          labelText: 'Product Category',
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              const Text("Is the Package Fragible?"),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                  productDataController.product.value!.fragile
                                      ? "Yes"
                                      : "No",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.orange))
                            ],
                          ),
                          if (productDataController.product.value!.fragile)
                            Slider(
                              value: productDataController
                                  .product.value!.currentSliderValue,
                              min: 0,
                              max: 100,
                              divisions:
                                  100, // This will divide the slider into 100 divisions
                              label:
                                  '${productDataController.product.value!.currentSliderValue}', // Display current value as a label
                              onChanged: (value) {
                                // Handle slider value changes if needed
                              },
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              const Text("Is the Package Hazardous?"),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                productDataController.product.value!.hazardous
                                    ? "Yes"
                                    : "No",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.orange),
                              )
                            ],
                          ),
                          if (productDataController.product.value!.hazardous)
                            Slider(
                              value: productDataController
                                  .product.value!.currentHazardValue,
                              min: 0,
                              max: 100,
                              divisions:
                                  100, // This will divide the slider into 100 divisions
                              label:
                                  '${productDataController.product.value!.currentHazardValue}',
                              onChanged: (value) {
                                // Handle slider value changes if needed
                              },
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
        ),
      ),
    );
  }

  void _showColorPickerDialog(BuildContext context) {
    Color selectedColor = Colors.red; // Default color
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select a color'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
                selectedColor = color;
              },
            ),
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // Add the selected color to Firebase
                String colorString =
                    colorToString(selectedColor); // Convert color to string
                productDataController.product.value!.colorAvailable
                    .add(colorString); // Add color to the list
                productDataController.updateColors(
                    color: productDataController.product.value!.colorAvailable,
                    docId: widget.docId);
                Get.back();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  Color colorFromString(String colorString) {
    // Remove the leading '#' if present
    if (colorString.startsWith('#')) {
      colorString = colorString.substring(1);
    }
    // Parse the hexadecimal color string and convert it to a Color object
    return Color(int.parse(colorString, radix: 16) + 0xFF000000);
  }

  String colorToString(Color color) {
    // Using the hex value of the color and converting it to a string
    return color.value.toRadixString(16).toUpperCase();
  }
}
