import 'package:faza_app/models/product_photo_model.dart';
import 'package:faza_app/models/sub_categor_model.dart';

class ProductlData {
  int? id;
  String? name;
  int? price;
  String? mainPhoto;
  SubCategoryData? subCategory;
  String? description;
  bool? isFavorite;
  List<ProductPhotos>? productPhotos;

  ProductlData(
      {this.id,
      this.name,
      this.price,
      this.mainPhoto,
      this.subCategory,
      this.description,
      this.isFavorite,
      this.productPhotos});

  ProductlData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    mainPhoto = json['main_photo'];
    subCategory = json['sub_category'] != null
        ? SubCategoryData.fromJson(json['sub_category'])
        : null;
    description = json['description'];
    isFavorite = json['is_favorite'];
    if (json['product_photos'] != null) {
      productPhotos = <ProductPhotos>[];
      json['product_photos'].forEach((v) {
        productPhotos!.add(ProductPhotos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['main_photo'] = mainPhoto;
    if (subCategory != null) {
      data['sub_category'] = subCategory!.toJson();
    }
    data['description'] = description;
    data['is_favorite'] = isFavorite;
    if (productPhotos != null) {
      data['product_photos'] = productPhotos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
