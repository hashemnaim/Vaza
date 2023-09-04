import 'package:faza_app/models/cart_model.dart';
import '../../helper/dio_helper.dart';
import '../../models/cart_add_model.dart';

class CartService {
  static Future<dynamic> updateCartData(data) async {
    var response = await DioHelper.postData("cart/update", data: data);
    var json = response.data;
    return json;
  }

  static Future<CartAddModel> addCartData(Map<String, dynamic> data) async {
    var response = await DioHelper.postData("cart/add", data: data);
    var json = CartAddModel.fromJson(response.data);
    return json;
  }

  static Future<dynamic> removeCart(data) async {
    var response = await DioHelper.postData("cart/remove", data: data);
    return response.data;
  }

  static Future<CartModel> getCartData() async {
    var response = await DioHelper.getData("cart");
    var json = CartModel.fromJson(response.data);
    return json;
  }
}
