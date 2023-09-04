import 'dart:developer';

import 'package:faza_app/Module/favorite/controller/favorite_product_controller.dart';
import 'package:faza_app/Module/search/controller/search_controller.dart';
import 'package:get/get.dart';
import 'package:faza_app/Module/home/controller/home_controller.dart';
import 'package:faza_app/services/APIs/favorite_service.dart';
import 'package:faza_app/helper/storage_helper.dart';

import '../Module/product/product_detail/controller/product_detail_controller.dart';
import '../Module/product/product_list/controller/product_list_controller.dart';

enum FavoriteType {
  like,
  dislike,
}

onFavoriteClick(
    {required int favoriteId, required FavoriteType favoriteType}) async {
  if (StorageService.getUserId() == 0) return;
  if (StorageService.isGuestUser()) return;

  HomeController homeController = Get.put(HomeController());
  FavoriteProductController favoriteController =
      Get.put(FavoriteProductController());
  ProductListController productListController =
      Get.put(ProductListController());
  ProductDetailController productDetailController =
      Get.put(ProductDetailController());
  SearchControllere searchController = Get.put(SearchControllere());

  if (favoriteType == FavoriteType.dislike) {
    var data = {
      "product_id": favoriteId,
    };
    var response = await FavoriteService.removeFavoriteProduct(data);

    if (response["success"] == true) {
      await FavoriteService.favoriteProduct().then((value) =>
          favoriteController.favoriteProductList.value = value.products!);
      //* HOME
      int bestSellingIndex = homeController.bestSellerproductsList
          .indexWhere((element) => element.id == favoriteId);

      if (bestSellingIndex >= 0) {
        homeController.bestSellerproductsList[bestSellingIndex].isFavorite =
            false;
        homeController.bestSellerproductsList.refresh();
      }

      //* Product Detail
      productDetailController.productDetail.value.isFavorite = false;
      productDetailController.productDetail.refresh();

      //* Favorite
      if (favoriteController.favoriteProductList.isNotEmpty) {
        int favoriteIndex = favoriteController.favoriteProductList
            .indexWhere((element) => element.id == favoriteId);

        if (favoriteIndex != -1) {
          favoriteController.favoriteProductList.removeAt(favoriteIndex);
          favoriteController.favoriteProductList.refresh();
        }
      }

      // * Product List
      int productListIndex = productListController.productList
          .indexWhere((element) => element.id == favoriteId);
      if (productListIndex >= 0) {
        productListController.productList[productListIndex].isFavorite = false;
        productListController.productList.refresh();
      }

      //* Search
      int searchControllerIndex = searchController.searchedProductArray
          .indexWhere((element) => element.id == favoriteId);
      if (searchControllerIndex >= 0) {
        searchController
            .searchedProductArray[searchControllerIndex].isFavorite = false;
        searchController.searchedProductArray.refresh();
      }
    }
  }
  if (favoriteType == FavoriteType.like) {
    Map<String, dynamic> data = {
      "product_id": favoriteId,
    };
    var response = await FavoriteService.addFavoriteProduct(data);

    await FavoriteService.favoriteProduct();
    if (response["success"] == true) {
      await FavoriteService.favoriteProduct().then((value) =>
          favoriteController.favoriteProductList.value = value.products!);

      //* HOME
      int bestSellingIndex = homeController.bestSellerproductsList
          .indexWhere((element) => element.id == favoriteId);

      if (bestSellingIndex >= 0) {
        homeController.bestSellerproductsList[bestSellingIndex].isFavorite =
            true;
        homeController.bestSellerproductsList.refresh();
      }
      // * Product List
      int productListIndex = productListController.productList
          .indexWhere((element) => element.id == favoriteId);
      if (productListIndex != -1) {
        productListController.productList[productListIndex].isFavorite = true;
        productListController.productList.refresh();
      }
      //* Product Detail
      productDetailController.productDetail.value.isFavorite = true;
      productDetailController.productDetail.refresh();
      //* Favorite

      int favoriteIndex = favoriteController.favoriteProductList
          .indexWhere((element) => element.id == favoriteId);
      log(favoriteIndex.toString());
      if (favoriteIndex != -1) {
        // favoriteController.favoriteProductList[favoriteId].isFavorite = true;
        favoriteController.favoriteProductList.refresh();
      }

      //* Search
      int searchControllerIndex = searchController.searchedProductArray
          .indexWhere((element) => element.id == favoriteId);
      if (searchControllerIndex != -1) {
        searchController
            .searchedProductArray[searchControllerIndex].isFavorite = true;
        searchController.searchedProductArray.refresh();
      }
    }
  }
}
