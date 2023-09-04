import 'dart:developer';

import 'package:faza_app/helper/loading.dart';
import 'package:faza_app/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../helper/storage_helper.dart';
import '../../../../services/APIs/user_service.dart';

class RegisterController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  RxString countryDialCode = '+966'.obs;
  RxBool isAgreementChecked = false.obs;

  RxString phoneNumber = ''.obs;

  onRegisterClick() async {
    if (formKey.currentState!.validate()) {
      if (phoneController.text.isEmpty) {
        showSnackBar(
            message: "PLEASE_ENTER_THE_PHONE_NUMBER".tr,
            type: ToastType.WARNING,
            position: ToastPosition.top);
        return;
      }
      if (!isAgreementChecked.value) {
        showSnackBar(
          message: "PLEASE_AGREE_THE_TERMS_AND_CONDITION".tr,
          type: ToastType.WARNING,
          position: ToastPosition.top,
        );
        return;
      }

      var data = {
        "email": emailController.text,
        "name": usernameController.text,
        "mobile": phoneController.text,
      };
      showOrHideLoading(false, "GETTING_INFO".tr);
      var response = await AuthService.registerUser(data);
      String fcmToken = StorageService.getFcmToken();
      log(fcmToken);
      if (response.success == true) {
        var loginResponse = await AuthService.loginUser({
          "mobile": phoneController.text,
        });

        showOrHideLoading(true, "GETTING_INFO".tr);
        if (loginResponse.success == true) {
          Get.toNamed(
            '/otp',
            arguments: {
              "userData": response.user,
              "mobile": phoneController.text,
              "user_id": response.user!.id.toString(),
              "isRegister": true,
            },
          );
        } else {
          showOrHideLoading(true, "GETTING_INFO".tr);

          showToast(
            "ERROR".tr,
            response.message.tr,
            ToastType.DANGER,
          );
        }
      } else {
        showOrHideLoading(true, "GETTING_INFO".tr);

        showToast(
          "ERROR".tr,
          response.message.tr,
          ToastType.DANGER,
        );
      }
    }
  }
}
