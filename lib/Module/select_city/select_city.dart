import 'package:faza_app/Module/select_city/select_contry_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

import '../../utils/values.dart';
import '../../helper/storage_helper.dart';
import '../../helper/loading.dart';
import '../../utils/toast.dart';
import '../../widgets/custom_button.dart';

class CitySelectionPage extends StatelessWidget {
  const CitySelectionPage({super.key});
  @override
  Widget build(BuildContext context) {
    final CityController cityController = Get.put(CityController());
    return Scaffold(
      body: Obx(
        () => cityController.isLoading.value
            ? SizedBox(
                width: Get.width,
                child: Column(children: [
                  Center(
                      child: SkeletonParagraph(
                          style: const SkeletonParagraphStyle(
                              lines: 8,
                              spacing: 16,
                              lineStyle: SkeletonLineStyle(
                                  randomLength: true,
                                  alignment: Alignment.center))))
                ]))
            : Column(
                children: [
                  const SpaceH48(),
                  Text(
                    'Please add the city of the recipient of the gift'.tr,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cityController.cities.length,
                      itemBuilder: (context, index) {
                        return Obx(() => Card(
                            elevation: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ListTile(
                                title: Text(cityController.cities[index].name!),
                                leading: const Icon(Icons.location_city_sharp),
                                trailing: cityController.cities[index].id ==
                                        cityController.selectCitie.value.id
                                    ? const Icon(
                                        Icons.check_circle,
                                        color: AppColors.primaryColor,
                                      )
                                    : const Icon(Icons.radio_button_unchecked),
                                onTap: () {
                                  cityController.selectCitie.value =
                                      cityController.cities[index];

                                  cityController.update();
                                },
                              ),
                            )));
                      },
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: CustomPrimaryButton(
          text: "CONTINUE".tr,
          onPress: () async {
            if (cityController.selectCitie.value.id != null) {
              showOrHideLoading(false, "GETTING_INFO".tr);
              await StorageService.writeCity(
                  cityController.selectCitie.value.name);
              StorageService.writeIsGuest(true);
              showOrHideLoading(true, "GETTING_INFO".tr);

              await Get.offAllNamed("/");
            } else {
              showToast(
                "ERROR".tr,
                "City must be added".tr,
                ToastType.DANGER,
              );
            }
          },
          color: AppColors.primaryColor,
          textColor: AppColors.primaryTextColor,
        ),
      ),
    );
  }
}
