import '../../../../models/event_model.dart';

class OccasionsSingleModel {
  String? message;
  int? code;
  bool? success;
  OccasionsData? data;

  OccasionsSingleModel({this.message, this.code, this.success, this.data});

  OccasionsSingleModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    success = json['success'];
    data = json['data'] != null ? OccasionsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['code'] = code;
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
