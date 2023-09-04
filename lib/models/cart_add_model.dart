import 'cart_model.dart';

class CartAddModel {
  String? message;
  int? code;
  bool? success;
  Units? data;

  CartAddModel({this.message, this.code, this.success, this.data});

  CartAddModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    success = json['success'];
    data = json['data'] != null ? Units.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['code'] = code;
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
