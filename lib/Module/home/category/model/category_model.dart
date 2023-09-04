import '../../../../models/category_model.dart';

CategoryModel categoryModelFromJson(Map<String, dynamic> str) =>
    CategoryModel.fromJson(str);

Map<String, dynamic> categoryModelToJson(CategoryData data) => data.toJson();

class CategoryModel {
  CategoryModel({
    required this.statusCode,
    required this.success,
    required this.message,
    this.categories,
  });

  int statusCode;
  bool success;
  String message;
  List<CategoryData>? categories;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        statusCode: json["code"],
        success: json["success"],
        message: json["message"],
        categories: json["data"] == []
            ? []
            : List<CategoryData>.from(
                json["data"].map((x) => CategoryData.fromJson(x))),
      );
}
