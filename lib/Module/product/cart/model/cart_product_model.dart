import '../../../../models/product_model.dart';

CartProductModel cartProductModelFromJson(Map<String, dynamic> str) =>
    CartProductModel.fromJson((str));

Map<String, dynamic> cartProductModelToJson(CartProductModel data) =>
    (data.toJson());

class CartProductModel {
  CartProductModel({
    required this.statusCode,
    required this.status,
    required this.message,
    this.products,
  });

  int statusCode;
  bool status;
  String message;
  List<ProductlData>? products;

  factory CartProductModel.fromJson(Map<String, dynamic> json) =>
      CartProductModel(
        statusCode: json["code"],
        status: json["success"],
        message: json["message"],
        products: json["data"] == []
            ? []
            : List<ProductlData>.from(
                json["data"].map((x) => ProductlData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": statusCode,
        "status": status,
        "message": message,
        "products": products == []
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class CartdModel {
  CartdModel({
    required this.productQuantity,
    required this.productDetail,
  });

  int productQuantity;
  ProductlData productDetail;
}
