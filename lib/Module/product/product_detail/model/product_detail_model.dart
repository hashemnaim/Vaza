import '../../../../models/product_model.dart';

ProductDetailModel productDetailModelFromJson(Map<String, dynamic> str) =>
    ProductDetailModel.fromJson((str));

Map<String, dynamic> productDetailModelToJson(ProductDetailModel data) =>
    (data.toJson());

class ProductDetailModel {
  ProductDetailModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.productDetail,
  });

  int statusCode;
  bool success;
  String message;
  ProductlData productDetail;

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailModel(
        statusCode: json["code"],
        success: json["success"],
        message: json["message"],
        productDetail: ProductlData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": statusCode,
        "success": success,
        "message": message,
        "data": productDetail.toJson(),
      };
}
