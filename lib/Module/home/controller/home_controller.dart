import 'package:carousel_slider/carousel_controller.dart';
import 'package:faza_app/helper/storage_helper.dart';
import 'package:faza_app/models/city_model.dart';
import 'package:faza_app/services/APIs/home_service.dart';
import 'package:faza_app/services/category_service.dart';
import 'package:faza_app/services/city_service.dart';
import 'package:get/get.dart';
import '../../../models/category_model.dart';
import '../../../models/product_model.dart';
import '../../../models/sub_categor_model.dart';
import '../../../services/APIs/product_service.dart';
import '../category/model/trending_model.dart';
import '../model/slider_offer_model.dart';

class HomeController extends GetxController {
  RxBool cityLoading = true.obs;
  RxBool sliderLoading = true.obs;
  RxBool isLoadingTrending = true.obs;
  RxBool isLoadingCategory = true.obs;
  RxBool isLoadingSubCategory = true.obs;
  RxBool isLoadingProducts = true.obs;
  RxBool isLoading = true.obs;

  RxList<SelectCity> availbleCities = <SelectCity>[].obs;
  Rx<SelectCity> selectCitie = SelectCity().obs;
  RxList<ProductlData> bestSellerproductsList = <ProductlData>[].obs;
  RxList<ProductlData> productsByCategoryList = <ProductlData>[].obs;
  RxList<SliderData> slidersListOffer = <SliderData>[].obs;
  RxList<TrendingData> trendingCateogries = <TrendingData>[].obs;
  RxList<CategoryData> categoryList = <CategoryData>[].obs;
  RxList<CategoryData> bigCovercategoryList = <CategoryData>[].obs;
  RxList<SubCategoryData> subCategoryList = <SubCategoryData>[].obs;
  RxList<ProductlData> cityProductsList = <ProductlData>[].obs;
  CarouselController carouselController = CarouselController();

  @override
  void onInit() async {
    isLoading.value = true;
    if (StorageService.getCity() == '') {
      selectCitie.value.name = StorageService.getCity();
    }

    getSliderData();
    getBestSellingProducts();
    getTrendingCategory();
    getCategory();
    isLoading.value = false;
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   AwesomeNotifications().setListeners(
    //       onActionReceivedMethod: (reseved) async {
    //     Get.toNamed("/notification");
    //   });
    // });

    super.onInit();
  }

  getCategory() async {
    isLoadingCategory.value = true;
    isLoadingSubCategory.value = true;
    var response = await CategoryService.getCategory();
    categoryList.value = response.categories ?? [];
    if (categoryList.isNotEmpty) {
      await getSubCategory(categoryList[0].id);
    }

    isLoadingCategory.value = false;
  }

  getSubCategory(id) async {
    isLoadingSubCategory.value = true;
    var response = await ProductService.productsByCategory(id);
    productsByCategoryList.value = response.products ?? [];
    isLoadingSubCategory.value = false;
  }

  onPageChanged(index, reason) {
    getSubCategory(categoryList[index].id);
  }

  getAvailbleCities() async {
    cityLoading.value = true;
    var response = await CityService.getAvailbleCities();
    availbleCities.value = response.availableCities ?? [];
    cityLoading.value = false;
  }

  getTrendingCategory() async {
    isLoadingTrending.value = true;
    var response = await CategoryService.getTraindgCategories();
    trendingCateogries.value = response.data ?? [];
    isLoadingTrending.value = false;
  }

  getBestSellingProducts() async {
    isLoadingProducts.value = true;
    var response = await ProductService.getBestSellingProducts();
    bestSellerproductsList.value = response.products ?? [];
    isLoadingProducts.value = false;
  }

  getSliderData() async {
    sliderLoading.value = true;
    var response = await HomeService.getSliderOffer();
    slidersListOffer.value = response.data ?? [];
    sliderLoading.value = false;
  }
}
