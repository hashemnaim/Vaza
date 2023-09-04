import 'dart:developer';

import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/product/cart/controller/cart_controller.dart';
import 'package:faza_app/services/APIs/order_service.dart';
import 'package:faza_app/helper/loading.dart';
import 'package:faza_app/helper/storage_helper.dart';
import 'package:faza_app/utils/toast.dart';
import 'package:faza_app/widgets/custom_bottom_sheet.dart';
import 'package:faza_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/cart_model.dart';
import '../../../../widgets/webView.dart';

class OrderCheckOutController extends GetxController {
  var cartController = Get.put(CartController());
  RxString _orderType = 'home_delivery'.obs;
  RxString get orderType => _orderType;
  void setOrderType(type) {
    _orderType = type;
    update();
  }

  RxString selectedValue = 'cash'.obs;
  TextEditingController additionalNoteController = TextEditingController();
  RxList<Units> listProductCart = <Units>[].obs;
  RxInt idOrder = 0.obs;
  RxString location = "".obs;
  RxString lat = "".obs;
  RxString lng = "".obs;
  RxString address = "".obs;
  RxString deliveryDate = "".obs;
  RxString deliveryTime = "".obs;
  RxString recipientName = "".obs;
  RxString recipientPhone = "".obs;
  RxString recipientMessage = "".obs;
  RxInt couponId = 0.obs;
  RxInt deliveryPrice = 0.obs;
  RxDouble addedTax = 0.0.obs;
  RxDouble discountPrice = 0.0.obs;
  RxDouble totalPrice = 0.0.obs;
  RxDouble grandTotal = 0.0.obs;

  @override
  void onInit() async {
    if (Get.arguments != null) {
      idOrder.value = Get.arguments?["order_id"] ?? 0;
      lat.value = Get.arguments?["longitude"] ?? "";
      lng.value = Get.arguments?["latitude"] ?? "";
      address.value = Get.arguments?["address"] ?? "0";
      deliveryDate.value = Get.arguments?["delivery_date"] ?? "0";
      deliveryTime.value = Get.arguments?["delivery_time"] ?? "0";
      recipientName.value = Get.arguments?["recipient_name"] ?? "0";
      recipientPhone.value = Get.arguments?["recipient_mobile"] ?? "0";
      recipientMessage.value = Get.arguments?["message"] ?? "";
    }
    super.onInit();
  }

  onConfirmOrder(context) async {
    if (selectedValue.value == 'card') {
      sendeOrder().then((value) {
        log(value.toString());
        if (value["success"] == true) {
          Get.to(() => WebViewScreen(
                url: value["data"]["InvoiceURL"],
                onPageFinished: (String v) async {
                  final List<String> x = v.split("/");
                  log(x.toString());
                  try {
                    if (v.contains("error?")) {
                      Get.back();
                      showToast(
                          "ORDER_FAILED".tr,
                          "SOMETHING_WENTS_WRONG_TRY_AGAIN_LATER".tr,
                          ToastType.DANGER);
                    } else if (v.contains("callback?") == true) {
                      await confirmOrderAPI();
                    }
                  } catch (e) {
                    Get.back();
                    showToast(
                        "ORDER_FAILED".tr,
                        "SOMETHING_WENTS_WRONG_TRY_AGAIN_LATER".tr,
                        ToastType.DANGER);
                  }
                },
              ));
        }
      });
    } else if (selectedValue.value == 'cash') {
      sendeOrder().then((value) {
        if (value["success"] == true) {
          confirmOrderAPI();
        } else {
          showToast("ORDER_FAILED".tr,
              "SOMETHING_WENTS_WRONG_TRY_AGAIN_LATER".tr, ToastType.DANGER);
        }
      });
    } else {
      showToast(
        "WARNING".tr,
        "PLEASE_SELECT_PAYMENT_METHOD".tr,
        ToastType.WARNING,
      );
    }
  }

  Future<dynamic> sendeOrder() async {
    var data = {
      "order_id": idOrder.value,
      "payment_method": selectedValue.value,
      "note": additionalNoteController.text
    };

    showOrHideLoading(false, "CONFIRMING_ORDER".tr);
    var response = await OrderService.sendeOrder(data);
    showOrHideLoading(true, "CONFIRMING_ORDER".tr);
    return response;
  }

  Future<dynamic> confirmOrderAPI() async {
    cartController.listProductCart.value = <Units>[];
    cartController.listProductCart.refresh();
    await StorageService.clearCartData();
    Get.deleteAll(force: true);
    Get.offAndToNamed('/');
    return await showCustomBottomSheet(
      context: Get.context!,
      isDismissible: false,
      title: "",
      height: Get.height * 0.6,
      listOfItem: [
        Image.asset(
          'assets/img/payment_completed.png',
          fit: BoxFit.cover,
        ),
        Text(
          'PAYMENT_COMPLETED_SUCCESSFULLY'.tr,
          textAlign: TextAlign.center,
          style: Theme.of(Get.context!)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
            'PLEASE_REVIEW_YOUR_RESERVATION_LIST_AND_FOLLOW_IT_TO_FIND_OUT_STATUS_OF_OUR_ORDER'
                .tr,
            textAlign: TextAlign.center,
            style: Theme.of(Get.context!).textTheme.titleMedium),
        CustomPrimaryButton(
          text: "BACK_TO_MAIN".tr,
          onPress: () async {
            if (Get.isBottomSheetOpen!) Get.back();
          },
          color: AppColors.primaryColor,
          textColor: AppColors.primaryTextColor,
        ),
      ],
    );
  }
}
