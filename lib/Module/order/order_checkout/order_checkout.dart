import 'package:faza_app/Module/product/cart/controller/cart_controller.dart';
import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/components/appbar.dart';
import 'package:faza_app/Module/order/order_checkout/controller/order_checkout_controller.dart';
import 'package:faza_app/widgets/custom_button.dart';
import 'package:faza_app/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderCheckOutScreen extends StatelessWidget {
  const OrderCheckOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orderCheckOutController = Get.put(OrderCheckOutController());
    var cartController = Get.put(CartController());
    return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          appBar: customAppBar('CONFIRM_ORDER'.tr),
          backgroundColor: AppColors.backgroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: const EdgeInsets.all(kPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    cardDecoration(
                        context: context,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: kPadding / 2,
                                      horizontal: kPadding),
                                  child: Text("ORDER_SUMMARY".tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.black))),
                              Container(
                                height: 1,
                                color: AppColors.greyShade3,
                                width: widthOfScreen(context),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(kPadding),
                                  child: Column(children: [
                                    for (int index = 0;
                                        index <
                                            cartController
                                                .listProductCart.length;
                                        index++)
                                      if (cartController.listProductCart[index]
                                              .quantity! >
                                          0)
                                        Row(children: [
                                          Expanded(
                                              flex: 3,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Text(
                                                      "PRODUCT_NAME".tr,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                              color: AppColors
                                                                  .black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                    const SpaceH2(),
                                                    Text(
                                                        cartController
                                                                .listProductCart[
                                                                    index]
                                                                .product!
                                                                .name ??
                                                            "",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                              color: AppColors
                                                                  .black50,
                                                            ))
                                                  ])),
                                          Expanded(
                                              flex: 1,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Text(
                                                      "QUANTITY".tr,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                              color: AppColors
                                                                  .black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                    const SpaceH2(),
                                                    Text(
                                                        cartController
                                                            .listProductCart[
                                                                index]
                                                            .quantity
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                              color: AppColors
                                                                  .black,
                                                            ))
                                                  ]))
                                        ])
                                  ]))
                            ])),
                    const SpaceH16(),
                    cardDecoration(
                      context: context,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: kPadding / 2, horizontal: kPadding),
                            child: Text(
                              "PAYMENT_INFORMATION".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black,
                                  ),
                            ),
                          ),
                          Container(
                            height: 1,
                            color: AppColors.greyShade3,
                            width: widthOfScreen(context),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(kPadding),
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                'DELIVERY'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        color: AppColors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              const SpaceH2(),
                                              Obx(() => Text(
                                                    '${cartController.cartModel.value.data!.transaction!.deliveryPrice} SAR',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                          color:
                                                              AppColors.black,
                                                        ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                "ADDED_TAX".tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        color: AppColors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              const SpaceH2(),
                                              Text(
                                                '${cartController.cartModel.value.data!.transaction!.taxPercentage} SAR',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: AppColors.black,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SpaceH12()
                                  ],
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                'TOTAL'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        color: AppColors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              const SpaceH2(),
                                              Text(
                                                '${cartController.cartModel.value.data!.transaction!.totalPrice} SAR',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      color: AppColors.black,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SpaceH12()
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SpaceH16(),
                    cardDecoration(
                      context: context,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: kPadding / 2, horizontal: kPadding),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "LOCATION".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold),
                                ),
                                const Icon(
                                  Icons.location_on_outlined,
                                  color: AppColors.grey,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 1,
                            color: AppColors.greyShade3,
                            width: widthOfScreen(context),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: kPadding / 2,
                              horizontal: kPadding,
                            ),
                            child:
                                orderCheckOutController.address.value.isNotEmpty
                                    ? Text(
                                        orderCheckOutController.address.value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: AppColors.black,
                                            ),
                                      )
                                    : Text(
                                        "NO_LOCATION".tr,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: AppColors.black50,
                                            ),
                                      ),
                          ),
                        ],
                      ),
                    ),
                    const SpaceH16(),
                    cardDecoration(
                      context: context,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: kPadding / 1.5, horizontal: kPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("DELIVERY_DATE".tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold)),
                            Text(
                              orderCheckOutController.deliveryDate.value,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: AppColors.black,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SpaceH16(),
                    cardDecoration(
                      context: context,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: kPadding / 1.5, horizontal: kPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "DELIVERY_TIME".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold),
                            ),
                            Text(
                              orderCheckOutController.deliveryTime.value,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: AppColors.black,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SpaceH16(),
                    cardDecoration(
                      context: context,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: kPadding / 2, horizontal: kPadding),
                              child: Text("THE_RECIPIENT_NAME".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold))),
                          Container(
                            height: 1,
                            color: AppColors.greyShade3,
                            width: widthOfScreen(context),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: kPadding,
                              vertical: kPadding / 2,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  orderCheckOutController.recipientName.value,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: AppColors.black,
                                      ),
                                ),
                                Text(
                                  orderCheckOutController.recipientPhone.value,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        color: AppColors.black50,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SpaceH16(),
                    cardDecoration(
                      context: context,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: kPadding / 2, horizontal: kPadding),
                            child: Text(
                              "MESSAGE_TO_RECIPIENT".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: AppColors.black,
                                  ),
                            ),
                          ),
                          Container(
                            height: 1,
                            color: AppColors.greyShade3,
                            width: widthOfScreen(context),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(kPadding),
                            child: orderCheckOutController
                                    .recipientMessage.value.isNotEmpty
                                ? Text(
                                    orderCheckOutController
                                        .recipientMessage.value,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.black,
                                        ),
                                  )
                                : Text(
                                    "NO_RECIPIENT_MESSAGE".tr,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: AppColors.black50,
                                        ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    const SpaceH16(),
                    Text(
                      'ADD_A_NOTE'.tr,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SpaceH12(),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey)),
                      child: CustomInput(
                        controller:
                            orderCheckOutController.additionalNoteController,
                        title: '',
                        minLines: 4,
                        hint: "PLEASE_ENTER_YOUR_MESSAGE".tr,
                        textInputType: TextInputType.text,
                      ),
                    ),
                    const SpaceH16(),
                    Obx(
                      () => Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.white,
                            ),
                            child: RadioListTile(
                              activeColor: AppColors.primaryColor,
                              value: 'cash',
                              autofocus: true,
                              groupValue:
                                  orderCheckOutController.selectedValue.value,
                              onChanged: (value) {
                                orderCheckOutController.selectedValue.value =
                                    value.toString();
                              },
                              title: Text("CASH_PAYMENT".tr),
                              secondary: const Icon(
                                Icons.money,
                                color: AppColors.primaryColor,
                              ),
                              toggleable: true,
                              controlAffinity: ListTileControlAffinity.trailing,
                            ),
                          ),
                          const SpaceH8(),
                          cartController.isPayment.value == true
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.white,
                                  ),
                                  child: RadioListTile(
                                    activeColor: AppColors.primaryColor,
                                    value: 'card',
                                    groupValue: orderCheckOutController
                                        .selectedValue.value,
                                    onChanged: (value) {
                                      // orderCheckOutController.payByCard(context);
                                      orderCheckOutController.selectedValue
                                          .value = value.toString();
                                    },
                                    title: Text("CARD_PAYMENT".tr),
                                    secondary: const Icon(
                                      Icons.payment,
                                      color: AppColors.primaryColor,
                                    ),
                                    toggleable: true,
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                  ),
                                )
                              : const SizedBox.shrink(),
                          const SpaceH8(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20),
            child: CustomPrimaryButton(
              text: "CONFIRM".tr,
              onPress: () {
                orderCheckOutController.onConfirmOrder(context);
              },
              color: AppColors.primaryColor,
              textColor: AppColors.primaryTextColor,
            ),
          ),
        ));
  }

  Widget cardDecoration({context, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(kPadding),
      width: widthOfScreen(context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: AppColors.backgroundColor,
            spreadRadius: 3,
          ),
        ],
      ),
      child: child,
    );
  }
}
