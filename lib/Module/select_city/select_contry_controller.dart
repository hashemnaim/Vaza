import 'package:faza_app/services/city_service.dart';
import 'package:get/get.dart';

import '../../models/city_model.dart';

class CityController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<SelectCity> cities = <SelectCity>[].obs;
  Rx<SelectCity> selectCitie = SelectCity().obs;

  @override
  void onInit() async {
    await getData();
    super.onInit();
  }

  getData() async {
    isLoading.value = true;
    var response = await CityService.getAvailbleCities();
    cities.value = response.availableCities ?? [];
    isLoading.value = false;
  }
}
