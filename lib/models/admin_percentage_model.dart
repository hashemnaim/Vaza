AdminPercentageModel adminPercentageModelFromJson(Map<String, dynamic> str) =>
    AdminPercentageModel.fromJson((str));

Map<String, dynamic> adminPercentageModelToJson(AdminPercentageModel data) =>
    (data.toJson());

class AdminPercentageModel {
  String? message;
  int? code;
  bool? success;
  Data? data;

  AdminPercentageModel({this.message, this.code, this.success, this.data});

  AdminPercentageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  String? commission;
  String? tax;
  bool? isPayment;
  String? version;

  Data({this.commission, this.tax});

  Data.fromJson(Map<String, dynamic> json) {
    commission = json['commission'] == "" ? "0" : json['commission'];
    tax = json['tax'] == "" ? "0" : json['tax'];
    isPayment = bool.parse(json['isPayment'].toString());
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['commission'] = commission;
    data['tax'] = tax;
    data['isPayment'] = isPayment;
    data['version'] = version;
    return data;
  }
}
