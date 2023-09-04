import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

import '../../../utils/values.dart';
import '../../../models/category_model.dart';
import '../controller/home_controller.dart';

class SlidersCatogryCustomer extends StatelessWidget {
  const SlidersCatogryCustomer({
    super.key,
    required this.homeController,
    required this.slider,
  });

  final HomeController homeController;
  final RxList<CategoryData> slider;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeController.sliderLoading.value
          ? SkeletonAvatar(
              style: SkeletonAvatarStyle(
                height: 180,
                width: widthOfScreen(context),
              ),
            )
          : CarouselSlider(
              options: CarouselOptions(
                height: 180,
                enlargeCenterPage: true,
                viewportFraction: 1,
                aspectRatio: 1,
                enableInfiniteScroll: slider.length == 1 ? false : true,
                padEnds: false,
                reverse: false,
                autoPlay: slider.length == 1 ? false : true,
                scrollDirection: Axis.horizontal,
              ),
              items: slider.map((item) {
                return Builder(builder: (BuildContext context) {
                  return Container(
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kBorderRadius),
                        image: DecorationImage(
                            colorFilter: const ColorFilter.mode(
                                Color.fromARGB(255, 222, 222, 222),
                                BlendMode.multiply),
                            image: NetworkImage(item.photo!),
                            fit: BoxFit.cover),
                      ));
                });
              }).toList()),
    );
  }
}
