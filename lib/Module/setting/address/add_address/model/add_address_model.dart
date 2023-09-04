AddAddressModel addAddressModelFromJson(Map<String, dynamic> str) =>
    AddAddressModel.fromJson((str));

Map<String, dynamic> addAddressModelToJson(AddAddressModel data) =>
    (data.toJson());

class AddAddressModel {
  AddAddressModel({
    required this.statusCode,
    required this.success,
    required this.message,
  });

  int statusCode;
  bool success;
  String message;

  factory AddAddressModel.fromJson(Map<String, dynamic> json) =>
      AddAddressModel(
        statusCode: json["code"],
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": statusCode,
        "status": success,
        "message": message,
      };
}
