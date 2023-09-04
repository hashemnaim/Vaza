import 'package:faza_app/Module/product/product_list/model/product_list_model.dart';
import '../../helper/dio_helper.dart';
import '../../Module/product/product_detail/model/product_detail_model.dart';

class ProductService {
  static Future<ProductListModel> getProducts() async {
    var response = await DioHelper.getData("products");
    final responseData = productListModelFromJson(response.data);
    return responseData;
  }

  static Future<ProductDetailModel> getDetailsProducts(String id) async {
    var response = await DioHelper.getData("products/$id");
    final responseData = productDetailModelFromJson(response.data);
    return responseData;
  }

  static Future<ProductListModel> getBestSellingProducts() async {
    var response = await DioHelper.getData("best-selling-products");
    final responseData = productListModelFromJson(response.data);
    return responseData;
  }

  static Future<ProductListModel> productsByTrendingCategory(data) async {
    var response = await DioHelper.getData("trending-category-product/$data");
    final responseData = productListModelFromJson(response.data);
    return responseData;
  }

  static Future<ProductListModel> productsBySubCategory(data) async {
    var response = await DioHelper.getData("products-by-sub-category/$data");
    final responseData = productListModelFromJson(response.data);
    return responseData;
  }

  static Future<ProductListModel> productsByCategory(data) async {
    var response = await DioHelper.getData("products-by-category/$data");
    final responseData = productListModelFromJson(response.data);
    return responseData;
  }

  static Future<ProductListModel> productsBySlider(data) async {
    var response = await DioHelper.getData("products-by-slider/$data");
    final responseData = productListModelFromJson(response.data);
    return responseData;
  }
}
