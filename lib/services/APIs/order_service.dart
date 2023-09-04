import '../../Module/order/order_completed_order/model/order_completed_detail_model.dart';
import '../../Module/order/order_listing/model/order_list_model.dart';
import '../../helper/dio_helper.dart';

class OrderService {
  static Future<dynamic> createOrder(data) async {
    dynamic response = await DioHelper.postData("order/complete", data: data);
    return response.data;
  }

  static Future<dynamic> sendeOrder(data) async {
    var response = await DioHelper.postData("order/send", data: data);
    return response.data;
  }

  static Future<OrderModel> orderList() async {
    var response = await DioHelper.getData("orders");
    final responseData = OrderModel.fromJson(response.data);
    return responseData;
  }

  static Future<OrderModel> orderCompletedList() async {
    var response = await DioHelper.getData("orders?status=completed");
    final responseData = OrderModel.fromJson(response.data);
    return responseData;
  }

  static Future<OrderCompletedDetailModel> orderDetail(id) async {
    var response = await DioHelper.getData("orders/$id");
    final responseData = orderCompletedDetailModelFromJson(response.data);
    return responseData;
  }
}
