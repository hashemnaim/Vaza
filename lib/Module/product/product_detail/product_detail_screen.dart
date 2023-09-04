import 'dart:convert';
import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/product/product_detail/controller/product_detail_controller.dart';
import 'package:faza_app/Module/setting/profile/components/icon_btn.dart';
import 'package:faza_app/services/favorite_function_service.dart';
import 'package:faza_app/helper/storage_helper.dart';
import 'package:faza_app/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:skeletons/skeletons.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_svg.dart';
import 'SliderImageWithPagerPoints.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductDetailController productDetailController =
      Get.put(ProductDetailController());

  @override
  void initState() {
    super.initState();
    productDetailController.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (productDetailController.isLoading.value)
                        SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                                height: 250, width: widthOfScreen(context)))
                      else
                        SafeArea(
                            child: Stack(children: [
                          if (productDetailController
                                  .productDetail.value.productPhotos!.length >
                              2)
                            const SizedBox(
                                height: 250,
                                child: SliderImageWithPagerPoints())
                          else
                            InkWell(
                              onTap: () {
                                Get.dialog(Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Material(
                                      borderOnForeground: false,
                                      color: Colors.transparent,
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          CustomNetworkImage(
                                              boxFit: BoxFit.contain,
                                              height: 250,
                                              imagePath: productDetailController
                                                  .productDetail
                                                  .value
                                                  .productPhotos![0]
                                                  .photo!,
                                              width: Get.width),
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            child: IconButton(
                                                onPressed: () => Get.back(),
                                                icon: const Icon(
                                                  Icons.close_sharp,
                                                  color: Colors.white,
                                                  size: 40,
                                                )),
                                          )
                                        ],
                                      ),
                                    )));
                              },
                              child: InteractiveViewer(
                                child: CustomNetworkImage(
                                    boxFit: BoxFit.cover,
                                    height: 250,
                                    imagePath: productDetailController
                                        .productDetail
                                        .value
                                        .productPhotos![0]
                                        .photo!,
                                    width: Get.width),
                              ),
                            ),
                          Transform.translate(
                              offset: const Offset(0, 4),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: const Color(0xff636363),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: IconButton(
                                                icon: const Icon(
                                                  Icons.arrow_back,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  Get.back();
                                                })),
                                        StorageService.isGuestUser() == true
                                            ? const SizedBox()
                                            : Container(
                                                height: 40,
                                                width: 40,
                                                padding: EdgeInsets.fromLTRB(
                                                    5,
                                                    4,
                                                    StorageService
                                                                .getcurrentLanguage() ==
                                                            "en"
                                                        ? 3
                                                        : 8,
                                                    3),
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xff636363),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: LikeButton(
                                                    size: 20,
                                                    likeBuilder: (isLiked) {
                                                      return CustomSvgImage(
                                                        "heart",
                                                        color: productDetailController
                                                                    .productDetail
                                                                    .value
                                                                    .isFavorite ==
                                                                false
                                                            ? Colors.white
                                                            : Colors.red,
                                                        isColor: true,
                                                      );
                                                    },
                                                    isLiked:
                                                        productDetailController
                                                            .productDetail
                                                            .value
                                                            .isFavorite,
                                                    onTap: (isLiked) async {
                                                      onFavoriteClick(
                                                          favoriteId:
                                                              productDetailController
                                                                      .productDetail
                                                                      .value
                                                                      .id ??
                                                                  0,
                                                          favoriteType: !isLiked
                                                              ? FavoriteType
                                                                  .like
                                                              : FavoriteType
                                                                  .dislike);
                                                      return !isLiked;
                                                    }))
                                      ])))
                        ])),
                      productDetailController.isLoading.value
                          ? SkeletonParagraph(
                              style: const SkeletonParagraphStyle(
                                  lines: 8,
                                  lineStyle:
                                      SkeletonLineStyle(randomLength: true)))
                          : Padding(
                              padding: const EdgeInsets.all(kPadding),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        productDetailController
                                                .productDetail.value.name ??
                                            "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold)),
                                    quill.QuillEditor(
                                        controller: quill.QuillController(
                                            document: quill.Document.fromJson(
                                                jsonDecode(
                                                    productDetailController
                                                        .productDetail
                                                        .value
                                                        .description!)["ops"]),
                                            selection:
                                                const TextSelection.collapsed(
                                                    offset: 0)),
                                        scrollController: ScrollController(),
                                        scrollable: true,
                                        focusNode:
                                            FocusNode(canRequestFocus: false),
                                        autoFocus: false,
                                        readOnly: false,
                                        expands: false,
                                        padding: EdgeInsets.zero)
                                  ]))
                    ]))),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(kPadding),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Divider(),
              const SpaceH12(),
              Obx(() => productDetailController.isLoading.value
                  ? const SizedBox()
                  : Row(children: [
                      productDetailController.listProduct.indexWhere(
                                  (element) =>
                                      element.product!.id ==
                                      productDetailController
                                          .productDetail.value.id) !=
                              -1
                          ? Center(
                              child: Container(
                                  width: 245,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: kPadding / 1.6,
                                    horizontal: kPadding,
                                  ),
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius:
                                          BorderRadius.circular(kBorderRadius)),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconBtnWithCounter(
                                            icon: const Icon(Icons.add),
                                            iconColor: AppColors.primaryColor,
                                            backgroundColor: AppColors.white,
                                            isSmall: true,
                                            press: () {
                                              productDetailController
                                                  .onAddQuantity();
                                            }),
                                        const SpaceW40(),
                                        Text(
                                            productDetailController
                                                .purchaseQuantity.value
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                    color: AppColors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18)),
                                        const SpaceW40(),
                                        productDetailController
                                                    .purchaseQuantity >
                                                1
                                            ? IconBtnWithCounter(
                                                icon: const Icon(Icons.remove),
                                                iconColor:
                                                    AppColors.primaryColor,
                                                isSmall: true,
                                                backgroundColor:
                                                    AppColors.white,
                                                press: () {
                                                  productDetailController
                                                      .onRemoveQuantity();
                                                })
                                            : IconBtnWithCounter(
                                                icon: const Icon(
                                                    Icons.delete_outline),
                                                iconColor:
                                                    AppColors.primaryColor,
                                                isSmall: true,
                                                backgroundColor:
                                                    AppColors.white,
                                                press: () {
                                                  productDetailController
                                                      .onRemoveProduct();
                                                }),
                                      ])))
                          : Expanded(
                              child: CustomPrimaryButton(
                                  text: "ADD_TO_CART".tr,
                                  onPress: () {
                                    productDetailController
                                        .onAddToCart(context);
                                  },
                                  color: AppColors.primaryColor,
                                  textColor: AppColors.white)),
                      const SpaceW12(),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: kPadding / 1.38, horizontal: kPadding),
                          decoration: BoxDecoration(
                              color: const Color(0xffF3F3F9),
                              border: Border.all(color: AppColors.primaryColor),
                              borderRadius:
                                  BorderRadius.circular(kBorderRadius)),
                          child: Obx(() => Text(
                              "${productDetailController.productDetail.value.price! * productDetailController.purchaseQuantity.value} ${"SAR".tr}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: AppColors.primaryColor))))
                    ]))
            ])));
  }
}
