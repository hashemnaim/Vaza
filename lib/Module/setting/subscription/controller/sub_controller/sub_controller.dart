import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxInt selectedIndex = 0.obs;
  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      selectedIndex.value = tabController.index;
    });
    super.onInit();
  }
}
