import 'package:faza_app/models/user_model.dart';

RegisterModel registerModelFromJson(Map<String, dynamic> str) =>
    RegisterModel.fromJson((str));

Map<String, dynamic> registerModelToJson(RegisterModel data) => (data.toJson());

class RegisterModel {
  RegisterModel({
    required this.statusCode,
    required this.success,
    required this.message,
    this.user,
  });

  int statusCode;
  bool success;
  String message;
  UserData? user;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        statusCode: json["code"],
        success: json["success"],
        message: json["message"],
        user:
            (json["data"] == {} || json["data"] == null || json["data"].isEmpty)
                ? null
                : UserData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": statusCode,
        "success": success,
        "message": message,
        "data": user == {} || user == null ? null : user?.toJson(),
      };
}
