import 'package:faza_app/Module/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/values.dart';
import '../../../helper/animate_do.dart';
import '../../../widgets/custom_button.dart';
import '../home.dart';
import 'card_product.dart';

class ProductsSectionHome extends StatelessWidget {
  const ProductsSectionHome({
    super.key,
    required this.homeController,
  });

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeController.isLoadingProducts.value
          ? subCategorySkeleton(context)
          : homeController.bestSellerproductsList.isNotEmpty
              ? Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("BEST_SELLING_PRODUCTS".tr,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold)),
                        CustomTextButton(
                            text: "VIEW_ALL".tr,
                            color: AppColors.primaryColor.withOpacity(.7),
                            onPress: () {
                              Get.toNamed('/product-list',
                                  arguments: {'value': 'Best selling product'});
                            })
                      ],
                    ),
                  ),
                  SizedBox(
                      height: 215,
                      child: ListView.separated(
                          itemCount:
                              homeController.bestSellerproductsList.length,
                          separatorBuilder: (context, index) => const SpaceW4(),
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(right: 8),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                    '/product-detail',
                                    arguments: {
                                      "index": index,
                                      "productId": homeController
                                          .bestSellerproductsList[index].id,
                                    },
                                  );
                                },
                                child: FadeInDown(
                                    duration:
                                        Duration(milliseconds: 100 * index),
                                    child: CardProduct(
                                      index: index,
                                      productsList:
                                          homeController.bestSellerproductsList,
                                    )));
                          }))
                ])
              : Container(),
    );
  }
}
