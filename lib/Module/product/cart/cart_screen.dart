import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/components/appbar.dart';
import 'package:faza_app/Module/product/cart/controller/cart_controller.dart';
import 'package:faza_app/widgets/custom_button.dart';
import 'package:faza_app/widgets/custom_emply_widget.dart';
import 'package:faza_app/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:skeletons/skeletons.dart';
import '../../../helper/storage_helper.dart';
import '../../../widgets/custom_svg.dart';

// ignore: must_be_immutable
class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var cartController = Get.put(CartController(), permanent: true);

  @override
  void initState() {
    if (StorageService.isGuestUser() == false) {
      cartController.getCartDataFromDatabase();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBar("CART".tr),
        body: SafeArea(
            child: Obx(() => cartController.isLoading.value
                ? ListView.separated(
                    padding: const EdgeInsets.all(kPadding),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                          padding: const EdgeInsets.all(kPadding / 2),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(kBorderRadius),
                          ),
                          child: Row(children: [
                            const SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                shape: BoxShape.circle,
                                height: 70,
                                width: 70,
                              ),
                            ),
                            Expanded(
                                child: SkeletonParagraph(
                                    style: const SkeletonParagraphStyle(
                                        lines: 3,
                                        spacing: 7,
                                        lineStyle: SkeletonLineStyle(
                                            randomLength: true, height: 10))))
                          ]));
                    },
                    separatorBuilder: (context, index) => const SpaceH12(),
                    itemCount: 7)
                : cartController.listProductCart.isEmpty
                    ? CustomEmptyWidget(
                        title: "YOUR_CART_IS_EMPTY".tr,
                        subtitle:
                            "LOOKS_LIKE_YOU_HAVEN_T_ADDED_ANYTHING_TO_YOUR_CART_YET"
                                .tr,
                        packageImage: PackageImage.Image_1,
                      )
                    : SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: const EdgeInsets.all(kPadding),
                        child: Column(children: [
                          if (cartController.listProductCart.isNotEmpty)
                            for (int index = 0;
                                index < cartController.listProductCart.length;
                                index++)
                              productCard(context, cartController, index),
                          const SpaceH12(),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: kPadding / 3,
                                horizontal: kPadding / 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius:
                                    BorderRadius.circular(kBorderRadius),
                              ),
                              child: Obx(() => cartController
                                          .cartModel.value.data!.coupon ==
                                      null
                                  ? Column(children: [
                                      Row(children: [
                                        const CustomSvgImage("discount-shape"),
                                        Text(
                                            "Do you have a discount coupon?".tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(color: Colors.black))
                                      ]),
                                      const SpaceH8(),
                                      Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.cardColor,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Row(children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextField(
                                                  onChanged: (value) {
                                                    cartController.couponValue
                                                        .value = value;
                                                  },
                                                  controller: cartController
                                                      .couponController,
                                                  decoration: InputDecoration(
                                                    hintText: "COUPON".tr,
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SpaceW4(),
                                            CustomTextButton(
                                                text: "Ok".tr,
                                                enable: cartController
                                                    .couponValue
                                                    .value
                                                    .isNotEmpty,
                                                onPress: () {
                                                  cartController.onApplyCoupon(
                                                      cartController.cartModel
                                                              .value.data!.id ??
                                                          0);
                                                },
                                                color: AppColors.white,
                                                background:
                                                    AppColors.primaryColor),
                                            const SpaceW12()
                                          ]))
                                    ])
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const CustomSvgImage(
                                                "discount-shape"),
                                            const SpaceW12(),
                                            Text("COUPON".tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .copyWith(
                                                        color: Colors.black)),
                                          ],
                                        ),
                                        Row(children: [
                                          Expanded(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                Text(
                                                  cartController.cartModel.value
                                                      .data!.coupon!.code!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge,
                                                ),
                                                Text(
                                                    "${cartController.cartModel.value.data!.coupon!.discount!.toString()} off",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge)
                                              ])),
                                          const SpaceW12(),
                                          CustomIconButton(
                                              icon: Icons.close,
                                              onTap: () {
                                                cartController.deleteCoupon(
                                                    cartController.cartModel
                                                            .value.data!.id ??
                                                        0);
                                              },
                                              color: AppColors.primaryColor)
                                        ]),
                                      ],
                                    )))
                        ])))),
        bottomNavigationBar: Obx(() => cartController.listProductCart.isEmpty
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kPadding,
                        vertical: kPadding / 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.cardColor,
                        borderRadius: BorderRadius.circular(kBorderRadius),
                      ),
                      child: Obx(() {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Payment details".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color: AppColors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                              const SpaceH8(),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "SUBTOTAL".tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: AppColors.black50,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    cartController.isLoading.value
                                        ? const SpinKitThreeBounce(
                                            color: AppColors.black800,
                                            size: 25,
                                          )
                                        : Obx(() => Text(
                                            "${cartController.cartModel.value.data!.transaction!.mainPrice} ${"SAR".tr}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                    color: AppColors.black800,
                                                    fontWeight:
                                                        FontWeight.bold)))
                                  ]),
                              const SpaceH4(),
                              cartController.couponOff.value == 0
                                  ? const SizedBox()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${"AFTER_DISCOUNT".tr} (${cartController.couponOff.value}%)",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: AppColors.black800,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        Text(
                                          "${cartController.cartModel.value.data!.transaction!.mainPrice} ${"SAR".tr}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: AppColors.black800,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ],
                                    ),
                              const SpaceH4(),
                              if (cartController.cartModel.value.data!
                                      .transaction!.deliveryPrice! >
                                  0)
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "DELIVERY_PRICE".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: AppColors.black800,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      cartController.isLoading.value
                                          ? const SpinKitThreeBounce(
                                              color: AppColors.primaryColor,
                                              size: 25,
                                            )
                                          : Text(
                                              "${cartController.cartModel.value.data!.transaction!.deliveryPrice!} ${"SAR".tr}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.bold))
                                    ]),
                              if (cartController.cartModel.value.data!
                                      .transaction!.deliveryPrice! >
                                  0)
                                const SpaceH4(),
                              if (cartController.cartModel.value.data!
                                      .transaction!.taxPercentage! >
                                  0)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "ADDED_TAX".tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: AppColors.black50,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    cartController.isLoading.value
                                        ? const SpinKitThreeBounce(
                                            color: AppColors.primaryColor,
                                            size: 25,
                                          )
                                        : Text(
                                            "${cartController.cartModel.value.data!.transaction!.commissionPercentage}"
                                            "${"SAR".tr}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                  ],
                                ),
                              if (cartController.cartModel.value.data!
                                      .transaction!.taxPercentage! >
                                  0)
                                const SpaceH12(),
                              Container(
                                width: widthOfScreen(context),
                                height: 1,
                                color: AppColors.grey50,
                              ),
                              const SpaceH12(),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "You will pay".tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(color: AppColors.black),
                                    ),
                                    cartController.isLoading.value
                                        ? const SpinKitThreeBounce(
                                            color: AppColors.primaryColor,
                                            size: 30,
                                          )
                                        : Obx(() => Text(
                                            "${cartController.cartModel.value.data!.transaction!.totalPrice} ${"SAR".tr}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                    color: AppColors.black,
                                                    fontWeight:
                                                        FontWeight.bold)))
                                  ])
                            ]);
                      })),
                  const SpaceH12(),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: kPadding / 2,
                        horizontal: kPadding / 4,
                      ),
                      child: CustomPrimaryButton(
                          text: "CONTINUE".tr,
                          // "Complete the Order".tr,
                          isDisabled: false,
                          onPress: () async {
                            cartController.onCompleteOrder(context);
                          },
                          color: AppColors.primaryColor,
                          textColor: AppColors.white))
                ]))));
  }

  Widget productCard(context, CartController cartController, int index) {
    return Obx(() => Slidable(
        closeOnScroll: true,
        endActionPane: ActionPane(
          extentRatio: 0.2,
          motion: const DrawerMotion(),
          dragDismissible: true,
          children: [
            SlidableAction(
              onPressed: (context) {
                cartController.onRemoveFromCart(
                    index, cartController.listProductCart[index].id!);
              },
              backgroundColor: AppColors.dangerRed.withOpacity(.8),
              foregroundColor: const Color(0xffFAFAFD),
              icon: EvaIcons.trash2Outline,
              label: "Delete",
            ),
          ],
        ),
        child: Container(
            padding: const EdgeInsets.all(kPadding / 2),
            margin: const EdgeInsets.only(bottom: kPadding / 1.5),
            decoration: BoxDecoration(
              color: cartController.listProductCart[index].quantity! < 1
                  ? AppColors.dangerRed.withOpacity(.2)
                  : const Color(0xffFAFAFD),
              borderRadius: BorderRadius.circular(kBorderRadius),
            ),
            child: Row(children: [
              cartController.listProductCart[index].product!.name != null
                  ? CustomNetworkImage(
                      imagePath: cartController
                          .listProductCart[index].product!.mainPhoto!,
                      height: 65,
                      width: 65,
                      boxFit: BoxFit.cover,
                      borderRadius: -1)
                  : const CircleAvatar(
                      radius: 35, backgroundColor: AppColors.primaryColor),
              const SpaceW12(),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                    Text(
                      cartController.listProductCart[index].product!.name ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SpaceH8(),
                    Obx(() => Row(children: [
                          Text(
                              "${cartController.listProductCart[index].totalPrice} ${"SAR".tr}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold)),
                          cartController.listProductCart[index].discount == "0"
                              ? const SizedBox.shrink()
                              : Text(
                                  " ${"RIVAL".tr} ${(double.parse(cartController.listProductCart[index].discount ?? "0") / 100) * double.parse(cartController.listProductCart[index].product!.price.toString()) * cartController.listProductCart[index].quantity!}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: 12))
                        ]))
                  ])),
              const SpaceW12(),
              Container(
                  decoration: BoxDecoration(
                      color: AppColors.cardColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                      // mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            cartController.onAddQuantity(index,
                                cartController.listProductCart[index].id!);
                          },
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(() => Center(
                                  child: Text(
                                    "${cartController.listProductCart[index].quantity! < 1 ? "0" : cartController.listProductCart[index].quantity}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                )),
                          ],
                        ),
                        cartController.listProductCart[index].quantity! > 1
                            ? IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  cartController.onRemoveQuantity(
                                    index,
                                    cartController.listProductCart[index].id!,
                                  );
                                },
                              )
                            : IconButton(
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () {
                                  cartController.onRemoveFromCart(
                                      index,
                                      cartController
                                          .listProductCart[index].id!);
                                })
                      ]))
            ]))));
  }
}
