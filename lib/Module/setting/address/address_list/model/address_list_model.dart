AddressListModel addressListModelFromJson(Map<String, dynamic> str) =>
    AddressListModel.fromJson(str);

Map<String, dynamic> addressListModelToJson(AddressListModel data) =>
    data.toJson();

class AddressListModel {
  AddressListModel({
    required this.statusCode,
    required this.success,
    required this.message,
    this.addresses,
  });

  int statusCode;
  bool success;
  String message;
  List<AddressData>? addresses;

  factory AddressListModel.fromJson(Map<String, dynamic> json) =>
      AddressListModel(
        statusCode: json["code"],
        success: json["success"],
        message: json["message"],
        addresses: json["data"] == []
            ? []
            : List<AddressData>.from(
                json["data"].map((x) => AddressData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": statusCode,
        "status": success,
        "message": message,
        "addresses": addresses == []
            ? []
            : List<AddressData>.from(addresses!.map((x) => x.toJson())),
      };
}

class AddressData {
  int? id;
  String? address;
  String? street;
  String? longitude;
  String? latitude;

  AddressData(
      {this.id, this.address, this.street, this.longitude, this.latitude});

  AddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    street = json['street'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['address'] = address;
    data['street'] = street;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    return data;
  }
}
