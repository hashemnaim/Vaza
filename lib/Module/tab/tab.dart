import 'dart:io';

import 'package:faza_app/services/admin_service.dart';
import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/favorite/controller/favorite_product_controller.dart';
import 'package:faza_app/Module/favorite/favorite_product_screen.dart';
import 'package:faza_app/Module/home/controller/home_controller.dart';
import 'package:faza_app/Module/home/home.dart';
import 'package:faza_app/Module/setting/profile/controller/profile_controller.dart';
import 'package:faza_app/Module/setting/profile/profile.dart';
import 'package:faza_app/Module/tab/controller/tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../models/admin_percentage_model.dart';
import '../../helper/lunchers_helper.dart';
import '../../widgets/custom_svg.dart';
import '../home/category/controller/category_controller.dart';
import '../product/cart/controller/cart_controller.dart';

class NavigationTabScreen extends StatefulWidget {
  const NavigationTabScreen({Key? key}) : super(key: key);

  @override
  State<NavigationTabScreen> createState() => _NavigationTabScreenState();
}

class _NavigationTabScreenState extends State<NavigationTabScreen> {
  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const FavoriteProductScreen(),
      // const CategoryScreen(),
      const ProfileScreen(),
    ];
  }

  NavigationTabController? navigationNavController;
  HomeController? homeController;
  FavoriteProductController? favoriteProductController;
  ProfileController? profileController;
  CategoryController? categoryController;
  @override
  void initState() {
    super.initState();
    getVersion();

    navigationNavController = Get.put(NavigationTabController());
    homeController = Get.put(HomeController());
    Get.put(CartController());
    favoriteProductController = Get.put(FavoriteProductController());
    categoryController = Get.put(CategoryController());
    profileController = Get.put(ProfileController());
    // Get.lazyPut(() => NotificationController());
  }

  getVersion() async {
    AdminPercentageModel responseData = await AdminService.getAdminSettings();
    if (responseData.data!.version == "v2" ||
        responseData.data!.version == "0") {
    } else {
      return customShowUpdateDialog(Get.context!);
    }
  }

  void customShowUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          "There is a new update".tr,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontSize: 20, color: AppColors.primaryColor),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                "You must update the app to continue.".tr,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontSize: 16),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('REFRESH'.tr),
            onPressed: () async {
              await LuncherHelper.validationHelper.launchInBrowser(Platform
                      .isIOS
                  ? "https://apps.apple.com/us/app/%D8%A5%D8%B3%D8%A3%D9%84%D9%86%D9%8A/id6450955769"
                  : "https://play.google.com/store/apps/details?id=com.vasa.app");
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: navigationNavController!.tabController,
      screens: _buildScreens(),
      items: _navBarsItems(),
      // confineInSafeArea: true,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      padding: const NavBarPadding.all(8),
      margin: const EdgeInsets.all(10.0),
      popActionScreens: PopActionScreensType.all,
      bottomScreenMargin: 0.0,
      backgroundColor: Colors.white,
      decoration: NavBarDecoration(
          colorBehindNavBar: Colors.indigo,
          borderRadius: BorderRadius.circular(20)),
      popAllScreensOnTapOfSelectedTab: true,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style5,
      onItemSelected: (int index) {
        if (index == 0) homeController!.onInit();
        if (index == 1) favoriteProductController!.onInit();
        // if (index == 2) {
        //   homeController!.getCategory();
        // }
        if (index == 3) profileController!.onInit();
      },
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const CustomSvgImage("logo", width: 30, height: 30),
          activeColorPrimary: AppColors.primaryColor,
          inactiveColorPrimary: AppColors.grey,
          inactiveColorSecondary: AppColors.grey,
          contentPadding: 0),
      PersistentBottomNavBarItem(
          icon: const CustomSvgImage("heart",
              width: 24,
              height: 24,
              isColor: true,
              color: AppColors.primaryColor),
          activeColorPrimary: AppColors.primaryColor,
          inactiveColorPrimary: AppColors.grey,
          inactiveColorSecondary: AppColors.grey,
          contentPadding: 0),
      // PersistentBottomNavBarItem(
      //     icon: const Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children: [
      //         Icon(Icons.manage_search_sharp,
      //             size: 32, color: AppColors.primaryColor),
      //       ],
      //     ),
      //     activeColorPrimary: AppColors.primaryColor,
      //     inactiveColorPrimary: AppColors.grey,
      //     inactiveColorSecondary: AppColors.grey,
      //     contentPadding: 0),
      PersistentBottomNavBarItem(
          icon: const CustomSvgImage("manu", width: 28, height: 28),
          activeColorPrimary: AppColors.primaryColor,
          inactiveColorPrimary: AppColors.grey,
          inactiveColorSecondary: AppColors.grey,
          contentPadding: 0),
    ];
  }
}
