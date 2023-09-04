import '../../../../models/user_model.dart';

UpdateUserModel updateUserModelFromJson(Map<String, dynamic> str) =>
    UpdateUserModel.fromJson(str);

Map<String, dynamic> updateUserModelToJson(UserData data) => data.toJson();

class UpdateUserModel {
  String? message;
  int? code;
  bool? success;
  UserData? data;

  UpdateUserModel({this.message, this.code, this.success, this.data});

  UpdateUserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    success = json['success'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
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
