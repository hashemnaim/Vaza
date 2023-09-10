import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/favorite/controller/favorite_product_controller.dart';
import 'package:faza_app/Module/setting/profile/components/icon_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';
import 'package:faza_app/widgets/custom_emply_widget.dart';
import 'package:empty_widget/empty_widget.dart';

import '../../helper/storage_helper.dart';
import '../../widgets/custom_svg.dart';
import '../home/component/card_product.dart';

class FavoriteProductScreen extends StatefulWidget {
  const FavoriteProductScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteProductScreen> createState() => _FavoriteProductScreenState();
}

class _FavoriteProductScreenState extends State<FavoriteProductScreen> {
  FavoriteProductController favoriteProductController =
      Get.put(FavoriteProductController());

  @override
  void initState() {
    super.initState();
    if (StorageService.isGuestUser() == false) {
      favoriteProductController.getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.cardColor,
            elevation: 0,
            title: Text("FAVORITE".tr,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppColors.black, fontSize: 18)),
            actions: <Widget>[
              IconBtnWithCounter(
                icon: const Padding(
                    padding: EdgeInsets.all(6.0), child: CustomSvgImage("bag")),
                press: () async {
                  Get.toNamed('/cart');
                },
                iconColor: AppColors.primaryColor,
                backgroundColor: Colors.transparent,
              ),
              IconBtnWithCounter(
                icon: const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: CustomSvgImage("notification")),
                press: () {
                  Get.toNamed('/notification');
                },
                iconColor: Colors.black,
                backgroundColor: Colors.transparent,
              ),
            ]),
        body: Obx(() => favoriteProductController.isLoading.value
            ? GridView.builder(
                padding: const EdgeInsets.fromLTRB(
                  kPadding,
                  kPadding,
                  kPadding,
                  kPadding * 2.8,
                ),

                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (context, index) {
                  return Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(kBorderRadius),
                      ),
                      child: SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              height: widthOfScreen(context) / 2.5,
                              width: widthOfScreen(context))));
                },
                // separatorBuilder: (context, index) => const SpaceH12(),
                itemCount: 10,
              )
            : Obx(() => favoriteProductController.favoriteProductList.isEmpty
                ? CustomEmptyWidget(
                    title: "NO_FAVORITE_PRODUCT_FOUND".tr,
                    subtitle: "LOOKS_LIKE_YOU_HAVEN_T_ADDED_ANYTHING_YET".tr,
                    packageImage: PackageImage.Image_1)
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(
                        kPadding, kPadding, kPadding, kPadding * 2.8),
                    shrinkWrap: true,
                    itemCount:
                        favoriteProductController.favoriteProductList.length,
                    physics: const ClampingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.82,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            Get.toNamed('/product-detail', arguments: {
                              "index": index,
                              "productId": favoriteProductController
                                  .favoriteProductList[index].id
                            });
                          },
                          child: CardProduct(
                              index: index,
                              productsList: favoriteProductController
                                  .favoriteProductList));
                    }))));
  }
}
