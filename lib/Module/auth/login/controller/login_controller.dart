import 'package:faza_app/utils/values.dart';
import 'package:faza_app/helper/loading.dart';
import 'package:faza_app/helper/storage_helper.dart';
import 'package:faza_app/utils/toast.dart';
import 'package:faza_app/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ndialog/ndialog.dart';
import '../../../../services/APIs/user_service.dart';
import '../model/login_model.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();

  RxString countryDialCode = '+966'.obs;

  onLoginClick(context) async {
    if (formKey.currentState!.validate()) {
      if (phoneController.value.text.isEmpty) {
        showToast("PHONE_NUMBER".tr, "PLEASE_ENTER_THE_PHONE_NUMBER".tr,
            ToastType.DANGER);
        return;
      }

      var data = {"mobile": phoneController.value.text};
      showOrHideLoading(false, "GETTING_INFO".tr);

      LoginModel response = await AuthService.loginUser(data);

      showOrHideLoading(true, "GETTING_INFO".tr);
      if (response.success == true) {
        Get.toNamed(
          '/otp',
          arguments: {
            "user_id": response.data!.userId.toString(),
            "mobile": phoneController.value.text,
            "isRegister": false,
          },
        );
        showToast("Ok".tr, response.message!.tr, ToastType.SUCCESS);
      } else {
        showOrHideLoading(true, "GETTING_INFO".tr);

        if (response.message == 'Your account is inactive!') {
          accountInactiveAlert(context, response.data?.userId ?? 0);
        } else {
          showToast("ERROR".tr, response.message!.tr, ToastType.DANGER);
        }
      }
    }
  }

  accountInactiveAlert(context, int userId) async {
    await NDialog(
      title: Text(
        "ACCOUNT_DISABLED".tr,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        "YOUR_ACCOUNT_IS_DISABLED_YOU_CAN_ACTIVATE_YOUR_ACCOUNT".tr,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 17,
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: CustomTextButton(
                text: "BACK".tr,
                color: AppColors.grey,
                onPress: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const SpaceW12(),
            Expanded(
              child: CustomTextButton(
                text: "CONTACT".tr,
                color: AppColors.primaryColor,
                onPress: () async {
                  Navigator.pop(context);
                  await Get.toNamed('/contact-us', arguments: {
                    "userId": userId,
                  });
                  // activateAccount();
                },
              ),
            ),
          ],
        ),
      ],
    ).show(context);
  }

  activateAccount() async {
    showOrHideLoading(false, "ACTIVATING_ACCOUNT");
    // var response = await AuthService.activeInactiveUser(data);

    // print(response.message);
    // showOrHideLoading(true, "ACTIVATING_ACCOUNT".tr);
    // if (response.status == 'success') {
    //   showToast("ACCOUNT_ACTIVATED".tr,
    //       "NOW_YOU_CAN_LOGIN_WITH_YOUR_ACCOUNT".tr, ToastType.SUCCESS);
    // } else {
    //   showToast("ERROR".tr, "SOMETHING_WENTS_WRONG_TRY_AGAIN_LATER".tr,
    //       ToastType.DANGER);
    // }
  }

  loginAsGuest() {
    StorageService.writeIsGuest(true);
    showToast("WELCOME_BACK".tr, "WELCOME_TO_VASA_APP".tr, ToastType.SUCCESS);
    Get.deleteAll();
    Get.offAndToNamed('/');
  }
}
