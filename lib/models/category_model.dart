class CategoryData {
  int? id;
  String? name;
  String? photo;
  bool? coverStatus;

  CategoryData({this.id, this.name, this.photo, this.coverStatus});

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    coverStatus = json['cover_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['photo'] = photo;
    data['cover_status'] = coverStatus;
    return data;
  }
}
