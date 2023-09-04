import 'package:faza_app/utils/values.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

import '../../../helper/keyboard.dart';
import '../component/card_categroy.dart';
import 'controller/category_controller.dart';

class SubCategoryListScreen extends StatefulWidget {
  const SubCategoryListScreen({Key? key}) : super(key: key);

  @override
  State<SubCategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<SubCategoryListScreen> {
  CategoryController categoryController = Get.put(CategoryController());

  @override
  void initState() {
    super.initState();
    categoryController.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.cardColor,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
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
      body: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Column(
          children: [
            // CustomInput(
            //   title: "",
            //   hint: "FIND_WHAT_YOU_WANT".tr,
            //   textInputType: TextInputType.text,
            //   icon: EvaIcons.searchOutline,
            //   onChange: (value) {
            //     categoryController.runFilter(value);
            //   },
            // ),
            // const SpaceH20(),
            Obx(
              () => Expanded(
                child: categoryController.isLoadingSubCategory.value
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
                    : categoryController.subCategoryList.isEmpty
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
                                categoryController.subCategoryList.length,
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
                                    Get.toNamed('/product-list', arguments: {
                                      'value': 'sub_category',
                                      "subCategoryId": categoryController
                                          .subCategoryList[index].id,
                                      "name": categoryController
                                          .subCategoryList[index].name
                                    });
                                  },
                                  child: Obx(() => CardCategory(
                                        photo: categoryController
                                            .subCategoryList[index].photo,
                                        name: categoryController
                                            .subCategoryList[index].name!,
                                      )));
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
