import 'package:faza_app/Module/home/component/card_category_home.dart';
import 'package:faza_app/Module/home/controller/home_controller.dart';
import 'package:faza_app/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:faza_app/widgets/custom_emply_widget.dart';
import 'package:empty_widget/empty_widget.dart';
import '../../../widgets/custom_svg.dart';
import '../../setting/profile/components/icon_btn.dart';
import '../component/skeletion.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  HomeController categoryController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    categoryController.getCategory();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.cardColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("CATEGORY".tr,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.black, fontSize: 18)),
        actions: <Widget>[
          IconBtnWithCounter(
              icon: const Padding(
                padding: EdgeInsets.all(6.0),
                child: CustomSvgImage("bag"),
              ),
              press: () async {
                Get.toNamed('/cart');
              },
              iconColor: AppColors.primaryColor,
              backgroundColor: Colors.transparent),
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
        ],
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Obx(
        () => categoryController.isLoadingCategory.value
            ? categorySkeleton(context)
            : categoryController.categoryList.isEmpty
                ? CustomEmptyWidget(
                    title: "NO_CATEGORY_CREATED_YET".tr,
                    subtitle: "LOOKS_LIKE_YOU_HAVEN_T_ADDED_ANYTHING_YET".tr,
                    packageImage: PackageImage.Image_1,
                  )
                : categoryList(categoryController),
      ),
    );
  }

  Widget categoryList(HomeController categoryController) {
    return GridView.builder(
      itemCount: categoryController.categoryList.length,
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
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
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 8,
          crossAxisSpacing: 4,
          crossAxisCount: 2,
          childAspectRatio: 1.1),
    );
  }
}
  // Widget categoryList(HomeController categoryController) {
  //   return Padding(
  //     padding: const EdgeInsets.only(right: 2),
  //     child: CarouselSlider(
  //       options: CarouselOptions(
  //         height: 240,
  //         viewportFraction: 1,
  //         aspectRatio: 1,
  //         padEnds: false,
  //         reverse: false,
  //         autoPlay: true,
  //         autoPlayCurve: Curves.fastOutSlowIn,
  //         scrollDirection: Axis.horizontal,
  //         onPageChanged: (index, reason) {
  //           categoryController.onPageChanged(index, reason);
  //         },
  //       ),
  //       carouselController: categoryController.carouselController,
  //       items: categoryController.categoryList.map((item) {
  //         return Builder(builder: (BuildContext context) {
  //           return GestureDetector(
  //               onTap: () {
  //                 Get.toNamed('/product-list', arguments: {
  //                   "value": "Category",
  //                   "categoryName": item.name,
  //                   "categoryId": item.id,
  //                 });
  //               },
  //               child: Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Container(
  //                       width: Get.width,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(kBorderRadius),
  //                         image: DecorationImage(
  //                             image: NetworkImage(item.photo ?? ""),
  //                             fit: BoxFit.contain),
  //                       ),
  //                       alignment: Alignment.bottomRight,
  //                       child: item.name?.isEmpty ?? true
  //                           ? const SizedBox()
  //                           : Container(
  //                               color: AppColors.black.withOpacity(.5),
  //                               padding: const EdgeInsets.symmetric(
  //                                   horizontal: kPadding,
  //                                   vertical: kPadding / 3),
  //                               child: Text(
  //                                 item.name ?? "",
  //                                 style: Theme.of(context)
  //                                     .textTheme
  //                                     .titleLarge!
  //                                     .copyWith(color: AppColors.white),
  //                               )))));
  //         });
  //       }).toList(),
  //     ),
  //   );
  // }



// }
