import 'package:faza_app/models/product_model.dart';

class CartModel {
  String? message;
  int? code;
  bool? success;
  CartData? data;

  CartModel({this.message, this.code, this.success, this.data});

  CartModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    success = json['success'];
    data = json['data'] != null ? CartData.fromJson(json['data']) : null;
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

class CartData {
  int? id;
  int? orderNumber;
  String? location;
  String? address;
  String? longitude;
  String? latitude;
  String? deliveryDate;
  String? deliveryTime;
  String? recipientName;
  String? recipientMobile;
  String? message;
  String? note;
  String? status;

  String? cancelReason;
  String? paymentMethod;
  String? city;
  Coupon? coupon;

  Transaction? transaction;
  List<Units>? units;

  CartData(
      {this.id,
      this.orderNumber,
      this.location,
      this.address,
      this.longitude,
      this.latitude,
      this.deliveryDate,
      this.deliveryTime,
      this.recipientName,
      this.recipientMobile,
      this.message,
      this.coupon,
      this.note,
      this.status,
      this.cancelReason,
      this.paymentMethod,
      this.city,
      this.transaction,
      this.units});

  CartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    location = json['location'];
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    deliveryDate = json['delivery_date'];
    deliveryTime = json['delivery_time'];
    recipientName = json['recipient_name'];
    recipientMobile = json['recipient_mobile'];
    message = json['message'];
    note = json['note'];
    status = json['status'];
    coupon = json['coupon'] != null ? Coupon.fromJson(json['coupon']) : null;
    cancelReason = json['cancel_reason'];
    paymentMethod = json['payment_method'];
    city = json['city'];
    transaction = json['transaction'] != null
        ? Transaction.fromJson(json['transaction'])
        : null;
    if (json['units'] != null) {
      units = <Units>[];
      json['units'].forEach((v) {
        units!.add(Units.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_number'] = orderNumber;
    data['location'] = location;
    data['address'] = address;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['delivery_date'] = deliveryDate;
    data['delivery_time'] = deliveryTime;
    data['recipient_name'] = recipientName;
    data['recipient_mobile'] = recipientMobile;
    data['message'] = message;
    data['note'] = note;
    data['status'] = status;
    data['cancel_reason'] = cancelReason;
    data['payment_method'] = paymentMethod;
    data['city'] = city;
    if (transaction != null) {
      data['transaction'] = transaction!.toJson();
    }
    if (units != null) {
      data['units'] = units!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Coupon {
  int? id;
  String? title;
  String? code;
  String? discount;

  Coupon({this.id, this.title, this.code, this.discount});

  Coupon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    code = json['code'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['code'] = code;
    data['discount'] = discount;
    return data;
  }
}

class Transaction {
  int? id;
  num? transactionNumber;
  num? deliveryPrice;
  num? taxPercentage;
  num? commissionPercentage;
  num? mainPrice;
  num? totalPrice;
  bool? isPaid;

  Transaction(
      {this.id,
      this.transactionNumber,
      this.deliveryPrice,
      this.taxPercentage,
      this.commissionPercentage,
      this.mainPrice,
      this.totalPrice,
      this.isPaid});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionNumber = json['transaction_number'];
    deliveryPrice = json['delivery_price'] ?? 0;
    taxPercentage = json['tax_percentage'];
    commissionPercentage = json['commission_percentage'];
    mainPrice = json['main_price'];
    totalPrice = json['total_price'];
    isPaid = json['is_paid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['transaction_number'] = transactionNumber;
    data['delivery_price'] = deliveryPrice;
    data['tax_percentage'] = taxPercentage;
    data['commission_percentage'] = commissionPercentage;
    data['main_price'] = mainPrice;
    data['total_price'] = totalPrice;
    data['is_paid'] = isPaid;
    return data;
  }
}

class Units {
  int? id;
  ProductlData? product;
  int? quantity;
  num? totalPrice;
  String? discount;

  Units({this.id, this.product, this.quantity, this.totalPrice, this.discount});

  Units.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        json['product'] != null ? ProductlData.fromJson(json['product']) : null;
    quantity = json['quantity'];
    totalPrice = json['total_price'];
    discount = json['discount'] == null ? "0" : json['discount'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['quantity'] = quantity;
    data['total_price'] = totalPrice;
    data['discount'] = discount;
    return data;
  }
}
