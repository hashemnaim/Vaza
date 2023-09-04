import 'package:carousel_slider/carousel_slider.dart';
import 'package:faza_app/Module/home/model/slider_offer_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

import '../../../utils/values.dart';
import '../controller/home_controller.dart';

class PercentOffCard extends StatelessWidget {
  const PercentOffCard({super.key, required this.homeController});
  final HomeController homeController;
  @override
  Widget build(BuildContext context) {
    return Obx(() => homeController.sliderLoading.value
        ? Column(children: [
            const SpaceH20(),
            SkeletonAvatar(
                style: SkeletonAvatarStyle(
                    height: 148, width: widthOfScreen(context)))
          ])
        : homeController.slidersListOffer.isEmpty
            ? Container()
            : Column(
                children: [
                  homeController.slidersListOffer.length < 2
                      ? offerSliderCard(
                          homeController.slidersListOffer[0], context)
                      : CarouselSlider(
                          options: CarouselOptions(
                            height: 148,
                            viewportFraction: 1,
                            aspectRatio: 16 / 9,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            padEnds: false,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: false,
                            scrollDirection: Axis.horizontal,
                          ),
                          items: homeController.slidersListOffer.map(
                            (element) {
                              return offerSliderCard(element, context);
                            },
                          ).toList())
                ],
              ));
  }

  Container offerSliderCard(SliderData element, BuildContext context) {
    return Container(
        height: 150,
        width: 400,
        margin: EdgeInsets.zero,
        padding: const EdgeInsets.symmetric(horizontal: kPadding),
        decoration: BoxDecoration(
          // color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(kBorderRadius * 2),
          image: DecorationImage(
            image: NetworkImage(element.photo!),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                    Get.toNamed('/product-list', arguments: {
                      'sliderId': element.id,
                      'value': 'slider-product'
                    });
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: kPadding / 2, horizontal: kPadding / 1),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(kBorderRadius),
                      ),
                      child: Text("SHOP_NOW".tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w500)))),
              const SpaceH16()
            ]));
  }
}
