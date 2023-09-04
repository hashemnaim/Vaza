import 'package:carousel_slider/carousel_slider.dart';
import 'package:faza_app/utils/values.dart';
import 'package:faza_app/services/favorite_function_service.dart';
import 'package:faza_app/helper/storage_helper.dart';
import 'package:faza_app/widgets/custom_button.dart';
import 'package:faza_app/widgets/custom_emply_widget.dart';
import 'package:faza_app/widgets/custom_input.dart';
import 'package:faza_app/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:skeletons/skeletons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'controller/search_controller.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController = Get.put(SearchControllere());

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "SEARCH".tr,
        ),
        actions: const [
          // IconBtnWithCounter(
          //   icon: EvaIcons.optionsOutline,
          //   numOfitem: 0,
          //   press: () {
          //     showCustomBottomSheet(
          //       context: context,
          //       title: "",
          //       height: Get.height * 0.7,
          //       listOfItem: [
          //         Text(
          //           "Event type",
          //           style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          //               color: AppColors.black, fontWeight: FontWeight.bold),
          //         ),
          //         DropdownButtonFormField<String>(
          //           // validator: (value) =>
          //           //     value == null ? 'event type is required' : null,
          //           isExpanded: true,
          //           decoration: customInputDecoration(
          //             hint: "birthday",
          //           ),
          //           hint: const Text(
          //             'select event type',
          //           ),
          //           value: searchController.selectedEventType.value == ""
          //               ? null
          //               : searchController.selectedEventType.value,
          //           elevation: 16,
          //           onChanged: (value) {
          //             print(value);
          //             searchController.selectedEventType.value =
          //                 value.toString();
          //           },
          //           items: searchController.eventTypes.map((map) {
          //             return DropdownMenuItem(
          //               value: map,
          //               child: Text(
          //                 map,
          //                 style: const TextStyle(color: Colors.black),
          //               ),
          //             );
          //           }).toList(),
          //         ),
          //         Text(
          //           "Flower color",
          //           style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          //               color: AppColors.black, fontWeight: FontWeight.bold),
          //         ),
          //         DropdownButtonFormField<String>(
          //           // validator: (value) =>
          //           //     value == null ? 'event type is required' : null,
          //           isExpanded: true,
          //           decoration: customInputDecoration(
          //             hint: "Blue",
          //           ),
          //           hint: const Text(
          //             'Select color',
          //           ),
          //           value: searchController.selectedFlowerColor.value == ""
          //               ? null
          //               : searchController.selectedFlowerColor.value,
          //           elevation: 16,
          //           onChanged: (value) {
          //             print(value);
          //             searchController.selectedFlowerColor.value =
          //                 value.toString();
          //           },
          //           items: searchController.flowerColor.map((map) {
          //             return DropdownMenuItem(
          //               value: map,
          //               child: Text(
          //                 map,
          //                 style: const TextStyle(color: Colors.black),
          //               ),
          //             );
          //           }).toList(),
          //         ),
          //         const SpaceH8(),
          //         CustomPrimaryButton(
          //           text: "Confirm",
          //           onPress: () {},
          //           color: AppColors.primaryColor,
          //           textColor: AppColors.primaryTextColor,
          //         ),
          //       ],
          //     );
          //   },
          //   iconColor: Colors.white,
          //   backgroundColor: AppColors.white.withOpacity(.15),
          // ),
          // const SpaceW12(),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: kPadding),
          child: StickyHeader(
            header: Container(
              color: AppColors.white,
              padding: const EdgeInsets.only(
                top: kPadding,
                bottom: kPadding / 2,
              ),
              child: Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: CustomInput(
                        controller: searchController.searchController,
                        title: "",
                        hint: "FIND_WHAT_YOU_WANT".tr,
                        textInputType: TextInputType.text,
                        icon: EvaIcons.searchOutline,
                        autoFocus: true,
                      ),
                    ),
                    if (searchController.searchedKeyword.value.isNotEmpty)
                      const SpaceW8(),
                    // if (searchController.searchedKeyword.value.isNotEmpty)
                    AnimatedContainer(
                      width: searchController.searchedKeyword.value.isNotEmpty
                          ? 45
                          : 0,
                      height: searchController.searchedKeyword.value.isNotEmpty
                          ? 45
                          : 0,
                      curve: Curves.fastLinearToSlowEaseIn,
                      duration: const Duration(milliseconds: 500),
                      child: CustomIconButton(
                        icon: EvaIcons.search,
                        onTap: () {
                          searchController.onSearchClick();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // const SpaceH8(),
                allCategories(searchController, context),
                const SpaceH20(),

                Obx(
                  () => searchController.isLoading.value
                      ? const Center(
                          child: SpinKitThreeBounce(
                            color: AppColors.primaryColor,
                            size: 30,
                          ),
                        )
                      : searchController.searchedProductArray.isEmpty
                          ? CustomEmptyWidget(
                              title: "NO_PRODUCT_FOUND".tr,
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "PRODUCTS".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                GridView.builder(
                                  itemCount: searchController
                                      .searchedProductArray.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 15,
                                    childAspectRatio: 0.8,
                                    mainAxisSpacing: 15,
                                  ),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                          '/product-detail',
                                          arguments: {
                                            "index": index,
                                            "productId": searchController
                                                .searchedProductArray[index].id,
                                          },
                                        );
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height:
                                                widthOfScreen(context) / 2.5,
                                            child: Stack(
                                              children: [
                                                CustomNetworkImageWithoutHeight(
                                                  imageUrl: searchController
                                                      .searchedProductArray[
                                                          index]
                                                      .mainPhoto!,
                                                  boxFit: BoxFit.cover,
                                                  borderRadius: kBorderRadius,
                                                ),
                                                if (StorageService
                                                        .isGuestUser() ==
                                                    false)
                                                  Positioned(
                                                    top: 5,
                                                    right: 5,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                        5,
                                                        4,
                                                        StorageService
                                                                    .getcurrentLanguage() ==
                                                                "en"
                                                            ? 3
                                                            : 8,
                                                        3,
                                                      ),
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: AppColors.white,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: LikeButton(
                                                        size: 20,
                                                        isLiked: searchController
                                                            .searchedProductArray[
                                                                index]
                                                            .isFavorite,
                                                        onTap: (isLiked) async {
                                                          onFavoriteClick(
                                                            favoriteId:
                                                                searchController
                                                                        .searchedProductArray[
                                                                            index]
                                                                        .id ??
                                                                    0,
                                                            favoriteType: isLiked
                                                                ? FavoriteType
                                                                    .dislike
                                                                : FavoriteType
                                                                    .like,
                                                          );
                                                          return !isLiked;
                                                        },
                                                      ),
                                                      // child: const Icon(
                                                      //   Icons.favorite_border_rounded,
                                                      // ),
                                                    ),
                                                  )
                                              ],
                                            ),
                                          ),
                                          Text(
                                            searchController
                                                    .searchedProductArray[index]
                                                    .name ??
                                                "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                          Text(
                                            '${searchController.searchedProductArray[index].price} SAR',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.black50,
                                                ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget allCategories(SearchControllere searchController, context) {
    return Obx(
      () => searchController.searchedCategoryArray.isNotEmpty
          ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "CATEGORY".tr,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    // CustomTextButton(
                    //   text: "VIEW_ALL".tr,
                    //   color: AppColors.primaryColor.withOpacity(.7),
                    //   onPress: () {
                    //     Get.toNamed(
                    //       '/category',
                    //     );
                    //   },
                    // ),
                  ],
                ),
                searchController.isLoading.value
                    ? SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          height: 200,
                          width: widthOfScreen(context),
                        ),
                      )
                    : CarouselSlider(
                        options: CarouselOptions(
                          height: 200,
                          viewportFraction: 1,
                          aspectRatio: 16 / 9,
                          initialPage: 0,
                          enableInfiniteScroll: false,
                          reverse: false,
                          autoPlay: false,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: false,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) {
                            // searchController.onPageChanged(index, reason);
                          },
                        ),
                        items: searchController.searchedCategoryArray.map(
                          (element) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed('/product-list', arguments: {
                                  "value": "Category",
                                  "categoryName": element.name,
                                  "categoryId": element.id,
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: kPadding / 3),
                                decoration: BoxDecoration(
                                  color: AppColors.greyShade3,
                                  borderRadius:
                                      BorderRadius.circular(kBorderRadius),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        element.photo ?? "",
                                      ),
                                      fit: BoxFit.cover,
                                      onError: ((exception, stackTrace) =>
                                          const Icon(
                                              Icons.error_outline_rounded))),
                                ),
                                alignment: Alignment.bottomRight,
                                child: element.name?.isEmpty ?? true
                                    ? const SizedBox()
                                    : Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: kPadding,
                                          vertical: kPadding / 3,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              AppColors.black.withOpacity(.5),
                                          borderRadius: BorderRadius.circular(
                                              kBorderRadius),
                                        ),
                                        child: Text(
                                          element.name ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                color: AppColors.white,
                                              ),
                                        ),
                                      ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
              ],
            )
          : Container(),
    );
  }
}
