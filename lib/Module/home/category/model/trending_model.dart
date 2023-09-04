import '../../../../models/category_model.dart';

class TrendingModel {
  String? message;
  int? code;
  bool? success;
  List<TrendingData>? data;

  TrendingModel({this.message, this.code, this.success, this.data});

  TrendingModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    success = json['success'];
    if (json['data'] != null) {
      data = <TrendingData>[];
      json['data'].forEach((v) {
        data!.add(TrendingData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['code'] = code;
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TrendingData {
  int? id;
  String? title;
  List<CategoryData>? categories;

  TrendingData({this.id, this.title, this.categories});

  TrendingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['categories'] != null) {
      categories = <CategoryData>[];
      json['categories'].forEach((v) {
        categories!.add(CategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['photo'] = title;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
