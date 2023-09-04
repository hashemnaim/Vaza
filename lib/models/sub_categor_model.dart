import 'category_model.dart';

class SubCategoryData {
  SubCategoryData({
    required this.id,
    this.name,
    required this.photo,
    required this.category,
  });

  int id;
  String? name;
  String photo;

  CategoryData category;

  factory SubCategoryData.fromJson(Map<String, dynamic> json) =>
      SubCategoryData(
          id: json["id"],
          name: json["title"],
          photo: json["photo"],
          category: (json['category'] != null
              ? CategoryData.fromJson(json['category'])
              : null)!);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name ?? '',
        "photo": photo,
        "category": category.toJson(),
      };
}
