UserData userModelFromJson(Map<String, dynamic> str) =>
    UserData.fromJson((str));

Map<String, dynamic> userModelToJson(UserData data) => (data.toJson());

class UserData {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? photo;
  bool? verified;
  bool? adsNotification;
  bool? occasionsNotification;
  String? lang;

  UserData(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.photo,
      this.verified,
      this.adsNotification,
      this.occasionsNotification,
      this.lang});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    photo = json['photo'];
    verified = json['verified'];
    adsNotification = json['ads_notification'];
    occasionsNotification = json['occasions_notification'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['photo'] = photo;
    data['verified'] = verified;
    data['ads_notification'] = adsNotification;
    data['occasions_notification'] = occasionsNotification;
    data['lang'] = lang;
    return data;
  }
}
