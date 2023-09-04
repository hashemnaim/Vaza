import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/auth/intro/controller/intro_controller.dart';
import 'package:faza_app/Module/auth/intro/model/intro_model.dart';
import 'package:faza_app/helper/storage_helper.dart';
import 'package:faza_app/widgets/custom_network_image.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../widgets/custom_button.dart';
import 'package:skeletons/skeletons.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var introController = Get.put(IntroController());
    return Scaffold(
      body: Obx(
        () => introController.isLoading.value
            ? SizedBox(
                width: Get.width,
                child: Column(children: [
                  Expanded(
                      child: SkeletonAvatar(
                          style: SkeletonAvatarStyle(width: Get.width))),
                  const SpaceH12(),
                  Center(
                      child: SkeletonParagraph(
                          style: const SkeletonParagraphStyle(
                              lines: 3,
                              spacing: 10,
                              lineStyle: SkeletonLineStyle(
                                  randomLength: true,
                                  alignment: Alignment.center))))
                ]))
            : Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: introController.controller,
                      onPageChanged: (value) {
                        introController.currentIdex.value = value;
                      },
                      itemCount: introController.sliders.length,
                      itemBuilder: (context, index) {
                        return splashContent(
                            index, context, introController.sliders[index]);
                      },
                    ),
                  ),
                  if (!introController.isLoading.value)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        introController.sliders.length,
                        (index) {
                          return buildDot(
                            index: index,
                            sliderList: introController.sliders,
                            introController: introController,
                          );
                        },
                      ),
                    ),
                ],
              ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Obx(
          () => introController.isLoading.value
              ? const SkeletonAvatar()
              : CustomPrimaryButton(
                  text: "Next".tr,
                  onPress: () {
                    if (introController.currentIdex.value ==
                        introController.sliders.length - 1) {
                      StorageService.writeIntroSeen(true);
                      Get.toNamed("/language");
                    } else {
                      introController.currentIdex.value =
                          introController.currentIdex.value + 1;
                      introController.controller.jumpToPage(
                        introController.currentIdex.value,
                      );
                    }
                  },
                  color: AppColors.primaryColor,
                  textColor: AppColors.primaryTextColor,
                ),
        ),
      ),
    );
  }

  Widget splashContent(int index, context, DataIntroSlider sliderItem) {
    return Column(
      children: [
        if (sliderItem.title != '' || sliderItem.subTitle != null)
          Expanded(
              child: CustomNetworkImageWithoutHeight(
            imageUrl: sliderItem.photo ?? "",
          )),
        const SpaceH20(),
        Padding(
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            children: [
              Text(
                (sliderItem.title ?? ""),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SpaceH16(),
              Text(
                sliderItem.subTitle ?? "",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDot({
    int? index,
    required List<DataIntroSlider> sliderList,
    required IntroController introController,
  }) {
    return Obx(
      () => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 5),
        height: 6,
        width: introController.currentIdex.value == index ? 20 : 6,
        decoration: BoxDecoration(
          color: introController.currentIdex.value == index
              ? AppColors.primaryColor
              : const Color(0xFFD8D8D8),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}
