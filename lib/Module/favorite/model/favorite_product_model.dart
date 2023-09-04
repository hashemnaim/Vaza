import '../../../models/product_model.dart';

ProductFavoriteModel productFavoriteModelFromJson(Map<String, dynamic> str) =>
    ProductFavoriteModel.fromJson(str);

Map<String, dynamic> productFavoriteModelToJson(ProductFavoriteModel data) =>
    data.toJson();

class ProductFavoriteModel {
  ProductFavoriteModel({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.favorites,
  });

  int statusCode;
  bool status;
  String message;
  List<Favorite>? favorites;

  factory ProductFavoriteModel.fromJson(Map<String, dynamic> json) =>
      ProductFavoriteModel(
        statusCode: json["code"],
        status: json["success"],
        message: json["message"],
        favorites: json["favorites"] == []
            ? []
            : List<Favorite>.from(
                json["favorites"].map((x) => Favorite.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": statusCode,
        "status": status,
        "message": message,
        "favorites": favorites == []
            ? []
            : List<Favorite>.from(favorites!.map((x) => x.toJson())),
      };
}

class Favorite {
  Favorite({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.productId,
    required this.product,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  int userId;
  int productId;
  ProductlData product;

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        userId: json["userId"],
        productId: json["productId"],
        product: ProductlData.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "userId": userId,
        "productId": productId,
        "product": product.toJson(),
      };
}
