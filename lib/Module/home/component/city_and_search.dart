import 'package:faza_app/widgets/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';
import '../../../utils/values.dart';
import '../../../helper/storage_helper.dart';
import '../../../widgets/custom_bottom_sheet.dart';
import '../../../widgets/custom_button.dart';
import '../../setting/profile/components/icon_btn.dart';
import '../controller/home_controller.dart';

class CityAndSearch extends StatelessWidget {
  const CityAndSearch({Key? key, required this.homeController})
      : super(key: key);
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Color(0xffF3F3F9),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Text(
                    StorageService.getUserData() == null
                        ? "Welcome, My Dear Friend".tr
                        : "${"Welcome".tr} , ${StorageService.getUserData()['name']}",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w700)),
                const SpaceW4(),
                const CustomPngImage("image 296", heigth: 20, width: 20),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    StorageService.getCity() == ''
                        ? ""
                        : StorageService.getCity(),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: AppColors.primaryColor,
                        height: 1.5)),
                IconButton(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      homeController.getAvailbleCities();
                      showCustomBottomSheet(
                        context: context,
                        title: "AVAILABLE_CITIES".tr,
                        listOfItem: [
                          Obx(() => homeController.cityLoading.value
                              ? SizedBox(
                                  height: heightOfScreen(context) / 4,
                                  child: ListView.separated(
                                      itemCount: 3,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      separatorBuilder: (context, index) =>
                                          const SpaceW8(),
                                      itemBuilder: (context, index) {
                                        return Column(children: [
                                          const SpaceH8(),
                                          SkeletonAvatar(
                                              style: SkeletonAvatarStyle(
                                                  height: 60,
                                                  width:
                                                      widthOfScreen(context)))
                                        ]);
                                      }))
                              : ListView.separated(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) =>
                                      CustomPrimaryButton(
                                        text: homeController
                                                .availbleCities[index].name ??
                                            "",
                                        onPress: () async {
                                          homeController.selectCitie.value =
                                              homeController
                                                  .availbleCities[index];

                                          await StorageService.writeCity(
                                              homeController
                                                  .availbleCities[index].name);
                                          Get.back();
                                        },
                                        color: homeController
                                                    .availbleCities[index].id ==
                                                homeController
                                                    .selectCitie.value.id
                                            ? AppColors.primaryColor
                                            : AppColors.whiteSmoke,
                                        textColor: homeController
                                                    .availbleCities[index].id ==
                                                homeController
                                                    .selectCitie.value.id
                                            ? AppColors.primaryTextColor
                                            : AppColors.black,
                                      ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 8),
                                  itemCount:
                                      homeController.availbleCities.length))
                        ],
                      );
                    },
                    icon: const Icon(Icons.arrow_drop_down_outlined))
              ],
            )
          ]),
          Row(
            children: [
              IconBtnWithCounter(
                icon: const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: CustomSvgImage("bag"),
                ),
                press: () async {
                  Get.toNamed('/cart');
                },
                iconColor: AppColors.primaryColor,
                backgroundColor: Colors.transparent,
              ),
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
        ],
      ),
    );
  }
}
