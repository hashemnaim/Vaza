AddFavoriteModel addFavoriteModelFromJson(Map<String, dynamic> str) =>
    AddFavoriteModel.fromJson(str);

Map<String, dynamic> addFavoriteModelToJson(AddFavoriteModel data) =>
    data.toJson();

class AddFavoriteModel {
  AddFavoriteModel({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.favorite,
  });

  int statusCode;
  String status;
  String message;
  Favorite favorite;

  factory AddFavoriteModel.fromJson(Map<String, dynamic> json) =>
      AddFavoriteModel(
        statusCode: json["code"],
        status: json["status"],
        message: json["message"],
        favorite: Favorite.fromJson(json["favorite"]),
      );

  Map<String, dynamic> toJson() => {
        "code": statusCode,
        "status": status,
        "message": message,
        "favorite": favorite.toJson(),
      };
}

class Favorite {
  Favorite({
    required this.id,
    required this.userId,
    required this.productId,
    required this.updatedAt,
    required this.createdAt,
  });

  int id;
  int userId;
  int productId;
  DateTime updatedAt;
  DateTime createdAt;

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        id: json["id"],
        userId: json["userId"],
        productId: json["productId"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "productId": productId,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
      };
}
