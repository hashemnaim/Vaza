class ProductPhotos {
  int? id;
  String? photo;

  ProductPhotos({this.id, this.photo});

  ProductPhotos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['photo'] = photo;
    return data;
  }
}
