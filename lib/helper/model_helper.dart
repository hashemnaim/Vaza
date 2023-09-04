class ModelHaedar {
  ModelHaedar({
    required this.code,
    required this.success,
    required this.message,
  });

  int code;
  bool success;
  String message;

  factory ModelHaedar.fromJson(Map<String, dynamic> json) => ModelHaedar(
        code: json["code"],
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "message": message,
      };
}
