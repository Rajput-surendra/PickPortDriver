// To parse this JSON data, do
//
//     final orderAcceptApiResponse = orderAcceptApiResponseFromJson(jsonString);

import 'dart:convert';

OrderAcceptApiResponse orderAcceptApiResponseFromJson(String str) => OrderAcceptApiResponse.fromJson(json.decode(str));

String orderAcceptApiResponseToJson(OrderAcceptApiResponse data) => json.encode(data.toJson());

class OrderAcceptApiResponse {
  OrderAcceptApiResponse({
    this.status,
    this.errorCode,
    this.errorLine,
    this.message,
    this.data,
  });

  int? status;
  int? errorCode;
  int? errorLine;
  String? message;
  List<dynamic>? data;


  factory OrderAcceptApiResponse.fromJson(Map<String, dynamic> json) => OrderAcceptApiResponse(
    status: json["status"],
    errorCode: json["error_code"],
    errorLine: json["error_line"],
    message: json["message"],
    data: List<dynamic>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "error_code": errorCode,
    "error_line": errorLine,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x)),
  };
}
