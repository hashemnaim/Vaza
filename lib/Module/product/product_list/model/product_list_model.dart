
import '../../../../models/product_model.dart';

ProductListModel productListModelFromJson(Map<String, dynamic> str) =>
    ProductListModel.fromJson((str));

Map<String, dynamic> productListModelToJson(ProductListModel data) =>
    (data.toJson());

class ProductListModel {
  String? message;
  int? code;
  bool? success;
  List<ProductlData>? products;

  ProductListModel({this.message, this.code, this.success, this.products});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    success = json['success'];
    if (json['data'] != null) {
      products = <ProductlData>[];
      json['data'].forEach((v) {
        products!.add(ProductlData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['code'] = code;
    data['success'] = success;
    if (products != null) {
      data['data'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

