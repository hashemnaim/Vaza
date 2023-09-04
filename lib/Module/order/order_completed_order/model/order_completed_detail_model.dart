import '../../../../models/cart_model.dart';

OrderCompletedDetailModel orderCompletedDetailModelFromJson(
        Map<String, dynamic> str) =>
    OrderCompletedDetailModel.fromJson((str));

Map<String, dynamic> orderCompletedDetailModelToJson(
        OrderCompletedDetailModel data) =>
    (data.toJson());

class OrderCompletedDetailModel {
  OrderCompletedDetailModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.order,
  });

  int statusCode;
  bool success;
  String message;
  CartData order;

  factory OrderCompletedDetailModel.fromJson(Map<String, dynamic> json) =>
      OrderCompletedDetailModel(
        statusCode: json["code"],
        success: json["success"],
        message: json["message"],
        order: CartData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": statusCode,
        "success": success,
        "message": message,
        "data": order.toJson(),
      };
}

