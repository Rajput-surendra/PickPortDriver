// To parse this JSON data, do
//
//     final driverPaymentResponse = driverPaymentResponseFromJson(jsonString);

import 'dart:convert';

DriverPaymentResponse driverPaymentResponseFromJson(String str) =>
    DriverPaymentResponse.fromJson(json.decode(str));

String driverPaymentResponseToJson(DriverPaymentResponse data) =>
    json.encode(data.toJson());

class DriverPaymentResponse {
  DriverPaymentResponse({
    required this.status,
    required this.message,
  });

  bool status;
  String message;

  factory DriverPaymentResponse.fromJson(Map<String, dynamic> json) =>
      DriverPaymentResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
