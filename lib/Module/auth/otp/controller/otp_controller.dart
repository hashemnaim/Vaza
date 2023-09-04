import 'dart:developer';

import 'package:faza_app/models/user_model.dart';
import 'package:faza_app/services/APIs/user_service.dart';
import 'package:faza_app/helper/loading.dart';
import 'package:faza_app/helper/storage_helper.dart';
import 'package:faza_app/utils/toast.dart';
import 'package:get/get.dart';
import '../../../../helper/dio_helper.dart';

class OtpController extends GetxController {
  RxString verificationCodeController = ''.obs;
  RxString verificationCode = ''.obs;
  RxString phoneNumber = ''.obs;
  RxString userId = ''.obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      phoneNumber.value = Get.arguments["mobile"];
      userId.value = Get.arguments["user_id"];
    }
    super.onInit();
  }

  onConfirmClick() async {
    String fcmToken = await StorageService.getFcmToken() ?? "0";
    log(fcmToken.toString());

    Map<String, dynamic> data = {
      "user_id": userId.value,
      "otp": verificationCodeController.value,
      "fcm_token": fcmToken,
    };

    showOrHideLoading(false, "VERIFYING".tr);
    var response = await AuthService.verifyOtp(data);

    showOrHideLoading(true, "VERIFYING".tr);
    if (response.success == true) {
      Get.deleteAll();
      var userData = userModelToJson(response.data!.user!);
      await StorageService.writeUserData(userData);
      await StorageService.writeFcmToken(fcmToken);
      await StorageService.writeToken(response.data!.token!);
      await StorageService.writeIsGuest(false);
      await DioHelper.init();
      showToast(
          "ACCOUNT_REGISTERED".tr, "WELCOME_TO_VASA_APP".tr, ToastType.SUCCESS);
      Get.offAndToNamed('/');
    } else {
      showOrHideLoading(true, "GETTING_INFO".tr);

      if (response.message == 'Phone number already exists!') {
        showToast("ERROR".tr, "PHONE_NUMBER_ALREADY_EXIST_TRY_ANOTHER_ONE".tr,
            ToastType.DANGER);
      } else if (response.message == 'Email already exists!') {
        showToast("ERROR".tr, "EMAIL_ALREADY_EXIST_TRY_ANOTHER_ONE".tr,
            ToastType.DANGER);
      } else {
        showToast("ERROR".tr, "SOMETHING_WENTS_WRONG".tr, ToastType.DANGER);
      }
    }
  }
}
