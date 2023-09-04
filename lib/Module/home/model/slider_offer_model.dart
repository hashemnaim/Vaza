import '../../../helper/model_helper.dart';

class SliderModel {
  ModelHaedar? modelHaedar;
  List<SliderData>? data;
  //   int statusCode;
  // bool success;
  // String message;

  SliderModel({
    //     required this.statusCode,
    // required this.success,
    // required this.message,
    required this.modelHaedar, this.data});

  SliderModel.fromJson(Map<String, dynamic> json) {
     
    if (json['data'] != null) {
      data = <SliderData>[];
      json['data'].forEach((v) {
        data!.add(SliderData.fromJson(v));
      });
    }
  }
}

class SliderData {
  int? id;
  String? title;
  String? subTitle;
  String? discount;
  String? photo;

  SliderData({this.id, this.title, this.subTitle, this.discount, this.photo});

  SliderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subTitle = json['sub_title'];
    discount = json['discount'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['sub_title'] = subTitle;
    data['discount'] = discount;
    data['photo'] = photo;
    return data;
  }
}
