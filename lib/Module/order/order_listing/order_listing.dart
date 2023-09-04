import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/order/order_listing/controller/order_list_controller.dart';
import 'package:faza_app/Module/setting/profile/components/icon_btn.dart';
import 'package:faza_app/widgets/custom_emply_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:skeletons/skeletons.dart';
import 'package:empty_widget/empty_widget.dart';

import '../../../models/cart_model.dart';
import '../../../widgets/custom_network_image.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orderListController = Get.put(OrderListController());
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
        title: Text('MY_REQUEST'.tr,
            style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 18)),
        actions: [
          IconBtnWithCounter(
            icon: const Icon(EvaIcons.refreshOutline),
            press: () async {
              await orderListController.getData();
            },
            iconColor: Colors.white,
            backgroundColor: AppColors.white.withOpacity(.15),
          ),
          const SpaceW12()
        ],
        bottom: PreferredSize(
          preferredSize: Size(widthOfScreen(context), 60),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: kPadding / 2),
            width: widthOfScreen(context),
            color: AppColors.backgroundColor,
            child: TabBar(
              onTap: (index) {
                index == 0
                    ? orderListController.getData()
                    : orderListController.getCompletedData();
              },
              indicatorColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.label,
              controller: orderListController.tabController,
              tabs: [
                Obx(
                  () => Container(
                    width: widthOfScreen(context),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: orderListController.selectedIndex.value == 0
                          ? AppColors.primaryColor
                          : AppColors.greyShade3,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: kPadding / 2,
                      ),
                      child: Text(
                        "CURRENT_ORDER".tr,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              fontWeight: FontWeight.w600,
                              color:
                                  orderListController.selectedIndex.value == 0
                                      ? AppColors.white
                                      : AppColors.black,
                            ),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Container(
                    width: widthOfScreen(context),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: orderListController.selectedIndex.value != 0
                          ? AppColors.primaryColor
                          : AppColors.greyShade3,
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: kPadding / 2),
                      child: Text(
                        "EXPIRED_ORDER".tr,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              fontWeight: FontWeight.w600,
                              color:
                                  orderListController.selectedIndex.value != 0
                                      ? AppColors.white
                                      : AppColors.black,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Obx(
          () => TabBarView(
            controller: orderListController.tabController,
            children: [
              Container(
                child: orderListController.isLoading.value
                    ? ListView.separated(
                        padding: const EdgeInsets.all(kPadding),
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => const SpaceH16(),
                        itemBuilder: (context, index) {
                          return Container(
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
                              child: SkeletonAvatar(
                                style: SkeletonAvatarStyle(
                                  height: 90,
                                  width: widthOfScreen(context),
                                ),
                              ));
                        },
                        itemCount: 10,
                      )
                    : orderListController.activeOrderItems.isEmpty
                        ? CustomEmptyWidget(
                            title: "NO_CURRENT_ORDER_CREATED_YET".tr,
                            subtitle:
                                "LOOKS_LIKE_YOU_HAVEN_T_ADDED_ANYTHING_YET".tr,
                            packageImage: PackageImage.Image_1,
                          )
                        : ListView.separated(
                            separatorBuilder: ((context, index) {
                              return const SpaceH12();
                            }),
                            padding: const EdgeInsets.all(kPadding),
                            itemCount: orderListController
                                .orderList.value.data!.length,
                            itemBuilder: (context, index) {
                              return requestCard(
                                  context,
                                  orderListController
                                      .orderList.value.data![index],
                                  index);
                            },
                          ),
              ),
              Container(
                child: orderListController.isLoading.value
                    ? ListView.separated(
                        padding: const EdgeInsets.all(kPadding),
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => const SpaceH16(),
                        itemBuilder: (context, index) {
                          return Container(
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
                              child: SkeletonAvatar(
                                style: SkeletonAvatarStyle(
                                  height: 90,
                                  width: widthOfScreen(context),
                                ),
                              ));
                        },
                        itemCount: 10,
                      )
                    : orderListController.completedOrderItems.isEmpty
                        ? CustomEmptyWidget(
                            title: "NO_EXPIRED_ORDER_CREATED_YET".tr,
                            subtitle:
                                "LOOKS_LIKE_YOU_HAVEN_T_ADDED_ANYTHING_YET".tr,
                            packageImage: PackageImage.Image_1,
                          )
                        : ListView.separated(
                            separatorBuilder: ((context, index) {
                              return const SpaceH12();
                            }),
                            padding: const EdgeInsets.all(kPadding),
                            itemCount:
                                orderListController.completedOrderItems.length,
                            itemBuilder: (context, index) {
                              return requestCard(
                                  context,
                                  orderListController
                                      .completedOrderItems[index],
                                  index);
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget requestCard(BuildContext context, CartData item, int index) {
    return GestureDetector(
      onTap: () async {
        await Get.toNamed(
          "/order-complete-detail",
          arguments: {"orderId": item.id},
        );
      },
      child: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(kPadding / 2),
          child: Row(
            children: [
              item.units == null || item.units!.isEmpty
                  ? Container()
                  : CustomNetworkImage(
                      imagePath: item.units![0].product!.mainPhoto ?? "",
                      height: 60,
                      width: 60,
                      boxFit: BoxFit.cover,
                    ),
              const SpaceW12(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    item.units == null || item.units!.isEmpty
                        ? Container()
                        : Text(
                            item.units![index].product!.name ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                    Text(item.address ?? ""),
                    Text(
                      item.status?.capitalize ?? '',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: item.status == 'active'
                              ? AppColors.primaryColor
                              : item.status == 'inProgress'
                                  ? const Color(0xFFffd950)
                                  : item.status == 'shipped'
                                      ? const Color(0xFF8897aa)
                                      : item.status == 'delivered'
                                          ? AppColors.primaryColor
                                          : const Color(0xFF76b852)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      timeago.format(
                        DateTime.parse(item.deliveryDate!),
                      ),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppColors.grey,
                          ),
                    ),
                    const SpaceH16(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        ' # ${item.transaction!.id}',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
