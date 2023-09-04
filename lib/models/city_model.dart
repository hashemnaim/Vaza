class SelectCity {
  int? id;
  String? name;
  // String? deliveryPrice;

  SelectCity({
    this.id,
    this.name,
    // this.deliveryPrice,
  });

  SelectCity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    // deliveryPrice = json['delivery_price'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    // data['delivery_price'] = deliveryPrice;
    return data;
  }
}
