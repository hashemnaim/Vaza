import 'package:faza_app/Module/home/component/card_category_home.dart';
import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/home/controller/home_controller.dart';
import 'package:faza_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:get/get.dart';
import 'category/category_screen.dart';
import 'component/PercentOffCard.dart';
import 'component/city_and_search.dart';
import 'component/occasions_card.dart';
import 'component/products_cards.dart';
import 'component/trending_category_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeController = Get.put(HomeController());

    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: PreferredSize(
            preferredSize: Size.zero,
            child:
                AppBar(elevation: 0, backgroundColor: const Color(0xffF3F3F9))),
        body: Column(children: [
          SizedBox(
              height: 80, child: CityAndSearch(homeController: homeController)),
          const SpaceH8(),
          Expanded(
              child: Obx(() => SingleChildScrollView(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: PercentOffCard(homeController: homeController),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "sections".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                            ),
                            CustomTextButton(
                              text: "VIEW_ALL".tr,
                              color: AppColors.primaryColor.withOpacity(.7),
                              onPress: () {
                                Get.to(() => const CategoryScreen());
                              },
                            ),
                          ],
                        ),
                      ),
                      categoryList(homeController),
                      const SpaceH4(),
                      TrendingCategorySectionHome(
                        homeController: homeController,
                        trendingData: homeController.trendingCateogries,
                      ),
                      const SpaceH8(),
                      ProductsSectionHome(homeController: homeController),
                      const SpaceH16(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: OccasionsCard(
                            press: () {
                              Get.toNamed('/my-events');
                            },
                            text: "EVENTS".tr,
                            image: ImagePaths.EVENT,
                            homeController: homeController),
                      ),
                      const SpaceH30(),
                    ]),
                  ))),
          const SizedBox(height: 80.0)
        ]));
  }

  Widget categoryList(HomeController categoryController) {
    return SizedBox(
        height: 155,
        child: ListView.separated(
            itemCount: categoryController.categoryList.length,
            separatorBuilder: (context, subIndex) => const SpaceW2(),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(right: 8),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.toNamed('/product-list', arguments: {
                    'value': 'Category',
                    "subCategoryId": categoryController.categoryList[index].id,
                    "name": categoryController.categoryList[index].name
                  });
                },
                child: CardCategoryHome(
                    image: categoryController.categoryList[index].photo ?? "",
                    title: categoryController.categoryList[index].name ?? ""),
              );
            }));
  }
}

SizedBox subCategorySkeleton(BuildContext context) {
  return SizedBox(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SkeletonAvatar(
          style: SkeletonAvatarStyle(
            height: 10,
            width: widthOfScreen(context) / 3.5,
          ),
        ),
        CustomTextButton(
            text: "VIEW_ALL".tr,
            color: AppColors.primaryColor.withOpacity(.7),
            onPress: () {
              Get.toNamed('/product-list',
                  arguments: {'value': 'Best selling product'});
            })
      ],
    ),
    SizedBox(
        height: widthOfScreen(context) / 1.5,
        child: ListView.separated(
            itemCount: 7,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => const SpaceW8(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Column(children: [
                const SpaceH8(),
                SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                        height: widthOfScreen(context) / 2.5,
                        width: widthOfScreen(context) / 3))
              ]);
            }))
  ]));
}
