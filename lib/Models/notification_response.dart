// To parse this JSON data, do
//
//     final notificationResponse = notificationResponseFromJson(jsonString);

import 'dart:convert';

NotificationResponse notificationResponseFromJson(String str) => NotificationResponse.fromJson(json.decode(str));

String notificationResponseToJson(NotificationResponse data) => json.encode(data.toJson());

class NotificationResponse {
  NotificationResponse({
    this.status,
    this.data,
  });

  bool? status;
  List<NotificationDataList>? data;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) => NotificationResponse(
    status: json["status"],
    data: List<NotificationDataList>.from(json["data"].map((x) => NotificationDataList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class NotificationDataList {
  NotificationDataList({
    this.id,
    this.userId,
    this.notification,
    this.invoiceId,
    this.orderId,
    this.status,
    this.deviceId,
    this.date,
    this.time,
    this.watched,
    this.types,
  });

  String? id;
  String? userId;
  String? notification;
  String? invoiceId;
  String? orderId;
  String? status;
  String? deviceId;
  String? date;
  String? time;
  String? watched;
  String? types;

  factory NotificationDataList.fromJson(Map<String, dynamic> json) => NotificationDataList(
    id: json["id"],
    userId: json["user_id"],
    notification: json["notification"],
    invoiceId: json["invoice_id"],
    orderId: json["order_id"],
    status: json["status"],
    deviceId: json["device_id"],
    date: json["date"],
    time: json["time"],
    watched: json["watched"],
    types: json["types"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "notification": notification,
    "invoice_id": invoiceId,
    "order_id": orderId,
    "status": status,
    "device_id": deviceId,
    "date": date,
    "time": time,
    "watched": watched,
    "types": types,
  };
}
