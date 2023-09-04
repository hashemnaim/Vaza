import 'dart:developer';
import 'dart:io';

import 'package:faza_app/Module/setting/edit_profile/model/edit_profile_model.dart';
import 'package:faza_app/services/APIs/user_service.dart';
import 'package:faza_app/helper/loading.dart';
import 'package:faza_app/helper/storage_helper.dart';
import 'package:faza_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import 'package:image_picker/image_picker.dart';

import '../../../../helper/image_helper.dart';

class EditProfileController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController editProfileMobileController = TextEditingController();
  TextEditingController editProfileUserNameController = TextEditingController();
  TextEditingController editProfileEMailController = TextEditingController();

  RxString imagePath = ''.obs;
  Rx<File> filePath = File('').obs;

  @override
  void onInit() {
    filePath.value = File('');
    log(StorageService.getUserData()['name']);
    editProfileUserNameController.text = StorageService.getUserData()['name'];
    editProfileEMailController.text = StorageService.getUserData()['email'];

    imagePath.value = StorageService.getUserData()['photo'] ?? "";

    super.onInit();
  }

  editProfileBtn() async {
    if (formKey.currentState!.validate()) {
      log(filePath.value.path);
      dio.MultipartFile? images =
          await ImageHelper.helper.compressFile(File(filePath.value.path));

      dio.FormData formData = dio.FormData.fromMap({
        "mobile": StorageService.getUserData()['mobile'],
        "name": editProfileUserNameController.text,
        "email": editProfileEMailController.text,
        "photo": images,
      });
      showOrHideLoading(false, "LOADING".tr);
      var response = await AuthService.updateUser(formData);
      showOrHideLoading(true, "LOADING".tr);
      if (response.success == true) {
        Map<String, dynamic> user = updateUserModelToJson(response.data!);
        log(user.toString());
        StorageService.writeUserData(user);
        Get.back();
        showToast(
            "EDIT_USER".tr, "USER_EDIT_SUCCESSFULLY".tr, ToastType.SUCCESS);
      } else {
        showToast("ERROR".tr, response.message!, ToastType.DANGER);
      }
    }
  }

  updateProfilePhoto(bool isFromGallery) async {
    try {
      XFile? image;

      if (isFromGallery) {
        image = await ImageHelper.helper.pickImage(source: ImageSource.gallery);
      } else {
        image = await ImageHelper.helper.pickImage(
          source: ImageSource.camera,
        );
      }

      if (image == null) return;

      final imageTemporary = File(image.path);
      filePath.value = imageTemporary;

      // uploadImage(Get.context);
    } on PlatformException catch (e) {
      showToast("ERROR".tr, "FAILED_TO_PICK_IMAGE".tr + e.toString(),
          ToastType.DANGER);
    }
  }

  // uploadImage(scaffoldContext) async {
  //   var stream = http.ByteStream(Stream.castFrom(filePath.value.openRead()));
  //   var length = await filePath.value.length();
  //   var uri = Uri.parse("${BASE_URL}profile/update");
  //   var request = http.MultipartRequest("POST", uri);
  //   var multipartFile = http.MultipartFile(
  //     'file',
  //     stream,
  //     length,
  //     filename: filePath.value.path.split('/').last,
  //     contentType: MediaType('photo', 'png'),
  //   );

  //   request.files.add(multipartFile);
  //   log(request.files[0].filename.toString());
  //   var response = await request.send();
  //   response.stream.transform(utf8.decoder).listen((imagePath) {
  //     editProfileBtn(
  //       imagePath.replaceAll("\"", ""),
  //     );
  //   });
  // }
}
