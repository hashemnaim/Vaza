import '../../../../models/sub_categor_model.dart';

SubCategoryModel subCategoryModelFromJson(Map<String, dynamic> str) =>
    SubCategoryModel.fromJson(str);

Map<String, dynamic> subCategoryModelToJson(SubCategoryModel data) =>
    data.toJson();

class SubCategoryModel {
  SubCategoryModel({
    required this.statusCode,
    required this.success,
    required this.message,
    this.subCategories,
  });

  int statusCode;
  bool success;
  String message;
  List<SubCategoryData>? subCategories;

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryModel(
        statusCode: json["code"],
        success: json["success"],
        message: json["message"],
        subCategories: json["data"] == []
            ? []
            : List<SubCategoryData>.from(
                json["data"].map((x) => SubCategoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": statusCode,
        "success": success,
        "message": message,
        "data": subCategories == []
            ? []
            : List<SubCategoryData>.from(subCategories!.map((x) => x.toJson())),
      };
}
