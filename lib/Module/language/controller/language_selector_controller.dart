import 'package:faza_app/helper/storage_helper.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  RxBool isEnglishSelected = false.obs;

  @override
  void onInit() {
    super.onInit();

    StorageService.getcurrentLanguage() == "en"
        ? isEnglishSelected.value = true
        : isEnglishSelected.value = false;
  }
}
