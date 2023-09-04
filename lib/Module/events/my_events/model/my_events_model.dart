import 'package:faza_app/models/event_model.dart';

MyEventModel myEventModelFromJson(Map<String, dynamic> str) =>
    MyEventModel.fromJson(str);

Map<String, dynamic> myEventModelToJson(MyEventModel data) => data.toJson();

class MyEventModel {
  MyEventModel({
    required this.statusCode,
    required this.success,
    required this.message,
    this.events,
  });

  int statusCode;
  bool success;
  String message;
  List<OccasionsData>? events;

  factory MyEventModel.fromJson(Map<String, dynamic> json) => MyEventModel(
        statusCode: json["code"],
        success: json["success"],
        message: json["message"],
        events: json["events"] == [] || json["events"] == null
            ? []
            : List<OccasionsData>.from(
                json["events"].map((x) => OccasionsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": statusCode,
        "success": success,
        "message": message,
        "events": events == []
            ? []
            : List<OccasionsData>.from(events!.map((x) => x.toJson())),
      };
}
