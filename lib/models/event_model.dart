class OccasionsData {
  int? id;
  String? personName;
  String? type;
  String? date;
  bool? notificationStatus;

  OccasionsData(
      {this.personName, this.type, this.date, this.notificationStatus});

  OccasionsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    personName = json['person_name'];
    type = json['type'];
    date = json['date'];
    notificationStatus = json['notification_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['person_name'] = personName;
    data['type'] = type;
    data['date'] = date;
    data['notification_status'] = notificationStatus;
    return data;
  }
}
