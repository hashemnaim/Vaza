import 'package:faza_app/Module/auth/intro/model/intro_model.dart';
import 'package:faza_app/services/APIs/intro_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class IntroController extends GetxController {
  RxBool isLoading = true.obs;

  RxInt currentIdex = 0.obs;
  PageController controller = PageController(
    initialPage: 0,
  );
  RxList<DataIntroSlider> sliders = <DataIntroSlider>[].obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    isLoading.value = true;
    var response = await IntroService.getIntroSlides();
    sliders.value = response.data ?? [];
    sliders.refresh();
    isLoading.value = false;
  }
}
