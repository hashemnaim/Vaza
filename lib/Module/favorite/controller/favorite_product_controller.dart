import 'package:faza_app/services/APIs/favorite_service.dart';
import 'package:faza_app/helper/storage_helper.dart';
import 'package:get/get.dart';
import '../../../models/product_model.dart';

class FavoriteProductController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<ProductlData> favoriteProductList = <ProductlData>[].obs;

  @override
  void onInit() async {
    if (StorageService.isGuestUser() == false) {
      getData();
    }
    super.onInit();
  }

  getData() async {
    isLoading.value = true;
    var response = await FavoriteService.favoriteProduct();
    favoriteProductList.value = response.products ?? [];
    isLoading.value = false;
  }
}
