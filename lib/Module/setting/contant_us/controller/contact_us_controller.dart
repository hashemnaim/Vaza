import 'package:faza_app/services/APIs/contact_us_service.dart';
import 'package:faza_app/helper/loading.dart';
import 'package:faza_app/helper/storage_helper.dart';
import 'package:faza_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactusController extends GetxController {
  var userId;
  TextEditingController contactUserNameController = TextEditingController();
  TextEditingController contactMobileNumberController = TextEditingController();
  TextEditingController contactMsgController = TextEditingController();
  TextEditingController contactSubjectController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    if (Get.arguments != null) {
      userId = Get.arguments?["userId"];
    }
    contactUserNameController.text =
        StorageService.getUserData()?['name'] ?? "";
    contactMobileNumberController.text =
        StorageService.getUserData()?['mobile'] ?? "";
    super.onInit();
  }

  contactUsBtn() async {
    if (formKey.currentState!.validate()) {
      var data = {
        "message": contactMsgController.text,
        "mobile": contactUserNameController.text,
        "name": contactMobileNumberController.text,
      };
      showOrHideLoading(false, "LOADING".tr);
      var response = await ContactUsService.createContactUs(data);
      showOrHideLoading(true, "LOADING".tr);
      if (response.success == true) {
        Get.back();
        showToast("CONTACT_US".tr,
            "YOUR_MASSAGE_IS_SUCCESSFULLY_SEND_TO_ADMIN".tr, ToastType.SUCCESS);
      } else {
        showToast("ERROR".tr, "SOMETHING_WENT_WRONG".tr, ToastType.DANGER);
      }
    }
  }
}
