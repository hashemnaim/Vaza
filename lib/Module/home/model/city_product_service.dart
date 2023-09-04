// import 'package:faza_app/models/product_model.dart';
// import 'package:faza_app/screens/home/category/model/category_model.dart';

// CityProductsModel cityProductsModelFromJson(Map<String, dynamic> str) =>
//     CityProductsModel.fromJson(str);

// Map<String, dynamic> cityProductsModelToJson(CityProductsModel data) =>
//     data.toJson();

// class CityProductsModel {
//   CityProductsModel({
//     required this.statusCode,
//     required this.status,
//     required this.message,
//     this.products,
//     this.categories,
//   });

//   int statusCode;
//   bool status;
//   String message;
//   List<Product>? products;
//   List<Category>? categories;

//   factory CityProductsModel.fromJson(Map<String, dynamic> json) =>
//       CityProductsModel(
//         statusCode: json["code"],
//         status: json["success"],
//         message: json["message"],
//         products: json["products"] == null
//             ? []
//             : List<Product>.from(
//                 json["products"].map((x) => Product.fromJson(x))),
//         categories: json["categories"] == null
//             ? []
//             : List<Category>.from(
//                 json["categories"].map((x) => Category.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "code": statusCode,
//         "success": status,
//         "message": message,
//         "products": products == null
//             ? []
//             : List<Product>.from(products!.map((x) => x.toJson())),
//         "categories": categories == null
//             ? []
//             : List<Category>.from(categories!.map((x) => x.toJson())),
//       };
// }
