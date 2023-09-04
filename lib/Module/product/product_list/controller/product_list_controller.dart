import 'package:faza_app/models/product_model.dart';
import 'package:faza_app/services/APIs/product_service.dart';

import 'package:get/get.dart';

import '../../../../models/sub_categor_model.dart';

class ProductListController extends GetxController {
  RxString pageName = ''.obs;
  RxInt sliderId = 0.obs;
  RxBool isLoading = true.obs;

  RxList<String> eventTypes = [
    "Birthday",
    "Party",
    "Marriage",
    "Spring Festival",
    "Auto Show",
  ].obs;
  RxList<String> flowerColor = [
    "Red",
    "Green",
    "Purple",
    "White",
    "Auto Show",
  ].obs;

  RxList<ProductlData> originalProductList = <ProductlData>[].obs;
  RxList<ProductlData> productList = <ProductlData>[].obs;
  RxList<SubCategoryData> subCategoryDataList = <SubCategoryData>[].obs;
  RxString selectedEventType = ''.obs;

  RxString selectedFlowerColor = ''.obs;
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getSubCategoryProducts() async {
    isLoading.value = true;
    var response = await ProductService.productsBySubCategory(
        Get.arguments['subCategoryId']);
    if (response.success == true) {
      productList.value = response.products ?? [];
      originalProductList.value = response.products ?? [];
    }
    isLoading.value = false;
  }

  getproductsByCategory() async {
    isLoading.value = true;
    var response =
        await ProductService.productsByCategory(Get.arguments['subCategoryId']);
    if (response.success == true) {
      productList.value = response.products ?? [];
    }

    isLoading.value = false;
  }

  getProductsBySlider() async {
    isLoading.value = true;
    var response =
        await ProductService.productsBySlider(Get.arguments['sliderId']);
    if (response.success == true) {
      productList.value = response.products ?? [];
      originalProductList.value = response.products ?? [];
    }
    isLoading.value = false;
  }

  getTrendingProducts() async {
    isLoading.value = true;

    var response = await ProductService.productsByTrendingCategory(
        Get.arguments['subCategoryId']);
    if (response.success == true) {
      productList.value = response.products ?? [];
      originalProductList.value = response.products ?? [];
    }
    isLoading.value = false;
  }

  getgetBestSellingProducts() async {
    isLoading.value = true;
    var response = await ProductService.getBestSellingProducts();
    if (response.success == true) {
      productList.value = response.products ?? [];
      originalProductList.value = response.products ?? [];
    }
    isLoading.value = false;
  }

  getData() async {
    if (Get.arguments != null) {
      pageName.value = Get.arguments?['value'] ?? "";
      switch (pageName.value) {
        case "Tranding Product":
          getTrendingProducts();

          break;
        case "slider-product":
          getProductsBySlider();

          break;

        case "Category":
          getproductsByCategory();

          break;
        case "sub_category":
          getSubCategoryProducts();

          break;
        case "Best selling product":
          getgetBestSellingProducts();

          break;
        default:
      }
    }
  }

  void runFilter(String enteredKeyword) {
    RxList<ProductlData> results = <ProductlData>[].obs;
    if (enteredKeyword.isEmpty) {
      results = originalProductList;
    } else {
      results.value = originalProductList
          .where((oneClass) => oneClass.name!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    productList.value = results;
    productList.refresh();
  }
}
