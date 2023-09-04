VerifyPhoneModel verifyPhoneModelFromJson(Map<String, dynamic> str) =>
    VerifyPhoneModel.fromJson((str));

Map<String, dynamic> verifyPhoneModelToJson(VerifyPhoneModel data) =>
    (data.toJson());

class VerifyPhoneModel {
  VerifyPhoneModel({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.code,
  });

  int statusCode;
  String status;
  String message;
  int code;

  factory VerifyPhoneModel.fromJson(Map<String, dynamic> json) =>
      VerifyPhoneModel(
        statusCode: json["code"],
        status: json["success"],
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "code": statusCode,
        "success": status,
        "message": message,
      };
}
