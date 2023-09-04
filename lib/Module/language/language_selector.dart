import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/language/controller/language_selector_controller.dart';
import 'package:faza_app/helper/storage_helper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../widgets/custom_button.dart';

class LanguageSelectorScreen extends StatelessWidget {
  const LanguageSelectorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var languageController = Get.put(LanguageController());
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Application language".tr,
          style: const TextStyle(
            color: AppColors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                // color: AppColors.blackShade2,
                width: widthOfScreen(context),
                child: Image.asset(
                  'assets/img/language_vector.png',
                ),
              ),
            ),
            const SpaceH20(),
            Padding(
              padding: const EdgeInsets.all(kPadding),
              child: Obx(
                () => Column(
                  children: [
                    Text(
                      'WELCOME'.tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'PLEASE_SELECT_THE_DESIRED_LANGUAGE'.tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: const Color(0XFF989898)),
                    ),
                    const SpaceH12(),
                    CustomPrimaryButton(
                      text: "English",
                      onPress: () {
                        Get.updateLocale(const Locale("en"));

                        StorageService.writeLanguage("en");
                        languageController.isEnglishSelected.value = true;
                      },
                      color: !languageController.isEnglishSelected.value
                          ? AppColors.backgroundColor
                          : AppColors.primaryColor,
                      textColor: !languageController.isEnglishSelected.value
                          ? AppColors.black
                          : AppColors.white,
                    ),
                    const SpaceH16(),
                    CustomPrimaryButton(
                      text: "اللغة العربية",
                      onPress: () {
                        Get.updateLocale(const Locale("ar"));
                        StorageService.writeLanguage("ar");

                        languageController.isEnglishSelected.value = false;
                      },
                      color: languageController.isEnglishSelected.value
                          ? AppColors.backgroundColor
                          : AppColors.primaryColor,
                      textColor: languageController.isEnglishSelected.value
                          ? AppColors.black
                          : AppColors.white,
                    ),
                  ],
                ),
              ),
            ),
            const SpaceH24(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: CustomPrimaryButton(
          text: "CONTINUE".tr,
          onPress: () async {
            Get.toNamed("/select-city");
          },
          color: AppColors.primaryColor,
          textColor: AppColors.primaryTextColor,
        ),
      ),
    );
  }
}
