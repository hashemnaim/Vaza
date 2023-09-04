import 'package:faza_app/helper/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfolioController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxInt selectedIndex = 0.obs;
  RxString userBalance = ''.obs;
  RxString userPoint = ''.obs;
  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    userBalance.value = StorageService.getUserData()['balance'];
    userPoint.value = StorageService.getUserData()['point'];
    tabController.addListener(() {
      selectedIndex.value = tabController.index;
    });
    super.onInit();
  }
}
