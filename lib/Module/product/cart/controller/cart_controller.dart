import 'package:faza_app/services/APIs/coupon_service.dart';
import 'package:faza_app/helper/storage_helper.dart';
import 'package:faza_app/services/admin_service.dart';
import 'package:faza_app/services/cart_service.dart';
import 'package:faza_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../models/admin_percentage_model.dart';
import '../../../../models/cart_model.dart';
import '../model/coupon_model.dart';

class CartController extends GetxController {
  RxBool isValideTime = true.obs;
  RxBool isLoading = false.obs;
  RxList<Units> listProductCart = <Units>[].obs;
  Rx<CartModel> cartModel = CartModel().obs;
  RxInt deliveryPrice = 0.obs;
  RxInt couponId = 0.obs;
  RxString coupon = "".obs;
  TextEditingController couponController = TextEditingController();
  RxString couponValue = ''.obs;
  RxInt couponOff = 0.obs;
  RxDouble productPrice = 10.00.obs;
  RxInt productQuantity = 1.obs;
  RxBool isPayment = false.obs;

  @override
  void onInit() async {
    if (StorageService.isGuestUser() == false) {
      await getCartDataFromDatabase();
      settingApi();
    }

    super.onInit();
  }

  getCartDataFromDatabase() async {
    isLoading.value = true;
    var response = await CartService.getCartData();
    cartModel.value = response;
    if (response.success == true) {
      if (response.data == null) {
        await StorageService.clearCartData();
        listProductCart.value = <Units>[];
        listProductCart.refresh();
        isLoading.value = false;
      } else {
        if (response.data!.units!.isEmpty) {
          await StorageService.clearCartData();
          listProductCart.value = <Units>[];
          listProductCart.refresh();
          isLoading.value = false;
        } else {
          await StorageService.writeCartData(response.data!.units!);
          listProductCart.value = cartModel.value.data!.units ?? <Units>[];
          listProductCart.refresh();
          isLoading.value = false;
        }
      }

      getOrderTime();
    }
    isLoading.value = false;
  }

  getOrderTime() {
    DateFormat dateFormat = DateFormat.Hm();
    DateTime now = DateTime.now();
    DateTime open = dateFormat.parse("12:00");
    open = DateTime(now.year, now.month, now.day, open.hour, open.minute);
    DateTime close = dateFormat.parse("23:59");
    close = DateTime(now.year, now.month, now.day, close.hour, close.minute);

    if (now.isAfter(open) && now.isBefore(close)) {
      isValideTime.value = true;
    } else {
      isValideTime.value = false;
    }
  }

  updateCartAPI(int unitid, int quantity) async {
    var cartData = {"unit_id": unitid, "quantity": quantity};
    await CartService.updateCartData(cartData);
  }

  settingApi() async {
    AdminPercentageModel setting = await AdminService.getAdminSettings();
    isPayment.value = setting.data!.isPayment!;
  }

  onAddQuantity(int index, int productId) async {
    int quantity = listProductCart[index].quantity! + 1;
    await updateCartAPI(productId, quantity);
    listProductCart[index].quantity = quantity;
    listProductCart.refresh();
    getCartDataFromDatabase();
  }

  onRemoveQuantity(int index, int productId) async {
    if (listProductCart[index].quantity! > 1) {
      int quantity = listProductCart[index].quantity! - 1;
      await updateCartAPI(productId, quantity);
      listProductCart[index].quantity = quantity;
      listProductCart.refresh();
      await getCartDataFromDatabase();
    }
  }

  dynamic getRemoveFromCart(int id) async {
    var data = {"unit_id": id};
    return await CartService.removeCart(data);
  }

  onRemoveFromCart(int index, int id) async {
    if (listProductCart.isNotEmpty) {
      listProductCart.removeAt(index);
      listProductCart.refresh();
      getRemoveFromCart(id);
      await getCartDataFromDatabase();
      if (listProductCart.isEmpty) {
        StorageService.clearCartData();
        return;
      }
      await StorageService.writeCartData(listProductCart);
    } else {
      StorageService.clearCartData();
    }
  }

  onApplyCoupon(int id) async {
    if (couponController.text.isNotEmpty) {
      CouponModel response = await CouponService.applyCoupon({
        "order_id": id,
        "coupon": couponController.text,
      });

      if (response.success == false) {
        showSnackBar(
          message: response.message.tr,
          type: ToastType.DANGER,
          position: ToastPosition.top,
        );
      } else {
        getCartDataFromDatabase();
      }
    }
  }

  deleteCoupon(int id) async {
    var response = await CouponService.deleteCoupon({
      "order_id": id,
    });
    if (response["success"] == false) {
      showSnackBar(
        message: response["message"].tr,
        type: ToastType.DANGER,
        position: ToastPosition.top,
      );
    } else {
      getCartDataFromDatabase();
    }
  }

  RxDouble percentageOff(double originalPrice) {
    if (originalPrice == 0) {
      return originalPrice.obs;
    } else {
      double newPrice =
          (originalPrice - (originalPrice * couponOff.value) / 100);

      return newPrice.toDouble().obs;
    }
  }

  onCompleteOrder(context) async {
    var data = {
      "order_id": cartModel.value.data!.id,
    };
    await Get.toNamed(
      "/order-detail",
      arguments: data,
    );
  }
}
