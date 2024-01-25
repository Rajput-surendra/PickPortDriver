// To parse this JSON data, do
//
//     final orderStatusUpdate = orderStatusUpdateFromJson(jsonString);

import 'dart:convert';

OrderStatusUpdate orderStatusUpdateFromJson(String str) => OrderStatusUpdate.fromJson(json.decode(str));

String orderStatusUpdateToJson(OrderStatusUpdate data) => json.encode(data.toJson());

class OrderStatusUpdate {
  OrderStatusUpdate({
    this.status,
    this.data,
    this.meassge,
  });

  bool? status;
  List<dynamic>? data;
  String? meassge;

  factory OrderStatusUpdate.fromJson(Map<String, dynamic> json) => OrderStatusUpdate(
    status: json["status"],
    data: List<dynamic>.from(json["data"].map((x) => x)),
    meassge: json["meassge"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x)),
    "meassge": meassge,
  };
}
