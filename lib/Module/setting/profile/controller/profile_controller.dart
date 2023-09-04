import 'dart:convert';
import 'dart:developer';
import 'package:faza_app/services/admin_service.dart';
import 'package:faza_app/utils/values.dart';
import 'package:faza_app/services/APIs/user_service.dart';
import 'package:faza_app/helper/loading.dart';
import 'package:faza_app/helper/storage_helper.dart';
import 'package:faza_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

import '../../../../utils/toast.dart';

class ProfileController extends GetxController {
  RxString? termsAndContitiongData = ''.obs;
  RxBool termsAndContitionLoading = true.obs;
  quill.QuillController quillController = quill.QuillController(
    document: quill.Document(),
    keepStyleOnNewLine: true,
    selection: const TextSelection.collapsed(offset: 0),
  );
  @override
  void onInit() async {
    super.onInit();
    getTermsAndContition();
  }

  getTermsAndContition() async {
    termsAndContitionLoading.value = true;
    var response = await AdminService.getTermsAndCondition();
    if (response != "") {
      termsAndContitiongData!.value = response;
      quillController = quill.QuillController(
        document: quill.Document.fromJson(
            jsonDecode(termsAndContitiongData!.value)["ops"]),
        selection: const TextSelection.collapsed(offset: 0),
      );
    }

    termsAndContitionLoading.value = false;
  }

  deleteAccount() async {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(kPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              EvaIcons.alertTriangleOutline,
              size: 70,
              color: AppColors.googleRed,
            ),
            const SpaceH12(),
            Text(
              "DO_YOU_REALLY_WANT_TO_DELETE_THIS_ACCOUNT".tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            const SpaceH12(),
            Row(
              children: [
                Expanded(
                  child: CustomPrimaryButton(
                    textColor: AppColors.white,
                    text: "NO".tr,
                    color: AppColors.primaryColor,
                    onPress: () {
                      if (Get.isBottomSheetOpen!) Get.back();
                    },
                  ),
                ),
                const SpaceW12(),
                Expanded(
                  child: CustomPrimaryButton(
                    textColor: AppColors.black,
                    text: "YES".tr,
                    color: AppColors.backgroundColor,
                    onPress: () async {
                      if (Get.isBottomSheetOpen!) Get.back();

                      showOrHideLoading(false, "DELETING_ACCOUNT".tr);
                      var response = await AuthService.deleteAccont();
                      log(response.toString());
                      showOrHideLoading(true, "DELETING_ACCOUNT".tr);
                      if (response["success"] == true) {
                        StorageService.clearStorage();
                        showToast(
                          "ACCOUNT_DEACTIVATED".tr,
                          "YOUR_ACCOUNT_IS_DEACTIVATED".tr,
                          ToastType.WARNING,
                        );
                      } else {
                        showToast(
                          "ERROR".tr,
                          "SOMETHING_WENTS_WRONG_TRY_AGAIN_LATER".tr,
                          ToastType.DANGER,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      ignoreSafeArea: true,
      isScrollControlled: false,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kBorderRadius * 3),
          topRight: Radius.circular(kBorderRadius * 3),
        ),
      ),
    );
    // Get.toNamed("/delete-account");
  }
}

class AccountSettingItem {
  Widget icon;
  String text;
  String trailingText;
  Function() onTap;

  AccountSettingItem({
    required this.icon,
    required this.text,
    required this.trailingText,
    required this.onTap,
  });
}
