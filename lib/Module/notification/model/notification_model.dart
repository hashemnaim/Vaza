class NotificationModel {
  String? message;
  int? code;
  bool? success;
  Data? data;

  NotificationModel({this.message, this.code, this.success, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
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
  int? unreadNotifications;
  List<NotificatioData>? notificatioData;
  Pagination? pagination;

  Data({this.unreadNotifications, this.notificatioData, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    unreadNotifications = json['unread_notifications'];
    if (json['data'] != null) {
      notificatioData = <NotificatioData>[];
      json['data'].forEach((v) {
        notificatioData!.add(NotificatioData.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unread_notifications'] = unreadNotifications;
    if (notificatioData != null) {
      data['data'] = notificatioData!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class NotificatioData {
  String? id;
  String? title;
  String? body;
  bool? isRead;
  String? createdAt;

  NotificatioData(
      {this.id, this.title, this.body, this.isRead, this.createdAt});

  NotificatioData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['is_read'] = isRead;
    data['created_at'] = createdAt;
    return data;
  }
}

class Pagination {
  int? currentPage;
  int? lastPage;
  String? firstPageUrl;
  String? lastPageUrl;
  String? nextPageUrl;
  String? prevPageUrl;
  int? from;
  int? to;
  int? perPage;
  int? total;

  Pagination(
      {this.currentPage,
      this.lastPage,
      this.firstPageUrl,
      this.lastPageUrl,
      this.nextPageUrl,
      this.prevPageUrl,
      this.from,
      this.to,
      this.perPage,
      this.total});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    firstPageUrl = json['first_page_url'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    prevPageUrl = json['prev_page_url'];
    from = json['from'];
    to = json['to'];
    perPage = json['per_page'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['last_page'] = lastPage;
    data['first_page_url'] = firstPageUrl;
    data['last_page_url'] = lastPageUrl;
    data['next_page_url'] = nextPageUrl;
    data['prev_page_url'] = prevPageUrl;
    data['from'] = from;
    data['to'] = to;
    data['per_page'] = perPage;
    data['total'] = total;
    return data;
  }
}
