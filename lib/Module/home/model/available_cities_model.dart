import 'package:faza_app/models/city_model.dart';

AvailbleCitiesModel availbleCitiesModelFromJson(Map<String, dynamic> str) =>
    AvailbleCitiesModel.fromJson((str));

Map<String, dynamic> availbleCitiesModelToJson(AvailbleCitiesModel data) =>
    (data.toJson());

class AvailbleCitiesModel {
  AvailbleCitiesModel({
    required this.statusCode,
    required this.success,
    required this.message,
    this.availableCities,
  });

  int statusCode;
  bool success;
  String message;
  List<SelectCity>? availableCities;

  factory AvailbleCitiesModel.fromJson(Map<String, dynamic> json) =>
      AvailbleCitiesModel(
        statusCode: json["code"],
        success: json["success"],
        message: json["message"],
        availableCities: json["data"] == null
            ? []
            : List<SelectCity>.from(
                json["data"].map((x) => SelectCity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": statusCode,
        "success": success,
        "message": message,
        "data": availableCities == null
            ? []
            : List<SelectCity>.from(availableCities!),
      };
}
