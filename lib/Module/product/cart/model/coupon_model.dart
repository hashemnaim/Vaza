CouponModel couponModelFromJson(Map<String, dynamic> str) =>
    CouponModel.fromJson((str));

Map<String, dynamic> couponModelToJson(CouponModel data) => (data.toJson());

class CouponModel {
  CouponModel({
    required this.statusCode,
    required this.success,
    required this.message,
  });

  int statusCode;
  bool success;
  String message;

  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
        statusCode: json["code"],
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": statusCode,
        "success": success,
        "message": message,
      };
}
