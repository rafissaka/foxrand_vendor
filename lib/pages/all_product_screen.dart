import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:vendor/pages/published_products.dart';
import 'package:vendor/pages/unpublished_products.dart';
import 'package:vendor/widgets/custom_drawer_nav.dart';

import '../controllers/user_controller.dart';
import 'switch_product.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
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

  UserController userController = Get.put(UserController());

  @override
  void initState() {
    userController.subscribeToUserChanges();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SideMenu(
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
                    userController.user.value?.businessName ?? "",
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
                if (userController.user.value?.selectedShopType?.isNotEmpty ??
                    false)
                  Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => SwitchPage(
                              shopType:
                                  userController.user.value!.selectedShopType!,
                            ));
                      },
                      child: SizedBox(
                        width: 80.w,
                        height: 35.h,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xfffe724c),
                          ),
                          child: Center(
                            child: Text(
                              'Add Product',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                height: 1.2230000496.h,
                                color: const Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
              flexibleSpace: Stack(
                children: [
                  if (userController.user.value != null &&
                      userController.user.value!.downloadURL != null)
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
            body: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  ButtonsTabBar(
                    contentPadding: EdgeInsets.symmetric(horizontal: 30.w),
                    height: 50.h,
                    radius: 30.w,
                    backgroundColor: Theme.of(context).primaryColor,
                    unselectedBackgroundColor: Colors.white,
                    unselectedLabelStyle:
                        TextStyle(color: Theme.of(context).primaryColor),
                    labelStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    tabs: const [
                      Tab(
                        icon: Icon(Icons.directions_car),
                        text: "Published",
                      ),
                      Tab(
                        icon: Icon(Icons.directions_transit),
                        text: "Unpublished",
                      ),
                    ],
                  ),
                  const Expanded(
                    child: TabBarView(
                        children: [PublishedProducts(), UnpublishedProduct()]),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
