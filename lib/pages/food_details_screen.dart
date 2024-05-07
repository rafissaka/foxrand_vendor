import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:vendor/widgets/custom_drawer_nav.dart';

import '../controllers/user_controller.dart';

class FoodDetailsScreen extends StatefulWidget {
  final String docId;
  const FoodDetailsScreen({
    super.key,
    required this.docId,
  });

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool isOpened = false;
  bool isEditing = false;
  bool _isUpdating = false;

  var foodName = TextEditingController();
  var foodPrice = TextEditingController();
  var desc = TextEditingController();
  var addOnName = TextEditingController();
  var addOnPrice = TextEditingController();
  String image = "";
  String selectedFoodCategory = ''; 
  List<String> foodCategories = ['Local', 'Rice', 'Asian'];
  List<Map<String, dynamic>> addOns = [];

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

  UserController userController = Get.put(UserController());

  void addAddOn() {
    setState(() {
      addOns.add({
        "name": addOnName.text,
        "price": addOnPrice.text,
      });
  
      addOnName.clear();
      addOnPrice.clear();
    });
  }

  void deleteAddOn(int index) {
    setState(() {
      addOns.removeAt(index);
    });
  }

  Future<void> showAddOnDialog(BuildContext context) async {
    String newName = '';
    String newPrice = '';

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Add-on'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  newName = value;
                },
                decoration: const InputDecoration(labelText: 'Add-on Name'),
              ),
              TextField(
                onChanged: (value) {
                  newPrice = value;
                },
                decoration: const InputDecoration(labelText: 'Add-on Price'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  addOns.add({
                    'name': newName,
                    'price': newPrice,
                  });
                });
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> fetchDataFromFirebase() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('foods')
          .doc(auth.currentUser!.uid)
          .collection("vendor_foods")
          .doc(widget.docId)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        setState(() {
          foodName.text = data["foodName"] ?? '';
          foodPrice.text = data["foodPrice"] ?? '';
          desc.text = data["desc"] ?? '';
          selectedFoodCategory = data["foodCat"] ?? '';
          addOns = List<Map<String, dynamic>>.from(data["addOns"] ?? []);
          image = data["foodUrl"] ?? "";
          if (!foodCategories.contains(selectedFoodCategory)) {
       
            foodCategories.add(selectedFoodCategory);
          }
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching data: $e");
      }
    }
  }

  @override
  void initState() {
    fetchDataFromFirebase();
    super.initState();
  }


  List<DropdownMenuItem<String>> buildDropdownMenuItems(
      List<String> categories) {
    List<DropdownMenuItem<String>> items = [];
    for (String category in categories) {
      items.add(
        DropdownMenuItem(
          value: category,
          child: Text(category),
        ),
      );
    }
    return items;
  }

  Future<void> updateDataToFirebase() async {
    setState(() {
      _isUpdating = true;
    });

    try {
   
      Map<String, dynamic> updatedData = {
        "foodName": foodName.text,
        "foodPrice": foodPrice.text,
        "desc": desc.text,
        "foodCat": selectedFoodCategory,
        "addOns": addOns,
      };

    
      await FirebaseFirestore.instance
          .collection('foods')
          .doc(auth.currentUser!.uid)
          .collection("vendor_foods")
          .doc(widget.docId)
          .update(updatedData);

     
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
    double screenWidth = ScreenUtil().screenWidth;
    double screenHeight = ScreenUtil().screenHeight;

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
                          .downloadURL!), 
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  color: Colors.white
                      .withOpacity(0.7), 
                ),
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(22),
              vertical: ScreenUtil().setHeight(12),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0, 0, 0, ScreenUtil().setHeight(18)),
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.27,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(
                          image,
                          width: screenWidth * 0.9,
                          height: screenHeight * 0.26,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                                child: CircularProgressIndicator.adaptive());
                          },
                        ),
                      ),
                    ),
                  ),
                  TextField(
                    controller: foodName,
                    enabled: isEditing,
                    decoration: const InputDecoration(labelText: 'Food Name'),
                  ),
                  TextField(
                    controller: foodPrice,
                    enabled: isEditing,
                    decoration: const InputDecoration(labelText: 'Food Price'),
                  ),
                  TextField(
                    controller: desc,
                    enabled: isEditing,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  DropdownButtonFormField(
                    value: selectedFoodCategory.isNotEmpty
                        ? selectedFoodCategory
                        : null,
                    items: buildDropdownMenuItems(foodCategories),
                    onChanged: isEditing
                        ? (value) {
                            setState(() {
                              selectedFoodCategory = value as String;
                            });
                          }
                        : null,
                    decoration: const InputDecoration(
                      labelText: 'Food Category',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add-ons:',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(16),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      
                        for (int index = 0; index < addOns.length; index++)
                          Row(
                            children: [
                        
                              Expanded(
                                child: TextField(
                                  controller: TextEditingController(
                                    text: addOns[index]['name']
                                        .toString(), 
                                  ),
                                  onChanged: (value) {
                                    addOns[index]['name'] = value;
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'Add-on Name'),
                                  enabled: isEditing,
                                ),
                              ),
                              SizedBox(width: ScreenUtil().setWidth(8)),
                              Expanded(
                                child: TextField(
                                  controller: TextEditingController(
                                    text: addOns[index]['price']
                                        .toString(), 
                                  ),
                                  onChanged: (value) {
                                    addOns[index]['price'] = value;
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'Add-on Price'),
                                  enabled: isEditing,
                                ),
                              ),
                              SizedBox(width: ScreenUtil().setWidth(8)),
                          
                              if (isEditing) ...[
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    deleteAddOn(index);
                                  },
                                ),
                              ],
                            ],
                          ),
                       
                        if (isEditing) ...[
                          ElevatedButton(
                            onPressed: () {
                              showAddOnDialog(context);
                            },
                            child: const Text('Add New Add-on'),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
