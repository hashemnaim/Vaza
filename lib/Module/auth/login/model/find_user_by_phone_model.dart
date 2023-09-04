import '../../../../models/user_model.dart';

FindUserByPhoneModel findUserByPhoneModelFromJson(Map<String, dynamic> str) =>
    FindUserByPhoneModel.fromJson((str));

Map<String, dynamic> findUserByPhoneModelToJson(FindUserByPhoneModel data) =>
    (data.toJson());

class FindUserByPhoneModel {
  FindUserByPhoneModel({
    required this.statusCode,
    required this.status,
    required this.message,
    this.user,
  });

  int statusCode;
  bool status;
  String message;
  UserData? user;

  factory FindUserByPhoneModel.fromJson(Map<String, dynamic> json) =>
      FindUserByPhoneModel(
        statusCode: json["code"],
        status: json["success"],
        message: json["message"],
        user:
            (json["data"] == {} || json["data"] == null || json["data"].isEmpty)
                ? null
                : UserData.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "code": statusCode,
        "status": status,
        "message": message,
        "user": user == {} || user == null ? null : user?.toJson(),
      };
}
