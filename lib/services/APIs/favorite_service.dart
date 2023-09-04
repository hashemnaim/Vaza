import '../../helper/dio_helper.dart';
import '../../Module/product/product_list/model/product_list_model.dart';

class FavoriteService {
  static Future<ProductListModel> favoriteProduct() async {
    var response = await DioHelper.getData("favorite/products");
    final responseData = productListModelFromJson(response.data);
    return responseData;
  }

  static Future<dynamic> addFavoriteProduct(Map<String, dynamic> data) async {
    var response = await DioHelper.postData("favorite/products", data: data);

    return response.data;
  }

  static Future<dynamic> removeFavoriteProduct(data) async {
    var response =
        await DioHelper.postData("favorite/products/delete", data: data);
    return response.data;
  }
}
