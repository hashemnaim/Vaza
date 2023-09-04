MessageModel messageModelFromJson(Map<String, dynamic> str) =>
    MessageModel.fromJson((str));

Map<String, dynamic> messageModelToJson(MessageModel data) => (data.toJson());

class MessageModel {
  MessageModel({
    required this.statusCode,
    required this.status,
    required this.message,
  });

  int statusCode;
  String status;
  String message;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        statusCode: json["code"],
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": statusCode,
        "status": status,
        "message": message,
      };
}
