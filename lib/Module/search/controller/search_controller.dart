import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/category_model.dart';
import '../../../models/product_model.dart';

class SearchControllere extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController searchController = TextEditingController();
  RxString searchedKeyword = ''.obs;
  RxList<ProductlData> searchedProductArray = <ProductlData>[].obs;
  RxList<CategoryData> searchedCategoryArray = <CategoryData>[].obs;

  RxList<String> eventTypes = [
    "Birthday",
    "Party",
    "Marriage",
    "Spring Festival",
    "Auto Show",
  ].obs;

  RxString selectedEventType = ''.obs;
  RxList<String> flowerColor = [
    "Red",
    "Green",
    "Purple",
    "White",
    "Auto Show",
  ].obs;

  RxString selectedFlowerColor = ''.obs;

  @override
  void onInit() {
    searchController.addListener(() {
      searchedKeyword.value = searchController.text;
    });
    super.onInit();
  }

  onSearchClick() async {
    isLoading.value = true;
    //   var data = {
    //     "userId": StorageService.getUserId(),
    //     "availableCityId": StorageService.getCityId(),
    //     "searchKey": searchController.text,
    //   };
    //   print(data);
    //   var response = await ProductService.searchProduct(data);
    //   searchedProductArray.value = response.products ?? [];
    //   searchedCategoryArray.value = response.categories ?? [];
    //   searchedProductArray.refresh();
    //   searchedCategoryArray.refresh();
    //   print("searchedCategoryArray: ${searchedCategoryArray.length}");
    //   isLoading.value = false;
    //   print(response.message);
    //   print(response.products?.length);
    // }
  }
}
