import '../../../../models/event_model.dart';

class OccasionsModel {
  String? message;
  int? code;
  bool? success;
  List<OccasionsData>? data;

  OccasionsModel({this.message, this.code, this.success, this.data});

  OccasionsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    success = json['success'];
    if (json['data'] != null) {
      data = <OccasionsData>[];
      json['data'].forEach((v) {
        data!.add(OccasionsData.fromJson(v));
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
