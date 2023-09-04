import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/order/order_completed_order/controller/order_completed_detail_controller.dart';
import 'package:faza_app/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OrderCompletedDetailScreen extends StatelessWidget {
  const OrderCompletedDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orderDetailController = Get.put(OrderCompletedDetailController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.cardColor,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: Obx(() => Text(
              orderDetailController.orderDetail.value.transaction == null
                  ? ""
                  : '#${orderDetailController.orderDetail.value.transaction!.transactionNumber}',
              style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            )),
        actions: [
          Obx(
            () => Center(
              child: Text(
                orderDetailController.orderDetail.value.status?.capitalize ??
                    '',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 20,
                    color: orderDetailController.orderDetail.value.status ==
                            'active'
                        ? AppColors.white
                        : orderDetailController.orderDetail.value.status ==
                                'inProgress'
                            ? const Color(0xFFffd950)
                            : orderDetailController.orderDetail.value.status ==
                                    'shipped'
                                ? const Color(0xFF8897aa)
                                : orderDetailController
                                            .orderDetail.value.status ==
                                        'delivered'
                                    ? AppColors.white
                                    : const Color(0xFF76b852)),
              ),
            ),
          ),
          const SpaceW12()
        ],
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Obx(
          () => orderDetailController.isLoading.value
              ? const Center(
                  child: SpinKitThreeBounce(
                    color: AppColors.primaryColor,
                    size: 40,
                  ),
                )
              : SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
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
                                child: Text(
                                  "ORDER_SUMMARY".tr,
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
                                    if (orderDetailController
                                            .orderDetail.value.units! !=
                                        [])
                                      for (int index = 0;
                                          index <
                                              orderDetailController.orderDetail
                                                  .value.units!.length;
                                          index++)
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                CustomNetworkImage(
                                                  imagePath:
                                                      orderDetailController
                                                          .orderDetail
                                                          .value
                                                          .units![index]
                                                          .product!
                                                          .mainPhoto!,
                                                  height: 50,
                                                  width: 50,
                                                  boxFit: BoxFit.cover,
                                                ),
                                                const SpaceW12(),
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
                                                        'PRODUCT_NAME'.tr,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall!
                                                            .copyWith(
                                                              color: AppColors
                                                                  .black,
                                                            ),
                                                      ),
                                                      const SpaceH2(),
                                                      Text(
                                                        orderDetailController
                                                            .orderDetail
                                                            .value
                                                            .units![index]
                                                            .product!
                                                            .name!,
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
                                                    ],
                                                  ),
                                                ),
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
                                                            .bodySmall!
                                                            .copyWith(
                                                              color: AppColors
                                                                  .black,
                                                            ),
                                                      ),
                                                      const SpaceH2(),
                                                      Text(
                                                        orderDetailController
                                                            .orderDetail
                                                            .value
                                                            .units![index]
                                                            .quantity
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                              color: AppColors
                                                                  .black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                    vertical: kPadding / 2,
                                    horizontal: kPadding),
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
                                                        .bodySmall!
                                                        .copyWith(
                                                          color:
                                                              AppColors.black,
                                                        ),
                                                  ),
                                                  const SpaceH2(),
                                                  Text(
                                                    '${orderDetailController.orderDetail.value.transaction!.deliveryPrice} SAR',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                            color:
                                                                AppColors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
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
                                                        .bodySmall!
                                                        .copyWith(
                                                          color:
                                                              AppColors.black,
                                                        ),
                                                  ),
                                                  const SpaceH2(),
                                                  Text(
                                                    '${orderDetailController.orderDetail.value.transaction!.taxPercentage} SAR',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                          color:
                                                              AppColors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                        .bodySmall!
                                                        .copyWith(
                                                          color:
                                                              AppColors.black,
                                                        ),
                                                  ),
                                                  const SpaceH2(),
                                                  Text(
                                                    '${orderDetailController.orderDetail.value.transaction!.totalPrice} SAR',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                            color:
                                                                AppColors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
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
                                                    "PAYMENT_INFORMATION".tr,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                          color:
                                                              AppColors.black,
                                                        ),
                                                  ),
                                                  const SpaceH2(),
                                                  Text(
                                                    orderDetailController
                                                        .orderDetail
                                                        .value
                                                        .paymentMethod!
                                                        .toUpperCase(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                          color:
                                                              AppColors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                    vertical: kPadding / 2,
                                    horizontal: kPadding),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "LOCATION".tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: AppColors.black,
                                          ),
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
                                child: orderDetailController
                                                .orderDetail.value.address !=
                                            '' ||
                                        orderDetailController
                                                .orderDetail.value.address !=
                                            null
                                    ? Text(
                                        orderDetailController
                                                .orderDetail.value.address ??
                                            "NO_LOCATION".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
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
                                Text(
                                  "DELIVERY_DATE".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.black,
                                      ),
                                ),
                                Text(
                                  DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(orderDetailController
                                              .orderDetail.value.deliveryDate ??
                                          "")),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
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
                                      ),
                                ),
                                Text(
                                  // orderDetailController.
                                  orderDetailController
                                          .orderDetail.value.deliveryTime ??
                                      '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
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
                                    vertical: kPadding / 2,
                                    horizontal: kPadding),
                                child: Text(
                                  "THE_RECIPIENT_NAME".tr,
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
                                padding: const EdgeInsets.symmetric(
                                  horizontal: kPadding,
                                  vertical: kPadding / 2,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      orderDetailController.orderDetail.value
                                              .recipientName ??
                                          '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.black,
                                          ),
                                    ),
                                    Text(
                                      // orderDetailController.
                                      orderDetailController.orderDetail.value
                                              .recipientMobile ??
                                          '',

                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
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
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: kPadding / 2,
                                    horizontal: kPadding),
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
                                child: orderDetailController
                                            .orderDetail.value.message !=
                                        ''
                                    ? Text(
                                        orderDetailController
                                                .orderDetail.value.message ??
                                            '',
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
                        if (orderDetailController.orderDetail.value.note != '')
                          Text(
                            'NOTE'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        const SpaceH12(),
                        Text(
                          orderDetailController.orderDetail.value.note ??
                              'No Additional Note'.tr,
                          textAlign: TextAlign.justify,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(),
                        ),
                        const SpaceH8(),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget cardDecoration({context, required Widget child}) {
    return Container(
      // padding: const EdgeInsets.all(kPadding),
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
