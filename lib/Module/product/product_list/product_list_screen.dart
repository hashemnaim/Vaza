import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/product/product_list/controller/product_list_controller.dart';

import 'package:faza_app/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:skeletons/skeletons.dart';

import '../../../helper/keyboard.dart';
import '../../home/component/card_product.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  ProductListController productListController =
      Get.put(ProductListController());

  @override
  void initState() {
    super.initState();
    productListController.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.cardColor,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            KeyboardUtil();
            Get.back();
          },
        ),
        title: Text(
          Get.arguments!['name'] ?? "SUB_CATEGORY".tr,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: AppColors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            children: [
              CustomInput(
                title: "",
                hint: "FIND_WHAT_YOU_WANT".tr,
                textInputType: TextInputType.text,
                icon: EvaIcons.searchOutline,
                onChange: (value) {
                  productListController.runFilter(value);
                },
              ),
              const SpaceH20(),
              Obx(
                () => Expanded(
                  child: productListController.isLoading.value
                      ? GridView.builder(
                          itemCount: 13,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            childAspectRatio: 0.8,
                            mainAxisSpacing: 15,
                          ),
                          itemBuilder: (context, index) {
                            return const SkeletonAvatar();
                          },
                        )
                      : productListController.productList.isEmpty
                          ? Center(
                              child: Text(
                                "NO_PRODUCT_FOUND".tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color: AppColors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            )
                          : GridView.builder(
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              shrinkWrap: true,
                              itemCount:
                                  productListController.productList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 4,
                                childAspectRatio: 0.85,
                                mainAxisSpacing: 4,
                              ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                        '/product-detail',
                                        arguments: {
                                          "index": index,
                                          "productId": productListController
                                              .productList[index].id
                                        },
                                      );
                                    },
                                    child: CardProduct(
                                      index: index,
                                      productsList:
                                          productListController.productList,
                                    ));
                              },
                            ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
