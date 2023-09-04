import 'package:faza_app/utils/values.dart';
import 'package:faza_app/utils/toast.dart';
import 'package:faza_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardColor,
// floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton:   CustomTextButton(
//                       text: "OPEN_SETTING".tr,
//                       color: AppColors.white,
//                       isOutlined: true,
//                       onPress: () async {
//                         await Geolocator.openAppSettings();
//                       },
//                     ),
      body: SafeArea(
        child: Container(
          width: Get.width,
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.location_off_outlined,
                  color: AppColors.black,
                  size: 40,
                ),
                onPressed: () {},
              ),
              const SpaceH12(),
              Text(
                "LOCATION_PERMISSIONS_ARE_DENIED".tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppColors.primaryTextColor,
                    ),
              ),
              Text(
                "LOCATION_PERMISSIONS_ARE_PERMANENTLY_DENIED_WE_CANNOT_REQUEST_PERMISSIONS"
                    .tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.primaryTextColor,
                    ),
              ),
              const SpaceH12(),
              Row(
                children: [
                  Expanded(
                    child: CustomTextButton(
                      text: "REFRESH".tr,
                      color: AppColors.white,
                      isOutlined: true,
                      onPress: () async {
                        LocationPermission permission =
                            await Geolocator.checkPermission();

                        if (permission == LocationPermission.always ||
                            permission == LocationPermission.whileInUse) {
                          Get.deleteAll();
                          Get.offAndToNamed('/');
                        } else {
                          showToast(
                            "ERROR".tr,
                            "${'LOCATION_PERMISSIONS_ARE_DENIED'.tr}! ${"OPEN_SETTING".tr}",
                            ToastType.WARNING,
                          );
                        }
                      },
                    ),
                  ),
                  const SpaceW12(),
                  Expanded(
                    child: CustomTextButton(
                      text: "OPEN_SETTING".tr,
                      color: AppColors.white,
                      isOutlined: true,
                      onPress: () async {
                        await Geolocator.openAppSettings();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
