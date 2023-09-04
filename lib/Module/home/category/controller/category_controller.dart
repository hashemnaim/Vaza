import 'package:faza_app/services/APIs/product_service.dart';
import 'package:faza_app/services/category_service.dart';
import 'package:get/get.dart';
import '../../../../models/category_model.dart';
import '../../../../models/product_model.dart';
import '../../../../models/sub_categor_model.dart';
import '../model/trending_model.dart';

class CategoryController extends GetxController {
  RxBool isLoadingCategory = true.obs;
  RxBool isLoadingSubCategory = true.obs;
  RxList<CategoryData> categoryList = <CategoryData>[].obs;
  RxList<ProductlData> productsByCategoryList = <ProductlData>[].obs;
  RxList<SubCategoryData> subCategoryList = <SubCategoryData>[].obs;
  RxList<CategoryData> categoryDataList = <CategoryData>[].obs;
  Rx<TrendingData> trendingData = TrendingData().obs;
  RxList<CategoryData> originalCategoryDataList = <CategoryData>[].obs;
  RxString pageName = ''.obs;

  @override
  void onInit() async {
    getData();
    super.onInit();
  }

  getData() async {
    if (Get.arguments != null) {
      pageName.value = Get.arguments?['value'] ?? "";

      switch (pageName.value) {
        case "Tranding Categroy":
          getTrendingCategory();
          break;

        case "SubCategory":
          getSubCategory(Get.arguments!['subCategoryId'].toString());

          break;
      }
    }
  }

  getTrendingCategory() async {
    isLoadingCategory.value = true;

    var response = await CategoryService.getTraindgSubCategories(
        Get.arguments['subCategoryId'].toString());
    // if (response.success == true) {
    trendingData.value = response;
    // categoryDataList.value = response.categories ?? [];
    originalCategoryDataList.value = response.categories ?? [];
    // }
    isLoadingCategory.value = false;
  }

  getSubCategory(id) async {
    isLoadingSubCategory.value = true;
    var response = await ProductService.productsByCategory(id);
    productsByCategoryList.value = response.products ?? [];
    isLoadingSubCategory.value = false;
  }

  void runFilter(String enteredKeyword) {
    RxList<CategoryData> results = <CategoryData>[].obs;
    if (enteredKeyword.isEmpty) {
      results = originalCategoryDataList;
    } else {
      results.value = originalCategoryDataList
          .where((oneClass) => oneClass.name!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    categoryDataList.value = results;
    categoryDataList.refresh();
  }
}
