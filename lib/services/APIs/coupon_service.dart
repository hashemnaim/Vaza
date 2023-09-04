import 'package:faza_app/Module/product/cart/model/coupon_model.dart';

import '../../helper/dio_helper.dart';

class CouponService {
  static Future<CouponModel> applyCoupon(data) async {
    var response = await DioHelper.postData("order/coupon", data: data);
    final responseData = couponModelFromJson(response.data);
    return responseData;
  }

  static Future<dynamic> deleteCoupon(data) async {
    var response = await DioHelper.postData("order/coupon/delete", data: data);
    return response.data;
  }
}
