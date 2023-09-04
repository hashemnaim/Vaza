ContactUsModel contactUsModelFromJson(Map<String, dynamic> str) =>
    ContactUsModel.fromJson(str);

Map<String, dynamic> contactUsModelToJson(ContactUsModel data) => data.toJson();

class ContactUsModel {
  ContactUsModel({
    required this.statusCode,
    required this.success,
    required this.message,
    // required this.contactUs,
  });

  int statusCode;
  bool success;
  String message;
  // ContactUs contactUs;

  factory ContactUsModel.fromJson(Map<String, dynamic> json) => ContactUsModel(
        statusCode: json["code"],
        success: json["success"],
        message: json["message"],
        // contactUs: ContactUs.fromJson(json["contactUs"]),
      );

  Map<String, dynamic> toJson() => {
        "code": statusCode,
        "success": success,
        "message": message,
        // "contactUs": contactUs.toJson(),
      };
}

class ContactUs {
  ContactUs({
    required this.isRead,
    required this.id,
    required this.subject,
    required this.message,
    required this.userId,
    required this.updatedAt,
    required this.createdAt,
  });

  bool isRead;
  int id;
  String subject;
  String message;
  int userId;
  DateTime updatedAt;
  DateTime createdAt;

  factory ContactUs.fromJson(Map<String, dynamic> json) => ContactUs(
        isRead: json["isRead"],
        id: json["id"],
        subject: json["subject"],
        message: json["message"],
        userId: json["userId"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "isRead": isRead,
        "id": id,
        "subject": subject,
        "message": message,
        "userId": userId,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
      };
}
