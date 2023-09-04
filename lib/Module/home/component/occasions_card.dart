import 'package:faza_app/Module/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

import '../../../utils/values.dart';
import '../../../helper/animate_do.dart';
import '../../../helper/storage_helper.dart';
import '../../../widgets/custom_button.dart';

class OccasionsCard extends StatelessWidget {
  const OccasionsCard({
    super.key,
    required this.press,
    required this.text,
    required this.image,
    required this.homeController,
  });
  final VoidCallback press;
  final String text;
  final String image;
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeController.isLoadingTrending.value
        ? SkeletonAvatar(
            style: SkeletonAvatarStyle(
                height: 60, width: widthOfScreen(context) / 0.5))
        : FadeInLeft(
            duration: const Duration(seconds: 3),
            child: Container(
              height: 64,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.primaryColor),
              child: Directionality(
                textDirection: StorageService.getcurrentLanguage() == "en"
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(" ${"Do you have an occasion?".tr}",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white,
                                    fontSize: 20)),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: CustomButton(
                            backgroundColor: Colors.white,
                            onPressed: press,
                            text: "Book now".tr,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: 14),
                          ),
                        )
                      ]),
                ),
              ),
            ),
          ));
  }
}
