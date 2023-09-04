RemoveFavoriteModel removeFavoriteModelFromJson(Map<String, dynamic> str) =>
    RemoveFavoriteModel.fromJson(str);

Map<String, dynamic> removeFavoriteModelToJson(RemoveFavoriteModel data) =>
    data.toJson();

class RemoveFavoriteModel {
  RemoveFavoriteModel({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.favorite,
  });

  int statusCode;
  String status;
  String message;
  Favorite favorite;

  factory RemoveFavoriteModel.fromJson(Map<String, dynamic> json) =>
      RemoveFavoriteModel(
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
  Favorite();

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite();

  Map<String, dynamic> toJson() => {};
}
