import 'package:faza_app/Module/home/component/card_category_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/values.dart';
import '../../../helper/animate_do.dart';
import '../category/model/trending_model.dart';
import '../controller/home_controller.dart';
import '../home.dart';

class TrendingCategorySectionHome extends StatelessWidget {
  const TrendingCategorySectionHome({
    super.key,
    required this.homeController,
    required this.trendingData,
  });

  final HomeController homeController;
  final RxList<TrendingData> trendingData;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeController.isLoadingTrending.value
          ? subCategorySkeleton(context)
          : Column(
              children: [
                const SizedBox(height: 8),
                for (int index = 0; index < trendingData.length; index++)
                  Column(mainAxisSize: MainAxisSize.min, children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            trendingData[index].title ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                          ),
                          // CustomTextButton(
                          //   text: "VIEW_ALL".tr,
                          //   color: AppColors.primaryColor.withOpacity(.7),
                          //   onPress: () {
                          //     Get.toNamed(
                          //       '/Category-list',
                          //       arguments: {
                          //         'value': 'Tranding Categroy',
                          //         "subCategoryId": trendingData[index].id,
                          //         "name": trendingData[index].title,
                          //       },
                          //     );
                          //   },
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                        height: 155,
                        child: ListView.separated(
                            itemCount:
                                trendingData[index].categories?.length ?? 0,
                            separatorBuilder: (context, subIndex) =>
                                const SpaceW2(),
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(right: 8),
                            itemBuilder: (context, subIndex) {
                              return InkWell(
                                onTap: () {
                                  Get.toNamed('/product-list', arguments: {
                                    'value': 'Category',
                                    "subCategoryId": trendingData[index]
                                        .categories![subIndex]
                                        .id,
                                    "name": trendingData[index]
                                        .categories![subIndex]
                                        .name
                                  });
                                },
                                child: FadeInUp(
                                    duration:
                                        Duration(milliseconds: 100 * index),
                                    child: CardCategoryHome(
                                        image: trendingData[index]
                                                .categories![subIndex]
                                                .photo ??
                                            "",
                                        title: trendingData[index]
                                                .categories![subIndex]
                                                .name ??
                                            "")),
                              );
                            }))
                  ]),
              ],
            ),
    );
  }
}
