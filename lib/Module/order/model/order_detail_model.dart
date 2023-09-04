CouponModel couponModelFromJsonMap(Map<String, dynamic> str) =>
    CouponModel.fromJson((str));

Map<String, dynamic> couponModelToJson(CouponModel data) => (data.toJson());

class CouponModel {
  CouponModel({
    required this.location,
    required this.lat,
    required this.lng,
    required this.deliveryDate,
    required this.deliveryTime,
    required this.recipientName,
    required this.recipientPhone,
    required this.recipientMessage,
    required this.type,
    required this.couponId,
    required this.orderItems,
  });

  String location;
  String lat;
  String lng;
  String deliveryDate;
  String deliveryTime;
  String recipientName;
  String recipientPhone;
  String recipientMessage;
  String type;
  int couponId;
  List<OrderItem> orderItems;

  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
        location: json["location"],
        lat: json["lat"],
        lng: json["lng"],
        deliveryDate: json["deliveryDate"],
        deliveryTime: json["deliveryTime"],
        recipientName: json["recipientName"],
        recipientPhone: json["recipientPhone"],
        recipientMessage: json["recipientMessage"],
        type: json["type"],
        couponId: json["couponId"],
        orderItems: List<OrderItem>.from(
            json["orderItems"].map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "location": location,
        "lat": lat,
        "lng": lng,
        "deliveryDate": deliveryDate,
        "deliveryTime": deliveryTime,
        "recipientName": recipientName,
        "recipientPhone": recipientPhone,
        "recipientMessage": recipientMessage,
        "type": type,
        "couponId": couponId,
        "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
      };
}

class OrderItem {
  OrderItem({
    required this.productId,
    required this.quantity,
  });

  int productId;
  int quantity;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        productId: json["productId"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "quantity": quantity,
      };
}
