import 'package:faza_app/services/cart_service.dart';
import 'package:faza_app/utils/values.dart';
import 'package:faza_app/helper/storage_helper.dart';
import 'package:faza_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ndialog/ndialog.dart';
import '../../../../models/cart_model.dart';
import '../../../../models/product_model.dart';
import '../../../../services/APIs/product_service.dart';
import '../../../../utils/toast.dart';
import '../../cart/controller/cart_controller.dart';

class ProductDetailController extends GetxController {
  RxInt productId = 0.obs;
  RxBool isLoading = true.obs;
  RxList<Units> listProduct = <Units>[].obs;
  Rx<ProductlData> productDetail = ProductlData().obs;
  RxDouble productPrice = 0.00.obs;
  RxInt purchaseQuantity = 1.obs;
  CartController? cartController;

  @override
  void onInit() async {
    if (StorageService.isGuestUser() == false) {
      cartController = Get.put(CartController());
    }
    if (Get.arguments != null) {
      productId.value = Get.arguments["productId"] ?? 0;
      await getDetailsProduct(productId.value);
    }
    super.onInit();
  }

  getDetailsProduct(int productId) async {
    isLoading.value = true;
    var response =
        await ProductService.getDetailsProducts(productId.toString());

    productDetail.value = response.productDetail;
    if (StorageService.isGuestUser() == false) {
      listProduct.value = <Units>[];
      listProduct.value = StorageService.getCartData();
      if (listProduct.isNotEmpty) {
        var index = listProduct.indexWhere(
            (element) => element.product!.id == productDetail.value.id);
        purchaseQuantity.value = index == -1 ? 1 : listProduct[index].quantity!;
      }
    }
    isLoading.value = false;
    listProduct.refresh();
  }

  onAddQuantity() async {
    purchaseQuantity.value++;
    int unitId = 0;
    if (listProduct.isNotEmpty) {
      var index = listProduct.indexWhere(
          (element) => element.product!.id == productDetail.value.id);
      unitId = index == -1 ? 0 : listProduct[index].id!;
    }
    Map<String, dynamic> cartArray = {
      "unit_id": unitId,
      "quantity": purchaseQuantity.value
    };
    await CartService.updateCartData(cartArray);
    // await  cartController.getCartDataFromDatabase();
  }

  onRemoveQuantity() async {
    if (purchaseQuantity.value > 1) {
      purchaseQuantity.value--;
      int unitId = 0;
      if (listProduct.isNotEmpty) {
        var index = listProduct.indexWhere(
            (element) => element.product!.id == productDetail.value.id);
        unitId = index == -1 ? 0 : listProduct[index].id!;
      }
      Map<String, dynamic> cartArray = {
        "unit_id": unitId,
        "quantity": purchaseQuantity.value
      };

      await CartService.updateCartData(cartArray);
      // await  cartController.getCartDataFromDatabase();
    }
  }

  onRemoveProduct() async {
    int unitId = 0;
    if (listProduct.isNotEmpty) {
      var index = listProduct.indexWhere(
          (element) => element.product!.id == productDetail.value.id);
      unitId = index == -1 ? 0 : listProduct[index].id!;
    }
    var rspoanse = await cartController!.getRemoveFromCart(unitId);
    if (rspoanse['success'] == true) {
      await cartController!.getCartDataFromDatabase();
      listProduct.value = <Units>[];
      listProduct.value = StorageService.getCartData();
      listProduct.refresh();
    }
  }

  onAddToCart(context) async {
    if (StorageService.isGuestUser()) {
      guestUserAlert(context);
    } else {
      Map<String, dynamic> cartArray = {
        "product_id": productId.value,
        "quantity": 1
      };
      var response = await CartService.addCartData(cartArray);
      if (response.success == true) {
        listProduct.add(response.data!);
        listProduct.refresh();
        await cartController!.getCartDataFromDatabase();
        porductAddedToCardAlert(context);
      } else {
        showSnackBar(
            message: response.message ?? "",
            type: ToastType.DANGER,
            position: ToastPosition.top);
      }
    }
  }

  porductAddedToCardAlert(context) async {
    await NDialog(
      title: Text(
        "PRODUCT_ADDED_TO_CART".tr,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        "${purchaseQuantity.value}${"QUANTITY_ADDED_IN_YOUR_CART".tr}",
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 17,
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: CustomTextButton(
                text: "CONTINUE_SHOPPING".tr,
                color: AppColors.grey,
                onPress: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const SpaceW12(),
            Expanded(
              child: CustomTextButton(
                text: "GO_TO_CART".tr,
                color: AppColors.primaryColor,
                onPress: () {
                  Navigator.pop(context);
                  Get.toNamed("/cart");
                },
              ),
            ),
          ],
        ),
      ],
    ).show(context);
  }

  guestUserAlert(BuildContext context) async {
    await NDialog(
      title: Text(
        "GUEST_USER".tr,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Text(
        "YOU_HAVE_LOGGED_IN_AS_A_GUEST_PLEASE_LOG_IN_TO_PLACE_THE_ORDER".tr,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(kPadding / 2),
          child: Row(
            children: [
              Expanded(
                child: CustomTextButton(
                  text: "DISMISS".tr,
                  color: AppColors.black50,
                  onPress: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SpaceW12(),
              Expanded(
                child: CustomTextButton(
                  text: "LOGIN".tr,
                  color: AppColors.primaryColor,
                  onPress: () {
                    Navigator.pop(context);

                    Get.toNamed('/login');
                    // Navigator.pop(context);
                    // StorageService.clearStorage();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ).show(context);
  }
}
