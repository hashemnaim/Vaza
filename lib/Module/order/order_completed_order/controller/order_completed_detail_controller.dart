import 'package:faza_app/services/APIs/order_service.dart';
import 'package:get/get.dart';

import '../../../../models/cart_model.dart';

class OrderCompletedDetailController extends GetxController {
  RxBool isLoading = true.obs;
  RxString selectedValue = 'cash'.obs;
  RxInt orderID = 0.obs;

  Rx<CartData> orderDetail = CartData().obs;
  @override
  void onInit() {
    if (Get.arguments != null) {
      orderID.value = Get.arguments['orderId'];
      getData();
    }
    super.onInit();
  }

  getData() async {
    isLoading.value = true;
    var response = await OrderService.orderDetail(orderID.value);
    orderDetail.value = response.order;
    isLoading.value = false;
  }
}
