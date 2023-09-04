class IntroSliderModel {
  String? message;
  int? code;
  bool? success;
  List<DataIntroSlider>? data;

  IntroSliderModel({this.message, this.code, this.success, this.data});

  IntroSliderModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    success = json['success'];
    if (json['data'] != null) {
      data = <DataIntroSlider>[];
      json['data'].forEach((v) {
        data!.add(DataIntroSlider.fromJson(v));
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

class DataIntroSlider {
  int? id;
  String? title;
  String? subTitle;
  String? photo;

  DataIntroSlider({this.id, this.title, this.subTitle, this.photo});

  DataIntroSlider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subTitle = json['sub_title'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['sub_title'] = subTitle;
    data['photo'] = photo;
    return data;
  }
}
