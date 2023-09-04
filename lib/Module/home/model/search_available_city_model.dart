import 'package:faza_app/models/city_model.dart';

SearchAvailbleCityModel searchAvailbleCityModelFromJson(
        Map<String, dynamic> str) =>
    SearchAvailbleCityModel.fromJson((str));

Map<String, dynamic> searchAvailbleCityModelToJson(
        SearchAvailbleCityModel data) =>
    (data.toJson());

class SearchAvailbleCityModel {
  SearchAvailbleCityModel({
    required this.statusCode,
    required this.status,
    required this.message,
    this.availableCity,
  });

  int statusCode;
  bool status;
  String message;
  SelectCity? availableCity;

  factory SearchAvailbleCityModel.fromJson(Map<String, dynamic> json) =>
      SearchAvailbleCityModel(
        statusCode: json["code"],
        status: json["success"],
        message: json["message"],
        availableCity: json["availableCity"] == null
            ? null
            : SelectCity.fromJson(json["availableCity"]),
      );

  Map<String, dynamic> toJson() => {
        "code": statusCode,
        "success": status,
        "message": message,
        "availableCity": availableCity == null ? null : availableCity!.toJson(),
      };
}
