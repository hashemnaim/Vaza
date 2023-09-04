
import 'package:faza_app/services/APIs/order_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/cart_model.dart';
import '../model/order_list_model.dart';

class OrderListController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxInt selectedIndex = 0.obs;
  RxBool isLoading = true.obs;
  Rx<OrderModel> orderList = OrderModel().obs;
  RxList<CartData> activeOrderItems = <CartData>[].obs;
  RxList<CartData> completedOrderItems = <CartData>[].obs;
  late TabController tabController;

  @override
  void onInit()async {
    getData();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() async{
      isLoading.value = true;
      selectedIndex.value = tabController.index;
 
      isLoading.value = false;
    });
    super.onInit();
  }

  getData() async {
    isLoading.value = true;
    var response = await OrderService.orderList();
    orderList.value = response;
    activeOrderItems.value=response.data!;
    isLoading.value = false;
  }

  getCompletedData() async {
    isLoading.value = true;
    var response = await OrderService.orderCompletedList();
    orderList.value = response;
    completedOrderItems.value=response.data!;
    isLoading.value = false;
  }
}
